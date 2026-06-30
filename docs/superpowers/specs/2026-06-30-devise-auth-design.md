# Design — Habillage des pages d'authentification Devise (30 juin 2026)

## Problème

Les vues Devise sont générées mais en **markup brut** (`.field`, `.actions`, `<p>`, zéro style) — incohérentes avec le design system de l'app (Playfair/Inter, palette zinc/champagne, `page-shell`, `btn-base`, pattern carte de `users/show`). Bloquant avant déploiement : une page de login moche = mauvais signal recruteur.

## Périmètre (V1)

**Pages atteignables** (modules Devise actifs : `database_authenticatable, registerable, recoverable, rememberable, validatable`) :
1. `sessions/new` — Log in
2. `registrations/new` — Sign up
3. `registrations/edit` — Réglages compte Devise (email / mot de passe / suppression)
4. `passwords/new` — Mot de passe oublié
5. `passwords/edit` — Réinitialisation
+ partials `shared/_links`, `shared/_error_messages`.

**Hors périmètre** : vues mortes `confirmations/new`, `unlocks/new` (modules non activés) ; généralisation du partial `_field` aux formulaires garments/outfits (auth-scoped pour l'instant, YAGNI).

## Architecture (nested layouts, pattern Odin chap. 40)

1. **`layouts/_head.html.erb`** (nouveau) : extraction du contenu du `<head>` de `application.html.erb` (title `content_for :page_title`, meta description, SEO PR #136, viewport/PWA metas, csrf/csp, `yield :head`, icons, `stylesheet_link_tag` + `javascript_importmap_tags`).
2. **`application.html.erb`** (édité) : son `<head>` devient `<%= render "layouts/head" %>`. Corps inchangé.
3. **`layouts/devise.html.erb`** (nouveau) : `<html>` + `<head><%= render "layouts/head" %></head>` + corps = navbar + `shared/flashes` + `page-shell` + carte centrée (`max-w-md mx-auto mt-12 bg-white/40 backdrop-blur-sm rounded-2xl p-8`) + `<h1>` alimenté par `content_for(:page_title)` + `yield`.
4. **`ApplicationController`** (édité) :
   ```ruby
   layout :layout_by_resource
   private
   def layout_by_resource
     devise_controller? ? "devise" : "application"
   end
   ```
   → pages Devise sur le layout auth, reste sur `application`. **Double emploi de `content_for :page_title`** : titre de carte ET `<title>` navigateur.

## Composants réutilisables

5. **`devise/shared/_field.html.erb`** (nouveau) : label + input stylés. Params : `form`, `attribute`, `type` (text/email/password), `label` (optionnel), `options` (autofocus, autocomplete). Style input : `w-full rounded-lg border border-zinc-300 px-3 py-2 focus:outline-none focus:ring-2 focus:ring-zinc-900/20`. Réutilisé par les 5 formulaires.
6. **`devise/shared/_error_messages.html.erb`** (restylé) : encart `rounded-lg bg-red-50 border border-red-200 text-red-700 text-caption p-3` + liste des messages.
7. **`devise/shared/_links.html.erb`** (restylé) : liens `text-caption text-zinc-600 hover:text-zinc-900`, espacés.

## Les 5 vues (réécrites)

- Suppression du markup brut (`.field`, `.actions`, `<p>` wrappers).
- `content_for :page_title, "<titre>"` en tête.
- Champs via le partial `_field`.
- Submit : `btn-base` + remplissage `bg-zinc-900 text-champagne hover:bg-zinc-700` (cohérent bouton Follow), pleine largeur.
- `remember_me` (sessions/new) : checkbox stylée à la main (cas spécial, hors `_field`).
- `registrations/edit` : conserve la logique Devise (current_password requis, bouton Cancel my account) en l'habillant.

## Vérification

- Revue visuelle des 5 pages sur l'app qui tourne (cohérence carte/typo/boutons avec `users/show`).
- Pas de test automatisé requis (styling pur ; les request specs auth existants restent verts).
- Mobile-first : la carte `max-w-md` + champs pleine largeur passent en 375px (cf. `project-nine-to-fine-mobile-first`).

## Hors-sujet noté (ne pas faire ici)

- Suppression de compte (`registrations/edit` « Cancel my account ») = comportement Devise existant, juste habillé. US05 « delete account » dédiée reste au backlog.
- Avatar / profil riche = US18, backlog.
