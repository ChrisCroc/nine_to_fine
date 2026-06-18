# Design — Follow (suivre un utilisateur) + profil public

**Date** : 2026-06-18 (sem 25, jeudi)
**Feature** : US22 (Follow) + US04 (éditer son profil) — suivre un utilisateur et consulter son profil public.
**Pattern de référence** : Likes (lundi 15, PR #114/#115). On réplique `find_or_create_by`, le bouton user-specific rendu par le controller en `turbo_stream.replace`, le counter_cache et le sentinel IDOR sur `destroy`. **Sans broadcast Action Cable** (cas concurrent marginal — voir décision 4).

## Objectif

Permettre à un utilisateur connecté de suivre / ne plus suivre un autre utilisateur, et de consulter un profil public (`UsersController#show`) listant ses garments, ses outfits et ses compteurs followers / following. US04 (édition de son propre profil) si le temps le permet, sinon reportée.

## Décisions tranchées (et pourquoi)

1. **Association self-référentielle user→user** — *pas* polymorphic (contrairement à `Like`).
   - On suit un *utilisateur*, pas une autre entité. Le polymorphic ne se justifierait que pour suivre aussi des tags / marques → aucun besoin produit V1.
   - Le mot « polymorphic » du PLANNING est une imprécision d'écriture : un follow user→user est un self-join (deux FK vers `users`), pas un `followable_type/id`.
   - Choisir le polymorphic ici = premature design (anti-pattern SOLID Section 5). YAGNI assumé, cohérent avec la décision `Comment` FK-direct de mardi.

2. **Naming** : `Follow belongs_to :follower` + `:followed` (les deux `class_name: "User"`).
   - `follower` = celui qui suit. `followed` = celui qui est suivi.
   - Côté `User` : `followed_users` (ceux que je suis) + `followers` (ceux qui me suivent).

3. **counter_cache `followers_count` + `following_count` sur `users`** (dénormalisé).
   - Le compteur followers est une donnée **publique** affichée sur chaque profil (owner + visiteurs) → doit être cheap à lire.
   - Cohérent avec `likes_count` / `comments_count` déjà en place.

4. **Pas de broadcast Action Cable V1.** Le bouton + les compteurs sont rendus par le controller en `turbo_stream.replace` (comme `_like_button`).
   - Le bouton Follow/Unfollow est par-viewer (son état dépend de `current_user`) → il ne peut pas être un partial broadcasté unique partagé par tous.
   - Le seul gain d'un broadcast serait la sync **concurrente** du `followers_count` chez un visiteur regardant le profil pendant qu'un autre clique Follow → cas marginal pour un portfolio.
   - Ajout futur trivial (`after_create_commit` sur `Follow`) si besoin → zéro dette.

5. **CRUD V1 = create + destroy seulement.** Idempotent via `find_or_create_by`.

6. **Suivre n'importe quel user est autorisé** (social, comme liker l'outfit d'autrui). Pas de sentinel IDOR sur `create`. Le seul sentinel IDOR est sur `destroy` (scopé `current_user.active_follows`).

7. **US04 (éditer son profil)** = ligne de coupe si le temps manque. V1 : `username` seul (pas de colonne bio/avatar → YAGNI, on n'ajoute pas de champ sans besoin). Scopé `current_user` (un user n'édite que SON profil).

## Modèle de données

Migration `follows` :
```ruby
create_table :follows do |t|
  t.references :follower, null: false, foreign_key: { to_table: :users }
  t.references :followed, null: false, foreign_key: { to_table: :users }
  t.timestamps
end
add_index :follows, %i[follower_id followed_id], unique: true
```
- `foreign_key: { to_table: :users }` : la colonne est `follower_id` / `followed_id`, pas `user_id` → Rails ne devine pas la table, on la précise.
- Index unique composite `[follower_id, followed_id]` : anti double-follow au niveau DB (defense-in-depth avec la validation app-level).

Migration counter_cache :
```ruby
add_column :users, :followers_count, :integer, null: false, default: 0
add_column :users, :following_count, :integer, null: false, default: 0
```

## Modèle `Follow`

```ruby
class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", counter_cache: :following_count
  belongs_to :followed, class_name: "User", counter_cache: :followers_count

  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :not_self_follow

  private

  def not_self_follow
    errors.add(:followed_id, "can't follow yourself") if follower_id == followed_id
  end
end
```
- Deux `belongs_to` vers le même model `User` via `class_name`, chacun avec son counter_cache propre.
- `follower` incrémente `following_count` ; `followed` incrémente `followers_count`.
- Validation `uniqueness` (doublée par l'index DB) + garde anti self-follow.

## Associations `User`

```ruby
# ce que je suis
has_many :active_follows,  class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
has_many :followed_users,  through: :active_follows, source: :followed
# qui me suit
has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
has_many :followers,       through: :passive_follows, source: :follower

def following?(user) = followed_users.exists?(user.id)
```
- `dependent: :destroy` sur les deux côtés : suppression de compte → follows émis ET reçus partent (pas d'orphelins).
- `source:` indique la colonne à suivre dans la table de jointure (sinon Rails cherche un model inexistant).

## Routes

```ruby
resources :users, only: %i[show] do
  resource :follow, only: %i[create destroy]   # singulier
end
# US04 (si le temps) : ajouter %i[edit update] à users
```
- `resource :follow` **singulier** (pas `resources`) → `POST/DELETE /users/:user_id/follow` sans `:id`. La relation `current_user` ↔ user cible est unique (suivi ou pas) → pas d'id de follow dans l'URL.

## `FollowsController`

```ruby
class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.active_follows.find_or_create_by(followed: @user)
    respond_with_button
  end

  def destroy
    current_user.active_follows.find_by(followed: @user)&.destroy
    respond_with_button
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def respond_with_button
    @user.reload   # counter_cache a bougé en SQL : l'objet en mémoire est périmé
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          helpers.dom_id(@user, :follow),
          partial: "users/follow_button",
          locals: { user: @user }
        )
      }
      format.html { redirect_to user_path(@user) }
    end
  end
end
```
- `find_or_create_by` rend `create` idempotent (re-Follow = no-op).
- `destroy` scopé `current_user.active_follows` → on ne défait que ses propres follows (sentinel IDOR).
- `@user.reload` mandatory avant le rendu : sinon le partial ré-affiche l'ancien `followers_count`.

## `UsersController#show`

```ruby
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @outfits  = @user.outfits.includes(garments: [:category, { photo_attachment: :blob }])
    @garments = @user.garments.includes(:category, photo_attachment: :blob)
  end
end
```
- Controller mince, eager loading anti-N+1 (réutilise le pattern collage des outfits).

## Vue profil + partial `_follow_button`

```erb
<%# users/_follow_button.html.erb %>
<div id="<%= dom_id(user, :follow) %>">
  <% if user_signed_in? && current_user != user %>
    <% if current_user.following?(user) %>
      <%= button_to "Unfollow", user_follow_path(user), method: :delete %>
    <% else %>
      <%= button_to "Follow", user_follow_path(user), method: :post %>
    <% end %>
  <% end %>
  <span><%= user.followers_count %> followers · <%= user.following_count %> following</span>
</div>
```
- Compteur **dans** le partial remplacé → bouton + compteur se mettent à jour ensemble au clic.
- Bouton masqué sur son propre profil et pour les anonymes. Compteur toujours visible.
- La vue `users/show` affiche : username, le partial follow_button, le listing outfits (collage) + garments.

## US04 — éditer son profil (si le temps)

- Routes : ajouter `%i[edit update]` à `resources :users`.
- `UsersController#edit/update` scopé `current_user` (un user n'édite que SON profil → sentinel IDOR, redirection si `@user != current_user`).
- Form `username` seul (V1). Pas de colonne bio/avatar (YAGNI).

## Tests RSpec

`spec/models/follow_spec.rb` :
- validations associations `follower` / `followed` présentes
- anti double-follow app-level (2e création même paire invalide)
- anti self-follow (`follower == followed` invalide)
- DB-level uniqueness via `save(validate: false)` → `ActiveRecord::RecordNotUnique`
- counter_cache pairé : `change { user.reload.following_count }.by(1)` ET `change { other.reload.followers_count }.by(1)`
- scoping : `followed_users` / `followers` / `following?` true/false

`spec/requests/follows_spec.rb` (`type: :request`) :
- `create` nominal → relation créée + redirect/200
- idempotent (POST 2× → une seule ligne)
- follow d'autrui autorisé (pas de sentinel sur create)
- `destroy` own → relation retirée
- sentinel IDOR sur `destroy` (un user ne défait pas le follow d'un autre)
- anonyme → redirigé vers login

`spec/factories/follows.rb` :
```ruby
factory :follow do
  association :follower, factory: :user
  association :followed, factory: :user
end
```
- Deux associations explicites vers `:user` avec `factory:` (sinon factory_bot cherche des factories `follower`/`followed` inexistantes).

## Hors scope V1 (backlog `FEATURES_FUTURES.md`)

- Broadcast Action Cable du `followers_count` (sync concurrente live).
- Follow polymorphic (suivre tags / marques).
- Profil enrichi (bio, avatar Active Storage).
- Feed des outfits des `followed_users` (activité).
- Liste des followers / following cliquable (modale ou page dédiée).

## Ordre d'implémentation (US04 = ligne de coupe)

1. Migration `follows` + counter_cache + `db:migrate`
2. Model `Follow` + associations `User` + RSpec model (vert)
3. Routes + `FollowsController` + RSpec request (vert)
4. `UsersController#show` + vue profil + partial `_follow_button`
5. US04 (`edit`/`update`) — seulement si le temps le permet
