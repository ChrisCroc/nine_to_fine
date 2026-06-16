# Design — Commentaires sur Outfit (broadcast Turbo Streams)

**Date** : 2026-06-16 (sem 25, mardi)
**Feature** : US21 — commenter une tenue, avec diffusion temps réel via Turbo Streams.
**Pattern de référence** : Likes (livré lundi 15, PR #114/#115). On réplique le pipeline broadcast + counter_cache, avec une nuance majeure (liste qui grandit vs compteur qui change).

## Objectif

Permettre à un utilisateur connecté de poster et supprimer des commentaires sous une tenue (`Outfit#show`). Les commentaires apparaissent/disparaissent en temps réel chez tous les utilisateurs présents sur la page, sans rechargement.

## Décisions tranchées (et pourquoi)

1. **FK directe `Comment belongs_to :outfit`** — *pas* polymorphic (contrairement à `Like`).
   - On commente une *tenue* (assemblage), pas un vêtement isolé : pas de besoin produit pour commenter un `Garment`.
   - Si une marketplace (type Vinted) est intégrée plus tard, c'est *elle* qui gère les commentaires sur les articles en vente, pas Nine to Fine.
   - Revenir en arrière (FK → polymorphic) = migration de routine. Décision *bon marché à défaire* → on choisit le plus simple maintenant (YAGNI assumé).
   - Divergence assumée avec `Like` (polymorphic) : documentée ici, à reporter dans le schéma `CLAUDE.md`.

2. **Affichage antéchronologique** (plus récent en haut) → scope `order(created_at: :desc)` + hook `broadcast_prepend_to`.
   - Raison UI : l'activité fraîche est visible immédiatement, sans scroller.

3. **CRUD V1 = create + destroy seulement.** `update` (édition inline) reporté → `FEATURES_FUTURES.md` (évolution certaine, pas V1).

4. **`body` : `presence: true, length: { maximum: 1000 }`.**

5. **`comments_count` counter_cache sur `Outfit`** + compteur « N comments » affiché sur la page show (comme les likes). Alimente aussi un futur feed/index sans N+1.

6. **Ordre dans l'association** `has_many :comments, -> { order(created_at: :desc) }` (pas de `default_scope`, pas de scope nommé).
   - Un seul lieu d'affichage, tri toujours souhaité, zéro risque d'oubli, cohérent avec le `prepend`.

## Modèle de données

Migration :
```ruby
create_table :comments do |t|
  t.references :user,   null: false, foreign_key: true
  t.references :outfit, null: false, foreign_key: true
  t.text :body, null: false
  t.timestamps
end
# + sur outfits :
add_column :outfits, :comments_count, :integer, default: 0, null: false
```
- `references` crée les index sur `user_id` et `outfit_id` automatiquement.
- `body null: false` = garde-fou DB ; la validation `presence` Ruby donne le message user-friendly (defense-in-depth, comme `Like`).

Model `Comment` :
```ruby
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :outfit, counter_cache: :comments_count

  validates :body, presence: true, length: { maximum: 1000 }

  after_create_commit -> {
    broadcast_prepend_to outfit,
      target: ActionView::RecordIdentifier.dom_id(outfit, :comments),
      partial: "comments/comment", locals: { comment: self }
    broadcast_replace_to outfit,
      target: ActionView::RecordIdentifier.dom_id(outfit, :comments_count),
      partial: "comments/comments_count", locals: { outfit: outfit }
  }

  after_destroy_commit -> {
    broadcast_remove_to outfit  # retire dom_id(self)
    broadcast_replace_to outfit,
      target: ActionView::RecordIdentifier.dom_id(outfit, :comments_count),
      partial: "comments/comments_count", locals: { outfit: outfit }
  }
end
```
⚠️ Dans le model, `dom_id` n'est pas dispo directement → `ActionView::RecordIdentifier.dom_id` (méta-erreur #7 de lundi).

Model `Outfit` (ajout) :
```ruby
has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
```

## Routes + controller

```ruby
resources :outfits do
  resources :likes,    only: %i[create destroy]
  resources :comments, only: %i[create destroy]
end
```

`CommentsController` (calqué sur `LikesController`) :
- `before_action :authenticate_user!` + `set_outfit` (`Outfit.find`, **non scopé** → commenter l'outfit d'autrui est autorisé = décision sociale V1).
- `create` : `@comment = @outfit.comments.new(comment_params.merge(user: current_user))`.
  - succès → turbo_stream : **vide le form uniquement** via `turbo_stream.replace(dom_id(@outfit, :new_comment), partial: "comments/form", locals: { outfit: @outfit, comment: Comment.new })` (voir flux broadcast) ; html → `redirect_to @outfit`.
  - échec (body vide) → re-render le form avec erreurs (même cible `dom_id(@outfit, :new_comment)`), statut `:unprocessable_content` (422).
- `destroy` : `@comment = current_user.comments.find(params[:id])` → **scopé** → sentinel IDOR (commentaire d'autrui = `RecordNotFound` → 404). Broadcast gère le retrait DOM.
- `comment_params` : `params.require(:comment).permit(:body)`.

## ⭐ Flux broadcast — le point nouveau et son piège

Contrairement à Like (`replace` d'un compteur), une liste de commentaires implique **3 actions Turbo Stream** : `prepend` (ajout en tête), `remove` (retrait), `replace` (compteur).

**Piège central** : `broadcast_prepend` ajoute le commentaire chez **tous les abonnés, y compris l'auteur**. Donc le controller `create` **ne doit pas** aussi rendre le commentaire (sinon doublon chez l'auteur). Son seul rôle côté turbo_stream = **réinitialiser le form**.
- Likes (lundi) : controller rendait le bouton *spécifique au current_user*, broadcast gérait le compteur global.
- Comments : le commentaire est identique pour tous → 100 % broadcast pour la liste, le controller ne touche qu'au form de l'auteur.

`Outfit#show` souscrit déjà via `turbo_stream_from @outfit` (présent l.3) → aucune souscription à ajouter.

## Vues (partials)

- `comments/_comment.html.erb` : un commentaire, `id="<%= dom_id(comment) %>"`, body + auteur (`username`) + date ; bouton Delete si `comment.user == current_user`.
- `comments/_comments.html.erb` : conteneur `id="<%= dom_id(outfit, :comments) %>"` itérant `outfit.comments` (déjà triés desc).
- `comments/_form.html.erb` : conteneur `id="<%= dom_id(outfit, :new_comment) %>"` (cible du reset/erreur par le controller) englobant un `form_with` nested (`[outfit, Comment.new]`), textarea `body`.
- `comments/_comments_count.html.erb` : `id="<%= dom_id(outfit, :comments_count) %>"`, `pluralize(outfit.comments_count, "comment")`.
- Intégration dans `outfits/show.html.erb` sous la section likes (form + compteur + liste).

## Tests (calqués Likes)

**Model spec** (`spec/models/comment_spec.rb`) :
- validations : `body` presence + length max 1000.
- counter_cache : create → `comments_count` +1 ; destroy → −1 (via `outfit.reload`).
- ordre antéchrono de l'association.
- associations `belongs_to`.

**Request spec** (`spec/requests/comments_spec.rb`) :
- anonyme → redirect login.
- create nominal → `change(Comment, :count).by(1)` + redirect outfit.
- create body vide → pas de création + 422.
- create sur outfit d'autrui → succès (verrouille la décision sociale V1).
- destroy own → `by(-1)` + redirect.
- **sentinel IDOR** : destroy du commentaire d'autrui → 404 + `not_to change(Comment, :count)`.

## Hors scope (V1) / évolutions futures

- **Édition inline (`update`)** → `FEATURES_FUTURES.md` (certaine).
- **Polymorphic `commentable`** → seulement si un besoin produit « commenter un Garment » émerge (peu probable, voir décision 1).
- Pagination des commentaires, mentions, modération → non envisagés V1.
