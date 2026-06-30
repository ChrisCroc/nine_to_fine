# Plan — Habillage des pages d'authentification Devise

> **Mode coach** : Chris écrit 100 % du code de production. Claude guide, relit, explique chaque ligne. Ce plan donne l'ordre des paliers, les fichiers, et la vérif de chacun. Le Tailwind (classes carte/champs/boutons) est décidé en live (Chris propose, Claude affine selon le design system).

**Goal :** Habiller les 5 pages auth Devise pour qu'elles soient cohérentes avec le design system, avant déploiement.

**Architecture :** Nested layouts (Odin chap. 40) — `_head` partagé + `layouts/devise.html.erb` + `layout_by_resource`. Partial `_field` réutilisable. Spec : `docs/superpowers/specs/2026-06-30-devise-auth-design.md`.

**Tech Stack :** Rails 8.1, Devise, Tailwind v4 (tokens `--font-display/body`, `--color-champagne`, `--text-*`, utilities `page-shell`/`btn-base`).

## Global Constraints

- Design system : Playfair (`font-display`) / Inter (`font-body`), palette zinc + champagne `#E7DBC4`, pattern carte de `users/show`, `btn-base`.
- Mobile-first (375px) : carte `max-w-md` + champs pleine largeur (`project-nine-to-fine-mobile-first`).
- Textes UI en **anglais** (`project-nine-to-fine-locale-english`).
- Jamais de commit sur `main` : branche `feature/devise-auth-design`.
- Pas de trailer `Co-Authored-By`.

---

## Task 1 — Fondation : extraire le `<head>` en partial partagé

**Files :**
- Create : `app/views/layouts/_head.html.erb`
- Modify : `app/views/layouts/application.html.erb` (lignes 3-25, le bloc `<head>`)

**But :** refactor pur, zéro changement visuel. Déplacer le contenu interne de `<head>` dans `_head.html.erb`, puis dans `application.html.erb` remplacer l'intérieur du `<head>` par `<%= render "layouts/head" %>`.

- [ ] Créer `_head.html.erb` avec le contenu actuel entre `<head>` et `</head>` (title `content_for :page_title`, meta description SEO #136, viewport/PWA metas, csrf/csp, `yield :head`, icons, `stylesheet_link_tag`, `javascript_importmap_tags`).
- [ ] Dans `application.html.erb`, `<head>` ne contient plus que `<%= render "layouts/head" %>`.
- [ ] **Vérif** : `bin/dev`, ouvrir `/`, voir le code source → `<head>` identique à avant (title, meta description, assets). Aucune régression visuelle.
- [ ] **Vérif** : `bin/rspec` → toujours vert.
- [ ] Commit : `refactor(layout): extract head into shared partial`

---

## Task 2 — Layout Devise + branchement controller

**Files :**
- Create : `app/views/layouts/devise.html.erb`
- Modify : `app/controllers/application_controller.rb`

**But :** les pages Devise rendues dans la carte centrée, le reste de l'app inchangé.

- [ ] `layouts/devise.html.erb` : `<!DOCTYPE html>` + `<html lang="<%= I18n.locale %>">` + `<head><%= render "layouts/head" %></head>` + `<body class="font-body">` = `header > render "shared/navbar"` + `<main>` avec `render "shared/flashes"` + section `page-shell` + carte (`max-w-md mx-auto mt-12 bg-white/40 backdrop-blur-sm rounded-2xl p-8 flex flex-col gap-6`) contenant `<h1 class="text-h1 font-display text-zinc-900"><%= content_for(:page_title) %></h1>` + `<%= yield %>`. _(Classes Tailwind affinées en live.)_
- [ ] `ApplicationController` : ajouter `layout :layout_by_resource` + méthode privée `def layout_by_resource; devise_controller? ? "devise" : "application"; end`.
- [ ] **Vérif** : déconnecté, visiter `/users/sign_in` → le formulaire (encore brut) apparaît DANS la carte, navbar présente. Visiter une page app normale (`/`) → layout `application` inchangé.
- [ ] **Vérif** : `bin/rspec` → vert (le changement de layout ne casse pas les request specs auth).
- [ ] Commit : `feat(auth): add dedicated Devise layout with centered card`

---

## Task 3 — Partial `_field` + habillage des partials partagés

**Files :**
- Create : `app/views/devise/shared/_field.html.erb`
- Modify : `app/views/devise/shared/_error_messages.html.erb`
- Modify : `app/views/devise/shared/_links.html.erb`

**Interface du partial `_field`** (ce que les vues consommeront en Task 4-7) :
`render "devise/shared/field", form: f, attribute: :email, type: :email, label: "Email", options: { autofocus: true, autocomplete: "email" }`
- `form` (form builder), `attribute` (symbole), `type` (`:text`/`:email`/`:password`), `label` (string, optionnel → défaut = `attribute.to_s.humanize`), `options` (hash passé à l'input).

- [ ] `_field.html.erb` : wrapper `flex flex-col gap-1`, `form.label` stylé (`text-caption font-medium text-zinc-700`), `form.send("#{type}_field", attribute, options.merge(class: "w-full rounded-lg border border-zinc-300 px-3 py-2 focus:outline-none focus:ring-2 focus:ring-zinc-900/20"))`. _(Classes affinées en live.)_
- [ ] `_error_messages.html.erb` : remplacer le markup brut par un encart `rounded-lg bg-red-50 border border-red-200 text-red-700 text-caption p-3` + liste `list-disc pl-4` des `full_messages`.
- [ ] `_links.html.erb` : garder la logique conditionnelle existante, restyler chaque `link_to` en `text-caption text-zinc-600 hover:text-zinc-900`, conteneur `flex flex-col gap-1 mt-2 text-center`.
- [ ] **Vérif** : pas de rendu isolé ; validé visuellement dès Task 4 (login utilise `_field` + `_links`).
- [ ] Commit : `feat(auth): add reusable field partial + style shared auth partials`

---

## Task 4 — Login (`sessions/new`) — page prioritaire

**Files :**
- Modify : `app/views/devise/sessions/new.html.erb`

- [ ] Réécrire : `content_for :page_title, "Log in"` en tête (alimente la carte + le `<title>`). `form_for` inchangé (URL/resource). Deux `_field` (email type `:email` autofocus ; password type `:password`). Checkbox `remember_me` stylée à la main (`flex items-center gap-2`, `text-caption`). Submit `btn-base bg-zinc-900 text-champagne hover:bg-zinc-700 w-full`. `render "devise/shared/links"`. Plus de `.field`/`.actions`/`<p>`.
- [ ] **Vérif** : visiter `/users/sign_in` → carte cohérente avec `users/show`, champs stylés, bouton plein. **Se connecter réellement** → fonctionne. Saisir un mauvais mot de passe → flash d'erreur lisible.
- [ ] **Vérif mobile** : 375px, carte + champs OK.
- [ ] Commit : `feat(auth): style the login page`

---

## Task 5 — Sign up (`registrations/new`)

**Files :**
- Modify : `app/views/devise/registrations/new.html.erb`

- [ ] Réécrire : `content_for :page_title, "Sign up"`. `render "devise/shared/error_messages"`. Quatre `_field` (username texte autofocus ; email ; password ; password_confirmation). Conserver l'affichage `@minimum_password_length` (hint sous le champ password, `text-caption text-zinc-500`). Submit `btn-base …` pleine largeur. `render links`.
- [ ] **Vérif** : visiter `/users/sign_up` → cohérent. Soumettre vide → encart d'erreurs stylé. Créer un compte test → fonctionne.
- [ ] Commit : `feat(auth): style the sign up page`

---

## Task 6 — Mot de passe oublié + réinitialisation (`passwords/new`, `passwords/edit`)

**Files :**
- Modify : `app/views/devise/passwords/new.html.erb`
- Modify : `app/views/devise/passwords/edit.html.erb`

- [ ] `passwords/new` : `content_for :page_title, "Forgot your password?"`. Un `_field` email autofocus. Submit "Send me reset password instructions" pleine largeur. `render links`.
- [ ] `passwords/edit` : `content_for :page_title, "Change your password"`. `render error_messages`. Champs hidden `reset_password_token` conservé. Deux `_field` (password "New password" autofocus + hint `@minimum_password_length` ; password_confirmation "Confirm new password"). Submit "Change my password". `render links`.
- [ ] **Vérif** : visiter `/users/password/new` → cohérent. (Le flow email complet n'est pas testable sans mailer configuré — vérif visuelle suffit ; rendu de `passwords/edit` via la console ou un token factice si besoin.)
- [ ] Commit : `feat(auth): style the password reset pages`

---

## Task 7 — Réglages de compte (`registrations/edit`)

**Files :**
- Modify : `app/views/devise/registrations/edit.html.erb`

- [ ] Réécrire en habillant la logique Devise existante : `content_for :page_title, "Account settings"`. `render error_messages`. `_field` username + email. Note Devise « Currently waiting confirmation… » conservée si présente (ne s'applique pas, pas de confirmable — peut être retirée). `_field` password "New password (leave blank to keep)" + password_confirmation + current_password (requis, `_field` type password). Submit "Update". Section séparée **Cancel my account** (`button_to` Devise) stylée discrètement (`text-caption text-red-600`, `mt-6 pt-4 border-t border-zinc-200`). Lien "Back".
- [ ] **Vérif** : connecté, visiter `/users/edit` → cohérent. Mettre à jour le username (avec current_password) → fonctionne.
- [ ] Commit : `feat(auth): style the account settings page`

---

## Task 8 — Vérification finale + PR

- [ ] **Revue visuelle** des 5 pages sur l'app qui tourne : cohérence carte/typo/boutons avec `users/show`, mobile 375px OK.
- [ ] `bin/rspec` → tous verts (les request specs auth existants ne doivent pas casser).
- [ ] `bin/rubocop` → propre (autocorrect si besoin).
- [ ] Pousser la branche `feature/devise-auth-design`, ouvrir la PR (inclure la spec + ce plan committés).

---

## Self-review (couverture spec)

- 5 pages atteignables → Tasks 4-7 ✅ · 2 partials partagés → Task 3 ✅ · nested layout `_head` → Task 1 ✅ · layout Devise + `layout_by_resource` → Task 2 ✅ · `_field` → Task 3 ✅ · vérif visuelle + specs verts + mobile → Tasks 4-8 ✅. Vues mortes confirmations/unlocks exclues ✅. Pas de généralisation `_field` aux garments (YAGNI) ✅.
