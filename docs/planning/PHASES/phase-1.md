# Phase 1 — Rails pro + Tailwind (sem 22-25, 25 mai → 21 juin)

**Focus apprentissage** : Tailwind CSS (Tailwind Labs YouTube + docs officielles).

**Odin Rails** : Active Record avancé (callbacks, scopes, query optim), Forms avancées, Authentication "from scratch" (comprendre ce que Devise fait sous le capot).

**Cadence Nine to Fine** : pleine production l'après-midi (~5 j/sem).

## Tableau récap

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 22 | 25-31 mai | Scaffolding des **models structurels** Nine to Fine + Tailwind setup | Models Category, Garment, Outfit, OutfitGarment, Tag, Tagging (les 6 nécessaires pour le CRUD sem 22-24). Tailwind opérationnel. 1ère page stylée. CRUD Garment + Tailwind v4 sur les 5 vues. |
| 23 | 1-7 juin | CRUD Outfit + composition de tenues + Active Storage | OutfitGarment join (form `fields_for` + `accepts_nested_attributes_for`), page de composition d'outfit, upload photo (Active Storage) sur Garment, premier polish UI sur la page de show outfit. |
| 24 | 8-14 juin | **Tags + recherche light** + **suite RSpec rétroactive sur `GarmentsController`** (dette de sem 22) | Tags via input texte comma-separated (parse côté model + `find_or_create_by`), recherche par nom (1 input) + filtres `link_to` (couleur OU category OU tag, un seul à la fois). Premiers tests RSpec (Outfit + rétroactifs Garment + tagging). Setup gem `bullet` (development). |
| 25 | 15-21 juin | Likes + Comments + Follows + profil public + **LANCEMENT RECHERCHE EMPLOI** + skill `job-tracker` | Models sociaux générés (Like, Comment, Follow polymorphic). UI Likes / Comments / Follow fonctionnelles. Profil user public (`UsersController#show`). **Skill Claude Code `job-tracker` créée samedi 20-21 juin** (~1-2 j atelier). **LinkedIn + GitHub à jour. 3 premières candidatures Rails.** |

## Mini-bullets jour-type

### Sem 22 (en cours)

Voir tableau détaillé jour par jour ci-dessous.

### Sem 23 (1-7 juin) — anticipé

- Lundi : démarrage CRUD Outfit (routes + controller + index/show/new/edit/_form).
- Mardi : composition outfit via `fields_for` (form imbriqué Outfit + OutfitGarment) + tests manuels.
- Mercredi : Active Storage sur Garment (upload + preview + `image_processing`).
- Jeudi : polish UI Outfit (split visuel comme Garment) + page composition cohérente.
- Vendredi : intercalage du début de tags comma-separated si le temps + setup `bullet` gem.

### Sem 24 (8-14 juin) — anticipé

- Lundi-mardi : tags comma-separated (parse model + UI input + display pills) + filtres `link_to` (couleur + category + tag).
- Mercredi : recherche par nom (1 input + scope simple `where("name ILIKE ?", "%#{q}%")`).
- Jeudi : RSpec setup (gem + spec_helper + factory_bot ou fixtures) + premiers tests `GarmentsController` rétroactifs.
- Vendredi : suite RSpec controllers + tagging tests + audit `bullet` (corriger N+1 détectés).

### Sem 25 (15-21 juin)

- Lundi-mardi : Like model polymorphic + Comment model polymorphic + UI sur Outfit show.
- Mercredi : Follow model + scoping + UI sur profil user.
- Jeudi : profil user public (`UsersController#show` + listing garments/outfits/follows).
- Vendredi : polish profil + premières candidatures Rails (3) + LinkedIn polish.
- **Samedi 20-21 juin** : création skill Claude Code `job-tracker` (~1-2 j, atelier Claude). Slash commands `/candidatures add|list|relance|stats`. Stockage markdown ou JSON.

## Détail jour par jour — Sem 22 (en cours)

| Jour     | Date       | Programme                                                                                                                                                                                                                                                                                                                                                      | Statut                                                                                                                                                                 |
| -------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Lundi    | 25 mai     | Conception complète (user stories, schéma DB, kanban GitHub, roadmap) + install et config Devise (username, email, password)                                                                                                                                                                                                                                   | ✅                                                                                                                                                                      |
| Mardi    | 26 mai     | Model User + ApplicationController (authenticate_user! + permitted_parameters) + PagesController (home publique) + navbar + flashes + devise views                                                                                                                                                                                                             | ✅                                                                                                                                                                      |
| Mercredi | 27 mai     | Setup environnement de travail : `~/.claude/CLAUDE.md` global + `CLAUDE.md` projet + `PLANNING.md` 18 sem + fix CI (PR #29) + upgrade image_processing 2.0.1 (PR #30) + vault Obsidian `DevJobReady`                                                                                                                                                           | ✅                                                                                                                                                                      |
| Jeudi    | 28 mai     | Générer les **6 models structurels** dans l'ordre : Category → Garment → Outfit → OutfitGarment → Tag → Tagging (`rails g model X`) + migrations + `db:migrate` + vérifier associations en console + **tests Minitest pour chaque model** (validations, associations, cas d'erreur) + **fixtures `test/fixtures/x.yml`**. **Like/Comment/Follow reportés à sem 25** (générés au moment de leur implémentation). **AiSuggestion reporté à Phase 4 sem 36-37** (intégration agent IA). RSpec maintenu à sem 24. | ✅ Exos sandbox du soir (polymorphic + piège `default: 0`/`validates presence`) **reportés samedi 30 mai**. |
| Vendredi | 29 mai     | CRUD Garment (controller + vues new/show/index/edit) + tester le flow en local + premier styling Tailwind sur la page Garment                                                                                                                                                                                                                                  | ✅ CRUD Garment livré (PR #42 mergée). Styling Tailwind v4 des 5 vues livré fin d'aprem (PR #45, branche `feature/garment-crud-tailwind`). **Dette technique notée : 0 test controller écrit, reportés à sem 24 avec l'introduction RSpec.** |
| Samedi   | 30 mai     | **Refonte stratégique Phases 2-3-4 + restructuration documentaire** (priorité matin, voir Suivi). Rattrapage Odin courts (Asset Pipeline + Importmaps + Turbo Drive). Exos sandbox reportés (polymorphic + piège default). Tailwind layouts + navbar responsive (si temps). Routine `/end-of-day` (skill Claude Code). Ménage dotfiles (coupable). | 🟡 En cours |
| Dimanche | 31 mai     | OFF                                                                                                                                                                                                                                                                                                                                                            | ⬜                                                                                                                                                                      |

**Tableaux jour-par-jour sem 23, 24, 25** : à compléter au démarrage de chaque semaine (lundi).
