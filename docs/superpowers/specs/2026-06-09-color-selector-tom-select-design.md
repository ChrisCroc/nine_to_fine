# Design — Color selector avec Tom Select (form Garment)

- **Date** : 2026-06-09 (sem 24, Phase 1)
- **Branche** : `feat/categories-colorpicker` (existante, déjà utilisée pour l'ajout des 3 catégories Dress/Suit/Swimwear seedées le matin)
- **Statut** : design validé, implémentation en mode coach (Chris écrit le code)

## Problème

Le champ `color` du form Garment (`app/views/garments/_form.html.erb` ligne 13) est actuellement un `text_field` libre. Conséquences :

- **UX pauvre** : l'user tape librement, ce qui a produit une **pollution de 12 valeurs FR/composées** en dev (cf. PR #83 sem 24 : "noir", "rouges", "light grey & purple", "blanc " avec espace…) corrigée par normalisation manuelle + activation de la validation `inclusion: { in: COLORS, allow_blank: true }`.
- **Mauvaise représentation** : la couleur est un **attribut visuel par essence**, représenté en texte plat. L'user doit faire un effort cognitif pour visualiser ce qu'est "Beige" vs "Brown" vs "Grey" (3 tons sémantiquement proches).
- **Effort à chaque création/édition** : chaque nouvelle pièce demande de re-taper le nom exact d'une couleur de la palette de 12. Friction inutile.

Objectif : remplacer le `text_field` par un **selector pré-rempli** qui rend visible la couleur (pastille hex) à côté du nom, en s'appuyant sur **Tom Select déjà installé** dans le projet (PR #55 sem 23 pour la combobox Outfit).

## Décisions actées

| Décision | Choix retenu | Alternatives écartées |
|---|---|---|
| Type de selector | **`<select>` natif progressivement enhanced par Tom Select** avec rendering custom (pastille hex + label) | `<select>` natif simple (pas de pastille, UX pauvre) ; pills cliquables Stimulus (casse symétrie avec category, 12 swatches = grid encombrant dans le form) |
| Mapping name → hex | **Constante `Garment::COLOR_HEX`** dans `app/models/garment.rb` (miroir gelé de `COLORS`) | Hash hardcodé dans le controller (mauvaise localité) ; data-attributes uniquement (duplique l'info à chaque render) ; YAML config (overkill V1) |
| Source des hex | **Palette Tailwind v4 shade 500** (`#ef4444` pour red, `#3b82f6` pour blue, etc.) | Hex personnalisés (cohérence visuelle cassée avec le reste du site) ; CSS vars (couplage trop fort runtime) |
| Stimulus controller | **`color_select_controller.js` dédié** (séparé de `select_controller.js` Outfit) | Réutiliser `select_controller.js` (configs Tom Select diff : remove_button N/A pour color qui est single-select, render custom uniquement pour color) ; sous-classe (overkill) |
| JS désactivé | **Graceful degradation** sur `<select>` natif (sans pastille) | Bloquer la sélection (sur-ingénierie pour V1) |
| Tests | **Pas de Minitest dédié** (vue visuelle, validation `inclusion` déjà testée) | Test system Capybara (reporté setup RSpec mercredi 10 juin) |

Raisons clés :
- **Tom Select déjà installé** : sa réutilisation amortit l'investissement initial (lib non orpheline avec 1 seule utilisation) et installe un pattern "Tom Select-based selector" réutilisable quand category évoluera vers une UX riche aussi.
- **Argument UX fondamental** : un attribut visuel doit être représenté visuellement. Sans cela, lecture cognitive + erreur de saisie.
- **Argument portfolio** : montrer la maîtrise de la limitation des `<option>` natifs (non stylables) + le choix conscient d'une lib comme Tom Select = signal expérimenté.

## Architecture

### Unité 1 : `Garment::COLOR_HEX` (model)

Constante hash gelée dans `app/models/garment.rb`, miroir de la constante `COLORS` existante. Une entrée par couleur.

**Contrat** :

```ruby
COLOR_HEX = {
  "black"  => "#000000",
  "white"  => "#ffffff",
  "grey"   => "#6b7280",   # Tailwind gray-500
  "beige"  => "#d6c1a3",   # Tailwind beige custom (proche de stone-300)
  "brown"  => "#a16207",   # Tailwind amber-700
  "red"    => "#ef4444",   # Tailwind red-500
  "orange" => "#f97316",   # Tailwind orange-500
  "yellow" => "#eab308",   # Tailwind yellow-500
  "green"  => "#22c55e",   # Tailwind green-500
  "blue"   => "#3b82f6",   # Tailwind blue-500
  "purple" => "#a855f7",   # Tailwind purple-500
  "pink"   => "#ec4899"    # Tailwind pink-500
}.freeze
```

**Invariant testable** : `COLOR_HEX.keys.sort == COLORS.sort` (toutes les couleurs de la palette ont un hex défini). Test Minitest 1 ligne à ajouter dans `garment_test.rb` pour prévenir le drift si on ajoute une couleur à `COLORS` sans la mapper.

### Unité 2 : `color_select_controller.js` (Stimulus)

Fichier nouveau `app/javascript/controllers/color_select_controller.js`. Instancie Tom Select sur l'élément avec rendering custom des options.

**Contrat** :

```js
import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="color-select"
export default class extends Controller {
  connect() {
    this.select = new TomSelect(this.element, {
      placeholder: "Choose a color",
      dropdownParent: "body",
      render: {
        option: (data, escape) => this.renderRow(data, escape),
        item:   (data, escape) => this.renderRow(data, escape)
      }
    })
  }

  disconnect() {
    this.select?.destroy()
  }

  renderRow(data, escape) {
    const hex = escape(data.hex || "#cccccc")
    const text = escape(data.text)
    return `<div class="flex items-center gap-2">
      <span class="inline-block w-3 h-3 rounded-full ring-1 ring-zinc-300" style="background:${hex}"></span>
      ${text}
    </div>`
  }
}
```

**Pièges encodés** :

- `dropdownParent: "body"` pour éviter clip dans des containers avec `overflow:hidden` (pattern déjà rodé sur `select_controller.js`).
- `escape()` fourni par Tom Select sur **toutes** les interpolations user-controlled (anti-XSS, même si la `name` couleur vient de notre palette curatée, défense en profondeur).
- `disconnect()` avec `?.destroy()` (safe navigation : si `connect` a planté avant l'assignation, on évite un `TypeError`).
- Fonction `renderRow` extraite pour éviter la duplication entre `option` (dropdown) et `item` (valeur sélectionnée affichée).

### Unité 3 : modification du form (vue)

`app/views/garments/_form.html.erb` ligne 11-17 (bloc color), remplacement du `text_field` par `select`.

**Avant** :

```erb
<%= f.label :color, class: "..." %>
<%= f.text_field :color, class: "..." %>
```

**Après** :

```erb
<%= f.label :color, class: "..." %>
<%= f.select :color,
      Garment::COLORS.map { |c| [c.capitalize, c, { "data-hex": Garment::COLOR_HEX[c] }] },
      { prompt: "Choose a color", include_blank: false },
      { class: "block w-full ...",
        data: { controller: "color-select" } } %>
```

**Pièges encodés** :

- `Garment::COLORS.map { |c| [label, value, html_options] }` : convention Rails `options_for_select` pour passer des **data-attributes par option** (le 3e élément du tuple). C'est ce qui injecte `data-hex` que Tom Select lit ensuite via `data.hex` dans la `render` function.
- `c.capitalize` : présentation en Title Case dans le dropdown (UI convention), stockage en lowercase en DB (cohérence avec `COLORS` + `inclusion`).
- 4 args au `f.select` : `(method, choices, options, html_options)`. Ne pas confondre les 2 derniers hashes (sinon le `data-controller` passe en `options`, ignoré).
- Erreur affichée ligne 14-16 : **inchangé** (même partial d'erreur que les autres champs).

### Unité 4 : CSS pastille (optionnel)

Aucun CSS dédié nécessaire car les classes Tailwind utility (`inline-block w-3 h-3 rounded-full ring-1 ring-zinc-300` + `style="background:${hex}"`) sont rendues inline dans `renderRow`. Tailwind les détecte au build via le scan statique (classes en string literal dans le JS).

**À vérifier** : la classe `gap-2` et les classes Tailwind du render sont bien détectées par le scanner Tailwind (qui lit les `*.js`). Si non, ajouter le chemin `app/javascript/**/*.js` dans la config Tailwind (déjà inclus dans `tailwindcss-rails` par défaut Rails 8).

## Data flow

1. **Page open (new/edit)** :
   - Controller `new`/`edit` ne change pas (`@categories` déjà set par `set_categories`).
   - Vue render le `<select>` avec 12 `<option value="red" data-hex="#ef4444">Red</option>` (etc.).
   - Stimulus `connect()` se déclenche → Tom Select prend le relais → dropdown stylisé avec pastilles.

2. **User clique une option** :
   - Tom Select met à jour la valeur de l'`<select>` underlying via `setValue("red")`.
   - Affichage du `item` (la valeur sélectionnée visible quand le dropdown est fermé) utilise la même `renderRow` → pastille rouge + "Red" visible.

3. **User submit** :
   - Browser sérialise le form. `params[:garment][:color]` = `"red"` (la value du `<option>` sélectionné).
   - Controller `create`/`update` → `garment_params.permit(..., :color, ...)` (déjà en place).
   - `Garment.new(color: "red")` ou `Garment.update(color: "red")`.
   - Validation `inclusion: { in: COLORS, allow_blank: true }` vérifie que "red" est dans la palette → OK.
   - Save → DB.

4. **JS désactivé** :
   - Tom Select ne s'instancie pas.
   - `<select>` natif marche (texte pur sans pastille).
   - Submit pareil, validation pareil. Graceful degradation.

## Error handling

| Cas | Comportement |
|---|---|
| User submit sans choisir | Validation `presence` échoue → erreur affichée ligne 14-16 (inchangé) |
| User soumet une value pas dans `COLORS` (devtools manipulation) | Validation `inclusion` échoue → erreur affichée |
| JS désactivé | `<select>` natif sert de fallback, sans pastille mais fonctionnel |
| Tom Select crashe à `connect()` | `disconnect()` safe-nav `this.select?.destroy()` ne plante pas. Le `<select>` natif reste accessible |
| Drift `COLORS` vs `COLOR_HEX` (couleur ajoutée à l'un, pas à l'autre) | Test Minitest invariant `COLOR_HEX.keys.sort == COLORS.sort` (à ajouter dans `garment_test.rb`) attrape le drift |

## Testing

### Tests automatisés (ajoutés cette session)

- **`garment_test.rb` — invariant `COLOR_HEX`** : `assert_equal Garment::COLORS.sort, Garment::COLOR_HEX.keys.sort`. 1 ligne. Filet anti-drift.

### Pas de tests ajoutés (justification)

- **Vue/UI** : le selector est visuel. Test système Capybara possible, mais reporté au setup RSpec mercredi 10 juin (`bin/rails generate rspec:install` + factory_bot). Mécanique : `visit new_garment_path` → `select "Red", from: "Color"` → `click "Create Garment"` → assert sur `Garment.last.color == "red"`.
- **Validation `inclusion`** : déjà couverte par les tests existants depuis PR #83 sem 24.

### Vérification manuelle (checklist)

- [ ] `/garments/new` ouvert → voir le dropdown avec 12 options + pastille colorée à gauche de chaque label.
- [ ] Sélectionner "Red" → la valeur sélectionnée affichée avec pastille rouge.
- [ ] Submit avec name/category remplis → garment créé avec `color: "red"`.
- [ ] `/garments/<id>/edit` → le dropdown s'affiche pré-rempli sur "Red" avec sa pastille.
- [ ] Submit sans changer la couleur → garment update sans erreur.
- [ ] DevTools, désactiver JS → recharger → voir le `<select>` natif texte pur, fonctionnel.

## Risques / pièges anticipés (récap)

1. **CSS de pastille non détecté par Tailwind** : classes utility dans une string JS — vérifier que le scan `tailwindcss-rails` lit `app/javascript/**/*.js`. Sinon, ajouter à la config.
2. **Conflit data-controller** : ne PAS mettre `data-controller="select color-select"` (les 2 controllers branchent Tom Select sur le même élément → crash). Le `<select>` color ne porte que `color-select`.
3. **Idempotence Stimulus** : si Turbo recharge la frame contenant le form, Stimulus appelle `disconnect()` puis `connect()`. Le `?.destroy()` puis `new TomSelect()` doit pouvoir se rejouer N fois sans accumulation d'instances. (Cas vu sur `select_controller.js`, déjà rodé.)
4. **Mapping hex désynchronisé du seed** : si on ajoute une couleur à `COLORS` sans la mapper dans `COLOR_HEX`, le `data-hex` sera `nil` → la pastille affiche `#cccccc` (fallback du `renderRow`). Visible visuellement mais silencieux côté validation. **Test invariant** prévient ça.
5. **Couleur "white" sur fond blanc** : la pastille blanche `#ffffff` sera invisible sans `ring-1 ring-zinc-300` (anneau de séparation). Inclus dans `renderRow`.

## Implémentation (ordre)

1. **Constante `COLOR_HEX`** + test invariant dans `garment_test.rb`. Vérifier : `bin/rails test test/models/garment_test.rb`.
2. **Stimulus controller** `app/javascript/controllers/color_select_controller.js`. Vérifier : ouvrir `/garments/new` dans la console JS, voir `Stimulus.controllers` lister `color-select`.
3. **Form vue** : remplacer `f.text_field :color` par `f.select :color` (cf. Unité 3).
4. **Vérification manuelle** complète selon la checklist.
5. Commit en mode coach (Chris). PR séparée ou append à la branche `feat/categories-colorpicker` (au choix de Chris).

## Estimation

~30 min total (5 min constante + test + 15 min Stimulus + 5 min vue + 5 min vérif manuelle).

## Liens

- [[query-objects-pipeline-inject-and-dynamic-dispatch]] — pattern `COLORS` mis en place sem 24.
- [[inclusion-validation-with-allow-blank]] — validation `inclusion` déjà en place sur `color`.
- [[tom-select-importmap-stimulus]] — pattern Tom Select rodé sem 23, à réutiliser.
- `FEATURES_FUTURES.md` § "Multi-color par garment" — extension future (Postgres array ou table dédiée) qui imposera de revoir ce design.
- `docs/superpowers/specs/2026-06-04-tags-comma-separated-design.md` — précédent pattern de modification du form Garment (pour le style de spec).
