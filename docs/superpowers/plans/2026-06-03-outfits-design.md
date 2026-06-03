# Refonte visuelle des vues Outfit — Plan d'implémentation

> **Mode coach** : ce plan est la checklist de Chris pour l'après-midi. Chris écrit 100 % du code de prod. Claude ne code pas ; il coache, challenge et relit par tâche. Les snippets fournis ci-dessous sont volontairement limités aux bits **non-évidents et corrects-critiques** (eager loading, tri préservant l'eager load, calcul du cap). Le markup ERB/Tailwind est **à écrire par Chris**.

**Goal** : remplacer les placeholders photo des vues Outfit par un collage adaptatif (mosaïque plafonnée à 4 tuiles) construit à partir des photos des garments.

**Architecture** : un partial unique `outfits/_collage.html.erb`, taille-agnostique, consommé par `show` et `index`. Tri par `category.position`, plafond à 4 tuiles avec compteur `+N`.

**Tech Stack** : Rails 8.1, ERB, Tailwind v4, Active Storage (variants WebP existants), PostgreSQL.

**Spec** : `docs/superpowers/specs/2026-06-03-outfits-design-design.md`

**Convention commit** : `type: short description` en anglais. Tu committes toi-même (mode coach).

**Vérification** : pas de RSpec sur les vues (RSpec arrive sem 24). Vérification **manuelle au navigateur** sur une matrice de N + audit `bullet`.

---

## Carte des fichiers

| Fichier | Action | Responsabilité |
|---|---|---|
| `app/views/outfits/_collage.html.erb` | **Créer** | Rendre les photos des garments d'un outfit en mosaïque plafonnée (unité réutilisable) |
| `app/views/outfits/show.html.erb` | Modifier (l. 4-7) | Injecter le collage dans la zone photo ~60 % |
| `app/views/outfits/index.html.erb` | Modifier (l. 23-24 + l. 30-32) | Injecter le collage dans la card + supprimer le bloc `tags` codé en dur |
| `app/controllers/outfits_controller.rb` | Modifier (`index`) | Eager loading anti N+1 |

---

## Task 1 : Créer le partial `_collage.html.erb`

**Files**
- Create: `app/views/outfits/_collage.html.erb`

C'est le cœur du chantier. Découpe-le en 3 sous-étapes.

- [ ] **Step 1 — Préambule Ruby (fourni : correct-critique)**

En tête de partial, calcule la collection triée et la logique de cap. **Ce snippet t'est donné** parce que le piège est non-évident :

```erb
<%# `sort_by` (Ruby) et non `.order` (SQL) : le controller eager-load déjà
    garments + category ; un .order relancerait une requête et casserait l'eager load. %>
<% garments = outfit.garments.sort_by { |g| g.category.position } %>
<% count    = garments.size %>
<% visible  = count > 4 ? garments.first(3) : garments %>
<% overflow = count > 4 ? count - 3 : 0 %>
<% slots    = count > 4 ? 4 : count %>
```

⚠️ **Question de vérification avant de continuer** : pourquoi `sort_by` en Ruby casse-t-il l'eager load si on écrit `outfit.garments.order("categories.position")` à la place ? (Réponds-moi avant de coder le reste.)

- [ ] **Step 2 — Conteneur grid + layouts par `slots`**

Le conteneur remplit son parent (`h-full w-full`) et applique une grille selon `slots`. Mapping à implémenter **toi-même** en Tailwind :

| `slots` | Grille | Cas spécial |
|---|---|---|
| 1 | 1 col, 1 row | — |
| 2 | 2 cols, 1 row | — |
| 3 | 2 cols, 2 rows | 3ᵉ tuile en `col-span-2` |
| 4 | 2 cols, 2 rows | — |

À toi d'écrire : le `case slots` (ou un helper de classes), le `gap`, et la classe `col-span-2` conditionnelle sur la dernière tuile quand `slots == 3`.

⚠️ **Piège à anticiper** : les classes Tailwind dynamiques type `grid-cols-#{n}` ne sont **pas** détectées par le scan statique JIT (cf. ta note [[theme-variables-and-directives]]). Écris des classes **littérales** dans chaque branche du `case`, pas interpolées.

- [ ] **Step 3 — Rendu d'une tuile + fallback + compteur**

Pour chaque garment de `visible` : tuile blanche, `image_tag garment.photo.variant(...)` en `object-contain` (calque-toi sur `garments/show.html.erb:7`). Fallback si `!garment.photo.attached?` : tuile blanche avec `garment.name.first`. Si `overflow > 0` : 4ᵉ tuile compteur, fond `bg-zinc-900 text-champagne`, contenu `+<%= overflow %>`.

À toi d'écrire le markup. Pense au `object-contain` + fond blanc (sinon tu reproduis le piège `object-cover` qui rogne, cf. [[object-fit-and-aspect-ratio]]).

- [ ] **Step 4 — Commit**

```bash
git add app/views/outfits/_collage.html.erb
git commit -m "feat: add reusable outfit collage partial"
```

---

## Task 2 : Brancher le collage dans `show`

**Files**
- Modify: `app/views/outfits/show.html.erb:4-7`

- [ ] **Step 1 — Remplacer le placeholder**

Dans la zone `md:row-span-3` (la div « Photo (coming soon) »), remplace le contenu par :

```erb
<%= render "collage", outfit: @outfit %>
```

Vérifie que la div parente garde bien ses dimensions (`md:row-span-3`, `aspect-square` en mobile) — c'est elle qui dimensionne, le partial remplit.

- [ ] **Step 2 — Vérification manuelle**

```bash
bin/rails server
```
Ouvre un outfit existant. Attendu : la zone photo affiche le collage des garments, plus le placeholder gris.

- [ ] **Step 3 — Commit**

```bash
git add app/views/outfits/show.html.erb
git commit -m "feat: render collage in outfit show photo zone"
```

---

## Task 3 : Brancher le collage dans `index` + nettoyer les tags

**Files**
- Modify: `app/views/outfits/index.html.erb:23-24` (placeholder photo)
- Modify: `app/views/outfits/index.html.erb:30-32` (bloc `tags` en dur)

- [ ] **Step 1 — Remplacer le placeholder photo de la card**

Dans la card (la div `h-48` « Photo »), remplace par :

```erb
<%= render "collage", outfit: outfit %>
```

Note la variable de boucle `outfit` (locale), pas `@outfit`.

- [ ] **Step 2 — Supprimer le bloc tags codé en dur**

Retire les lignes 30-32 (`<div class="rounded-xl bg-zinc-200 p-1"><h2>tags</h2></div>`). Les vrais tags arrivent sem 24 ; on ne laisse pas de placeholder mort.

- [ ] **Step 3 — Vérification visuelle**

Recharge `/outfits`. Attendu : chaque card montre le collage en miniature, plus de « tags » fantôme.

- [ ] **Step 4 — Commit**

```bash
git add app/views/outfits/index.html.erb
git commit -m "feat: render collage in outfit index cards, drop tags placeholder"
```

---

## Task 4 : Eager loading anti N+1 sur `index`

**Files**
- Modify: `app/controllers/outfits_controller.rb` (action `index`)

- [ ] **Step 1 — Charger les associations (fourni : correct-critique)**

Le collage de l'index itère outfits → garments → photo + category. Sans eager loading = N+1. Remplace l'assignation de `@outfits` dans `index` par :

```ruby
@outfits = current_user.outfits
                       .includes(garments: [ :category, { photo_attachment: :blob } ])
```

⚠️ **Question de vérification** : pourquoi `photo_attachment: :blob` et pas juste `:photo` dans le `includes` ? (Indice : `has_one_attached` génère quelles associations sous le capot ?)

- [ ] **Step 2 — Prouver l'absence de N+1**

Si `bullet` est déjà installé (sinon, c'est ta tâche « setup bullet » de la semaine — fais-la d'abord) :
```bash
bin/rails server
```
Visite `/outfits` avec plusieurs outfits multi-garments. Attendu : **aucune** alerte Bullet dans le log / l'overlay. Avant le `includes`, tu dois la voir → fais le test dans les deux sens pour comprendre.

- [ ] **Step 3 — Commit**

```bash
git add app/controllers/outfits_controller.rb
git commit -m "perf: eager-load garments, categories and photos on outfits index"
```

---

## Task 5 : Matrice de vérification manuelle (la recette)

**Files** : aucun (validation).

- [ ] **Step 1 — Créer les outfits de test**

Via l'UI, crée des outfits à **1, 2, 3, 4, 5, 7** garments. Inclus au moins un garment **sans photo** dans l'un d'eux.

- [ ] **Step 2 — Vérifier chaque layout** (cocher au fur et à mesure)

- [ ] N=1 → 1 tuile plein cadre
- [ ] N=2 → 2 tuiles côte à côte
- [ ] N=3 → 2×2, 3ᵉ tuile en bas large (`col-span-2`)
- [ ] N=4 → 2×2 plein
- [ ] N=5 → 3 tuiles + compteur `+2`
- [ ] N=7 → 3 tuiles + compteur `+4`
- [ ] Garment sans photo → tuile avec initiale, pas de trou
- [ ] **Ordre** : un outfit mixant catégories rend les tuiles Top → Bottom → Outerwear → Footwear → Accessories

- [ ] **Step 3 — Vérifier les deux conteneurs**

Le **même** partial doit bien rendre en grand (`show`) et en petit (`index`) sans paramètre de taille (preuve qu'il est taille-agnostique).

- [ ] **Step 4 — Commit final éventuel**

Si tu as ajusté des classes pendant la recette :
```bash
git add app/views/outfits/_collage.html.erb
git commit -m "style: polish collage tile sizing across show and index"
```

---

## Couverture spec (self-review)

- Collage adaptatif → Task 1 ✅
- Mosaïque plafonnée 4 + `+N` → Task 1 step 1+3 ✅
- Ordre `category.position` → Task 1 step 1 + Task 5 step 2 ✅
- Partial réutilisable taille-agnostique → Task 1 + Task 2/3 + Task 5 step 3 ✅
- `show` branché → Task 2 ✅
- `index` branché + nettoyage tags → Task 3 ✅
- N+1 eager loading → Task 4 ✅
- Fallback sans photo → Task 1 step 3 + Task 5 ✅
- Tests : manuel (RSpec reporté sem 24) → Task 5 ✅

Hors scope V1 (mannequin, raffinement 1-tuile-par-catégorie, variant dédié index, re-tune positions verticales) : non planifié, backlog spec.
