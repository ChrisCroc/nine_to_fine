# Design — Follow (suivre un utilisateur) + profil nu

**Date** : 2026-06-18 (sem 25, jeudi)
**Feature** : US22 (Follow) — la primitive de relation user→user + un profil minimal comme surface de test.
**Pattern de référence** : Likes (lundi 15, PR #114/#115). On réplique `find_or_create_by`, le bouton user-specific rendu par le controller en `turbo_stream.replace`, le counter_cache et le sentinel IDOR sur `destroy`. **Sans broadcast Action Cable**.

## Scope — pourquoi un profil NU et pas riche

Le profil riche envisagé (lister les outfits **publics** du user, gating « obligé de suivre pour voir le contenu », photo de profil, navigation par tag « work ») dépend **entièrement** d'une brique non construite et **délibérément reportée** : le **public / privé** des outfits = **US18**, parquée sem 26+ le lundi 15 (« brainstorm produit dédié requis sur la sémantique public »).

État actuel : **aucun browsing public** dans l'app — les index sont scopés `current_user`. Un profil affichant le contenu d'un *autre* user est donc du territoire neuf qui dépend de la décision public/privé.

**Principe de la journée : ne construire que ce qui est invariant par rapport à US18.** La relation Follow et un profil minimal (username + compteurs + bouton) survivent à n'importe quelle résolution de US18 — le gating est une règle de **lecture** (`current_user.following?(owner)`), il ne change pas le stockage des follows. La grille de contenu et `is_public`, eux, **dépendent** de US18 → on ne les code pas aujourd'hui (sinon rework garanti). Vision complète enregistrée dans `FEATURES_FUTURES.md` comme brief US18.

## Objectif

Permettre à un utilisateur connecté de suivre / ne plus suivre un autre utilisateur (relation **instantanée**, pas d'approbation), avec un profil public minimal (`UsersController#show` : username + compteurs followers/following + bouton Follow/Unfollow). **Pas de listing de contenu, pas d'édition de profil aujourd'hui.**

## Décisions tranchées (et pourquoi)

1. **Association self-référentielle user→user** — *pas* polymorphic.
   - On suit un *utilisateur*. Le polymorphic (suivre tags/marques) = aucun besoin V1 → premature design (anti-pattern SOLID). Le « polymorphic » du PLANNING est une imprécision d'écriture.

2. **Naming** : `Follow belongs_to :follower` + `:followed` (les deux `class_name: "User"`).
   - Côté `User` : `followed_users` (ceux que je suis) + `followers` (ceux qui me suivent).

3. **counter_cache `followers_count` + `following_count` sur `users`** (dénormalisé) — compteur public affiché sur le profil, cohérent avec `likes_count`/`comments_count`.

4. **Pas de broadcast Action Cable V1.** Bouton + compteurs rendus par le controller en `turbo_stream.replace` (comme `_like_button`). Le bouton est par-viewer → ne peut pas être un partial broadcasté unique. Ajout futur trivial si besoin (zéro dette).

5. **Follow instantané (pas d'approbation) V1.** L'exemple produit (« je suis Jean → je regarde son profil ») implique l'instantané. Si un jour un compte privé exige l'approbation, c'est une colonne `status` (pending/accepted) **additive** + un tweak du `create` — pas une réécriture. → instantané = défaut sûr et additif.

6. **CRUD V1 = create + destroy seulement.** Idempotent via `find_or_create_by`.

7. **Suivre n'importe quel user est autorisé** (social, comme liker l'outfit d'autrui). Pas de sentinel IDOR sur `create`. Sentinel IDOR uniquement sur `destroy` (scopé `current_user.active_follows`).

8. **Profil NU V1** : username + compteurs + bouton. **Pas** de grille outfits/garments (dépend de US18), **pas** de `is_public`, **pas** d'avatar, **pas** de nav par tag, **pas** d'édition de profil (US04). Tout ça = brief US18 sem 26+.

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
- `foreign_key: { to_table: :users }` : colonne `follower_id`/`followed_id` (pas `user_id`) → on précise la table.
- Index unique composite = anti double-follow DB-level (defense-in-depth avec la validation app-level).

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
- Deux `belongs_to` vers `User` via `class_name`, chacun avec son counter_cache. `follower` → `following_count` ; `followed` → `followers_count`.

## Associations `User`

```ruby
# ce que je suis
has_many :active_follows,  class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
has_many :followed_users,  through: :active_follows, source: :followed
# qui me suit
has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
has_many :followers,       through: :passive_follows, source: :follower

def following?(user)
  followed_users.exists?(user.id)
end
```
- `dependent: :destroy` des deux côtés : suppression de compte → follows émis ET reçus partent (pas d'orphelins).
- `source:` indique la colonne à suivre dans la jointure.

## Routes

```ruby
resources :users, only: %i[show] do
  resource :follow, only: %i[create destroy]   # singulier
end
```
- `resource :follow` **singulier** → `POST/DELETE /users/:user_id/follow` sans `:id` (relation unique current_user ↔ cible).

## `FollowsController`

```ruby
class FollowsController < ApplicationController
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
    @user.reload
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
- `authenticate_user!` est **déjà global** (`ApplicationController` ligne 9) → pas besoin de le redéclarer ici.
- `find_or_create_by` rend `create` idempotent.
- `destroy` scopé `current_user.active_follows` → sentinel IDOR.
- `@user.reload` mandatory : le counter_cache bouge en SQL, l'objet en mémoire est périmé → sans reload le partial ré-affiche l'ancien compteur.

## `UsersController#show` (profil nu)

```ruby
class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @user = User.find(params[:id])
  end
end
```
- `skip_before_action :authenticate_user!, only: :show` : le profil est public (l'auth est globale dans `ApplicationController`).
- Pas d'eager loading de contenu (rien à lister V1).

## Vue profil + partial `_follow_button`

`app/views/users/_follow_button.html.erb`
```erb
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
- Compteur DANS le `div` remplacé → bouton + compteur changent ensemble au clic.
- Bouton masqué sur son propre profil et pour les anonymes ; compteur toujours visible.

`app/views/users/show.html.erb`
```erb
<section>
  <h1><%= @user.username %></h1>
  <%= render "users/follow_button", user: @user %>
</section>
```
- Minimal V1. Styling Tailwind (tokens design system, mobile-first) appliqué à l'écriture, pas de classes brutes.

## Tests RSpec

`spec/models/follow_spec.rb` :
- validations associations `follower`/`followed` présentes
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

## Hors scope V1 → brief US18 (`FEATURES_FUTURES.md`, brainstorm sem 26+)

- `is_public` sur Outfit + sémantique « public » (par-outfit ? feed ? URL directe ?).
- Profil **gated par follow** (« obligé de suivre pour voir le contenu »).
- Grille des outfits/garments **publics** sur le profil (extraction de partials card réutilisables `_outfit`/`_garment`).
- Photo de profil (avatar Active Storage sur User).
- Navigation par tag depuis le profil (« work » → outfits publics du user taggés work) = `OutfitFilter` scopé public + user.
- US04 : édition de son profil (username + futurs bio/avatar).
- Broadcast Action Cable du `followers_count` (sync concurrente).
- Follow par approbation (compte privé : colonne `status` pending/accepted, additive).

## Ordre d'implémentation

1. Migration `follows` + counter_cache + `db:migrate`
2. Model `Follow` + associations `User` + RSpec model (vert)
3. Routes + `FollowsController` + RSpec request (vert)
4. `UsersController#show` (nu) + vue profil + partial `_follow_button`
