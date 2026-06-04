# Design — Tags comma-separated (Garment + Outfit)

- **Date** : 2026-06-04 (sem 23, Phase 1)
- **Branche** : `feat/tags-coma-separated`
- **Statut** : design validé, implémentation en mode coach (Chris écrit le code)

## Problème

La couche données des tags est en place (`Tag` scopé user, `Tagging` polymorphe, `has_many :tags, through:` sur `Garment` et `Outfit`), mais il n'existe aucun moyen d'**écrire** ni d'**afficher** des tags. Il faut un input texte « comma-separated » qui parse les noms, trouve-ou-crée les tags scopés user, et les affiche en pills.

Contrainte annexe : `Garment` et `Outfit` dupliquent déjà 2 lignes d'association tags identiques.

## Décisions actées

| Décision | Choix retenu | Alternatives écartées |
|---|---|---|
| Périmètre | **Garment + Outfit** d'un coup | Un seul model d'abord (parsing identique → autant mutualiser) |
| Normalisation | **downcase + strip + dedupe** | Garder la casse (faux find case-insensitif requis) ; Capitalize (casse les noms propres) |
| Architecture | **Concern `Taggable`** inclus dans les deux models | Méthodes dupliquées ; form object/service (overkill, casse pattern gros models) |
| Moment de l'écriture | **callback `after_save`** | Setter immédiat (tags orphelins si validation échoue) |
| UI input | **`text_field :tag_names` simple** | Combobox/autocomplete (reporté backlog) |

Raisons clés : le concern *réduit* la duplication existante (associations polymorphes) au lieu de la déplacer ; downcase aligne le stockage sur la validation `case_sensitive: false` et neutralise le piège `find_or_create_by` (le `WHERE name = 'casual'` exact retombe toujours sur le même tag) ; `after_save` garantit zéro tag orphelin (ne tourne que si la validation passe) et l'atomicité (création des tags dans la transaction de save).

## Architecture

### Unité centrale : `app/models/concerns/taggable.rb`

Module Ruby inclus dans `Garment` et `Outfit`. Absorbe les associations polymorphes (retirées des models) + expose le virtual attribute `tag_names`.

**Contrat** :

- **`included do`** : `has_many :taggings, as: :taggable, dependent: :destroy` + `has_many :tags, through: :taggings` + `after_save :sync_tags`.
- **`tag_names=(value)`** (setter) : parse la string → `value.to_s.split(",").map { strip.downcase }.reject(&:blank?).uniq` → stocke dans `@tag_names` (variable tampon, pas d'écriture base).
- **`tag_names`** (getter) : `tags.map(&:name).join(", ")` → pré-remplit le champ en edit.
- **`sync_tags`** (private, `after_save`) :
  - `return if @tag_names.nil?` → garde : champ non soumis = tags préservés.
  - `self.tags = @tag_names.map { |name| user.tags.find_or_create_by(name: name) }`.

**Pièges encodés** :

- `nil` ≠ `[]` : `nil` = champ non envoyé (préserver) ; `[]` = champ vidé (effacer). Ne PAS utiliser `blank?` dans la garde (rendrait l'effacement impossible).
- `after_save` et non `before_save` (besoin de l'`id` pour `taggable_id`) ni `after_commit` (on veut l'écriture des tags dans la transaction).
- **À vérifier en console** : `self.tags = [...]` dans `after_save` (has_many through polymorphe, Rails 8.1) écrit bien les `taggings` immédiatement sur un record persisté.

### Controllers

Ajout de `:tag_names` aux params permis (aucune logique métier ajoutée) :

- `garment_params` : `[ :name, :color, :description, :brand, :category_id, :photo, :tag_names ]`
- `outfit_params` : `[ :name, :description, :tag_names, garment_ids: [] ]`
- Anti-N+1 affichage : `includes(:tags)` sur les requêtes index/show qui rendent les pills.

### Forms

`f.text_field :tag_names` dans `_form` Garment + Outfit, stylé comme les autres champs, avec hint « Séparez par des virgules ». Pré-remplissage automatique via le getter en edit.

### Affichage — pills

Partial réutilisable `app/views/shared/_tags.html.erb`, prend un `taggable` en local, boucle sur `taggable.tags` → pills Tailwind. Branché sur `show` Garment + `show` Outfit.

## Tests (Minitest)

- `tag_names=` parse/normalise/dédupe (`"Casual, casual , "` → `["casual"]`).
- Création garment avec tags → tags créés, liés, scopés user.
- Re-soumission du même nom → pas de doublon (`find_or_create_by`).
- Champ vidé (`""` → `[]`) → tags retirés ; champ non soumis (`nil`) → tags préservés.
- Garment invalide → aucun tag orphelin créé.

## Hors périmètre (backlog)

- Combobox/autocomplete sur l'input tags (`FEATURES_FUTURES.md`).
- Recherche/filtres par tag (planifié sem 24).
- Pills tags dans l'index (à décider — l'index Outfit a déjà des pills garments).

## Tâche annexe du jour

Gem `bullet` (groupes `development`/`test`) : détection N+1 + eager loading inutile. Prolonge le combat anti-N+1 du collage (2026-06-03). Peut déborder sur sem 24 (déjà 🟡).
