# Design — US04 : éditer son profil (page profil dédiée)

**Date** : 2026-06-18 (sem 25, jeudi soir — design tranché ; **implémentation reportée à la session suivante, sur une branche fraîche**).
**Feature** : US04 — un user édite son propre profil (username pour l'instant).
**Contexte** : fait suite à la feature Follow (PR #125 mergée). Sortie de la PR Follow exprès (concern différent).

## Décision tranchée : Option B (page profil dédiée), PAS Option A (Devise)

On a hésité entre :
- **A** — ajouter le champ `username` à la vue Devise `registrations/edit` (zéro nouveau controller).
- **B** — un `UsersController#edit/update` dédié (page « Edit profile » séparée de la page « compte/sécurité » Devise).

**Choix : B.** Raisons :
1. On a passé la sem 25 à ne poser que des **primitives qui survivent à US18**. Or US18 aura **forcément** besoin d'une page d'édition de profil (bio, avatar). Construire cette page maintenant avec le username seul = poser sa **fondation** → US18 **ajoutera** des champs (additif), il ne réécrira rien.
2. Sépare proprement **« Account settings »** (email / password / suppression de compte → Devise) de **« Edit profile »** (présentation → custom). Convention standard.
3. Le username vit dans **un seul endroit** (le profil), pas dupliqué avec Devise.

## ⭐ Le constat qui justifie qu'US04 n'est PAS « déjà fait »

- La route Devise `edit_user_registration GET /users/edit` existe, et `ApplicationController` **permet déjà** `:username` dans `:account_update`.
- **MAIS** la vue `app/views/devise/registrations/edit.html.erb` **n'a aucun champ username** (juste email / password / current_password). → impossible d'éditer son username via l'UI aujourd'hui.

Avec l'option B, on **ne touche pas** à Devise : on laisse `account_update` permettre `:username` (inoffensif, pas de champ) ou on le retire (cleanup optionnel, non bloquant). Le username s'édite via la nouvelle page profil.

## Implémentation prévue (TDD, mode coach)

### 1. Routes — étendre `resources :users`
```ruby
resources :users, only: %i[show edit update] do
  resource :follow, only: %i[create destroy]
end
```

### 2. `UsersController` — ajouter edit/update + IDOR
```ruby
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :require_self, only: %i[edit update]

  def show; end
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_self
    redirect_to user_path(@user), alert: "You can only edit your own profile." unless @user == current_user
  end

  def user_params
    params.expect(user: [:username])
  end
end
```
- ⚠️ `show` reste public-aux-connectés (l'auth est globale ; **pas** de `skip_before_action`). `set_user` est partagé show/edit/update (petit refacto du `show` actuel à faire consciemment).
- `require_self` = sentinel IDOR (un user n'édite que SON profil).
- `params.expect(user: [:username])` (Rails 8, comme `feat/comments`).

### 3. Vue `app/views/users/edit.html.erb`
```erb
<section class="page-shell">
  <div class="max-w-md mx-auto mt-12 bg-white/40 backdrop-blur-sm rounded-2xl p-8 flex flex-col gap-4">
    <h1 class="text-h1 font-display text-zinc-900">Edit profile</h1>
    <%= form_with model: @user do |f| %>
      <% if @user.errors.any? %>
        <ul class="text-caption text-red-700">
          <% @user.errors.full_messages.each do |msg| %>
            <li><%= msg %></li>
          <% end %>
        </ul>
      <% end %>
      <div class="flex flex-col gap-1">
        <%= f.label :username, class: "text-caption font-semibold text-zinc-700" %>
        <%= f.text_field :username, class: "w-full bg-white/60 rounded-md px-3 py-2 text-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-500" %>
      </div>
      <%= f.submit "Save", class: "btn-base bg-zinc-900 text-champagne hover:bg-zinc-700 hover:text-white" %>
    <% end %>
    <%= link_to "Back to profile", user_path(@user), class: "text-caption text-zinc-600 hover:text-zinc-900" %>
  </div>
</section>
```

### 4. Lien « Edit profile » sur le profil (own profile only)
Dans `users/show.html.erb`, sous le username :
```erb
<% if current_user == @user %>
  <%= link_to "Edit profile", edit_user_path(@user), class: "text-caption text-zinc-600 hover:text-zinc-900 underline" %>
<% end %>
```

### 5. Request spec `spec/requests/users_spec.rb` (ajouter aux existants)
```ruby
  describe "GET /users/:id/edit" do
    before { sign_in user }

    it "renders the edit form for own profile" do
      get edit_user_path(user)

      expect(response).to have_http_status(:ok)
    end

    it "redirects when editing another user's profile (IDOR sentinel)" do
      other = create(:user)

      get edit_user_path(other)

      expect(response).to redirect_to(user_path(other))
    end
  end

  describe "PATCH /users/:id" do
    before { sign_in user }

    it "updates own username" do
      patch user_path(user), params: { user: { username: "newname" } }

      expect(user.reload.username).to eq("newname")
      expect(response).to redirect_to(user_path(user))
    end

    it "re-renders on invalid username" do
      patch user_path(user), params: { user: { username: "ab" } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(user.reload.username).not_to eq("ab")
    end

    it "does not update another user's profile (IDOR sentinel)" do
      other = create(:user)

      patch user_path(other), params: { user: { username: "hacked" } }

      expect(other.reload.username).not_to eq("hacked")
    end
  end
```
- `"ab"` = 2 caractères < min 3 de la validation User → invalide → 422.

## Ordre d'exécution (TDD)
1. Routes (étendre).
2. Request spec edit/update (rouge → `AbstractController::ActionNotFound`).
3. Controller edit/update + require_self + user_params (vert).
4. Vue edit + lien sur le profil.
5. Test manuel navigateur + commit.

## Hors scope (toujours US18)
Bio, avatar (Active Storage sur User), édition de profil riche. Le username est la 1ère brique de cette page.
