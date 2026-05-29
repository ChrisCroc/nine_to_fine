# Plan d'apprentissage — Chris Crokaert | 25 mai → 27 septembre 2026

## Objectif

Décrocher un poste de **développeur junior** (Paris ou full remote) d'ici fin septembre 2026.

Stack cible à maîtriser à un niveau employable :
- **Ruby on Rails** : niveau pro (au-delà du bootcamp)
- **Tailwind CSS** : maîtrise
- **React** : maîtrise des fondamentaux
- **TypeScript** : maîtrise des fondamentaux
- **Intégration d'agents IA** dans des applications réelles
- **Next.js** : optionnel (Phase 4 si dans les temps)

---

## Progression apprentissage

Source de vérité pour savoir **exactement** où Chris en est sur chaque ressource. À mettre à jour quand un chapitre / vidéo / section est terminé. Claude lit cette section au démarrage de session pour proposer le prochain sujet précis du matin et de l'avant-midi.

### Odin Project — Full Stack Ruby on Rails

- **Fait** (chap. 1-15 du parcours) : Introduction → Rails Basics (Routing, Controllers, Views, Project Store App, Deployment) → Active Record Basics → Migrations → Basic Validations → **Basic Associations** (✅ dernier complété)
- **Prochain (ordre Odin officiel, lecture profonde de consolidation post-bootcamp — les "Project: X" sont remplacés par exos sandbox + Nine to Fine, voir règle péda 9)** :
  - 17. The Asset Pipeline
  - 18. Importmaps
  - 19. Turbo Drive
  - 20. Form Basics
  - 22. Sessions, Cookies and Authentication
  - 24. **Active Record Queries** (priorisé hors ordre sem 22 pour usage immédiat console)
  - 25. Active Record Associations (avancées : polymorphic, has_many through, self-join)
  - 27. Active Record Callbacks
  - 28. Advanced Forms
  - 30. APIs and Building Your Own
  - 31. Working with External APIs
  - 34-37. CSS Bundling, JS Bundling, Turbo, Stimulus
  - 38. Mailers
  - 40. Advanced Topics
  - 41. Websockets and ActionCable
- **Skip délibéré** (projets Odin redondants avec bootcamp + Nine to Fine) : 16 Micro-Reddit, 21 Forms, 23 Members Only!, 26 Private Events, 29 Flight Booker, 32-33 Kittens/Pexels APIs, 39 Confirmation Emails, 42 Odin Book. Leur valeur est récupérée via : (a) Nine to Fine l'aprem, (b) sous-portions isolées en exos sandbox le soir.
- **URL parcours** : https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails

### Tailwind CSS

- **Fait** : rien
- **Prochain (à faire dans l'ordre)** :
  1. Docs officielles section **"Installation"** : https://tailwindcss.com/docs/installation (déjà installé via gem, lire pour comprendre)
  2. Docs officielles section **"Core concepts > Styling with utility classes"** : https://tailwindcss.com/docs/styling-with-utility-classes
  3. Docs officielles section **"Core concepts > Responsive design"** : https://tailwindcss.com/docs/responsive-design
  4. Tailwind Labs YouTube — playlist **"Tailwind CSS v4.0"** (les vidéos d'introduction d'Adam Wathan)
  5. Docs section **"Layout"** (Flexbox, Grid, Spacing) — appliquer immédiatement sur Nine to Fine

### React (à démarrer Phase 2, sem 26)

- **Fait** : rien
- **Prochain** : Scrimba "Learn React" (CS Career Path) + react.dev "Learn" en parallèle
- **URLs** : https://scrimba.com/learn/learnreact + https://react.dev/learn

### TypeScript (à démarrer Phase 3, sem 32)

- **Fait** : rien
- **Prochain** : Total TypeScript "Beginner's TypeScript" (gratuit, Matt Pocock)
- **URL** : https://www.totaltypescript.com/tutorials/beginners-typescript

### Next.js (Phase 4, sem 36, optionnel)

- **Fait** : rien
- **Prochain** : Learn Next.js officiel (gratuit, ~6h)
- **URL** : https://nextjs.org/learn

---

## Ritual quotidien fixe

Volume cible : **40-55h/semaine** (8-11h par jour sur 5 jours + 4-5h le samedi). Dimanche off obligatoire (anti-burnout).

| Slot | Durée | Activité | Rôle pédagogique |
|---|---|---|---|
| **Matin** | 1h30-2h | **Odin Project — Rails** (sujet du jour défini selon la phase) | 📖 **Lecture profonde de consolidation** post-bootcamp — pas de code à produire en parallèle |
| **Avant-midi** | 2h30-3h | **Focus apprentissage** de la phase courante (Tailwind / React / TS / Next selon période) | 📖 **Lecture profonde** de la doc officielle — même logique que le matin |
| **Après-midi** | 2h30-3h | **Production projet** (Nine to Fine en P1 / mini-projets en P2-3 / vitrine en P4) | 🛠️ **Application directe** des concepts du matin et du midi dans du code de prod |
| **Soir** | 30-45 min | **Exercice dirigé avec Claude** dans la sandbox (`~/code/sandbox/<techno>/`) | 🎯 **Consolidation ciblée** : 1 exo min. par concept du jour (règle péda 8), basés sur Knowledge Check Odin + sous-portions de "Project: X" + cas limites du code aprem |
| **Vendredi PM** | 1h (dès sem 25) | **Recherche emploi** : candidatures, mise à jour LinkedIn/GitHub, contacts alumni | — |
| **Samedi** | 4-5h | **Rattrapage / projet / recherche emploi** | Lectures Odin courtes (Asset Pipeline, Importmaps, Turbo Drive) si décalage en semaine |
| **Dimanche** | OFF | Repos obligatoire (ou lecture légère exceptionnelle si rattrapage urgent) | — |

---

## Plan par phase

### Phase 1 — Rails pro + Tailwind (sem 22-25, 25 mai → 21 juin)

**Focus apprentissage** : Tailwind CSS (Tailwind Labs YouTube + docs officielles).
**Odin Rails** : Active Record avancé (callbacks, scopes, query optim), Forms avancées, Authentication "from scratch" (comprendre ce que Devise fait sous le capot).

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 22 | 25-31 mai | Scaffolding des **models structurels** Nine to Fine + Tailwind setup | Models Category, Garment, Outfit, OutfitGarment, Tag, Tagging (les 6 nécessaires pour le CRUD sem 22-24). Tailwind opérationnel. 1ère page stylée. |
| 23 | 1-7 juin | CRUD Garment complet + intro Tailwind layouts | Upload photo (Active Storage), index/show/new/edit Garments, navbar Tailwind responsive |

#### Détail jour par jour — Sem 22 (en cours)

| Jour     | Date       | Programme                                                                                                                                                                                                                                                                                                                                                      | Statut                                                                                                                                                                 |
| -------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Lundi    | 25 mai     | Conception complète (user stories, schéma DB, kanban GitHub, roadmap) + install et config Devise (username, email, password)                                                                                                                                                                                                                                   | ✅                                                                                                                                                                      |
| Mardi    | 26 mai     | Model User + ApplicationController (authenticate_user! + permitted_parameters) + PagesController (home publique) + navbar + flashes + devise views                                                                                                                                                                                                             | ✅                                                                                                                                                                      |
| Mercredi | 27 mai     | Setup environnement de travail : `~/.claude/CLAUDE.md` global + `CLAUDE.md` projet + `PLANNING.md` 18 sem + fix CI (PR #29) + upgrade image_processing 2.0.1 (PR #30) + vault Obsidian `DevJobReady`                                                                                                                                                           | ✅                                                                                                                                                                      |
| Jeudi    | 28 mai     | Générer les **6 models structurels** dans l'ordre : Category → Garment → Outfit → OutfitGarment → Tag → Tagging (`rails g model X`) + migrations + `db:migrate` + vérifier associations en console + **tests Minitest pour chaque model** (validations, associations, cas d'erreur) + **fixtures `test/fixtures/x.yml`**. **Like/Comment/Follow reportés à sem 25** (générés au moment de leur implémentation). **AiSuggestion reporté à Phase 4 sem 36-37** (intégration agent IA). RSpec maintenu à sem 24. | ✅ Exos sandbox du soir (polymorphic + piège `default: 0`/`validates presence`) **reportés samedi 30 mai**. |
| Vendredi | 29 mai     | CRUD Garment (controller + vues new/show/index/edit) + tester le flow en local + premier styling Tailwind sur la page Garment                                                                                                                                                                                                                                  | ✅ CRUD Garment livré (PR #42 mergée). Styling Tailwind v4 des 5 vues livré fin d'aprem (PR #45, branche `feature/garment-crud-tailwind`). **Dette technique notée : 0 test controller écrit, reportés à sem 24 avec l'introduction RSpec (voir section "Dette technique acceptée" du Suivi).** |
| Samedi   | 30 mai     | **Journée chargée (~7-8h, Chris dispo toute la journée)**. **(0) PRIORITÉ MATIN — Refonte stratégique planning Phases 2-3-4** : Option D actée vendredi 29 mai midi + projet React/TS vitrine séparé à acter — voir liste des 5 points à trancher dans la section "Ajustements pour la suite". À faire AVANT les autres chantiers (tête reposée, refonte concrète des tableaux Phase 2-3-4). (1) **Rattrapage Odin lectures courtes** : 17. Asset Pipeline + 18. Importmaps + 19. Turbo Drive (compense le saut à 20. Form Basics vendredi matin). (2) **Exo sandbox reporté de jeudi soir** : piège `default: 0 + validates presence` sur un autre model. (*Polymorphic Rails déplacé à dimanche, voir cellule dimanche + Ajustements.*) (3) **Tailwind** : layouts (Tailwind Labs YouTube vidéo "Building responsive layouts") + navbar responsive. (4) **Routine `/end-of-day`** (reportée de vendredi pause midi) : créer avec Claude un skill Claude Code (`~/.claude/skills/end-of-day/SKILL.md`) qui génère la mise à jour du Suivi à partir des commits du jour + propositions d'exos sandbox. (5) **Ménage dotfiles** : 3 fichiers modifiés à commiter séparément, investiguer `package.json` non tracké, décider sort branche `chore/vscode-settings-update` (commit `9d88492`). **Priorité de coupe si débordement** : ménage dotfiles → reportable, puis Tailwind → reportable. La refonte stratégique (0) n'est PAS coupable. | ⬜ |
| Dimanche | 31 mai     | **⚠️ DÉROGATION RÈGLE DIMANCHE OFF** actée vendredi 29 mai soir (cf. Suivi → Ajustements pour la suite, point "Dimanche 31 mai"). **3 exos de révision** consolidant la sem 22 : (a) **`_field` partial DRY** — extraire la chaîne de classes input répétée 5× dans `app/views/garments/_form.html.erb` en partial Rails `app/views/garments/_field.html.erb` avec locals (form, attribute, label, type). Cible : pattern Rails partial composition. (b) **Mini-exo Tailwind grid 60/40** dans `~/code/sandbox/tailwind/grid-60-40/` — reproduire le split de `show.html.erb` sur un cas simple. Cible : `grid-cols-N + col-span-N`, breakpoint `md:`, ratio responsive. (c) **Polymorphic Rails sandbox** dans `~/code/sandbox/rails/polymorphic/` — model `Note` polymorphique sur `Project`/`Task`, tester `as: :notable`, `has_many through:` avec `source/source_type`, cascade `dependent: :destroy`. (*Déplacé de samedi pour alléger samedi.*) Cible : associations polymorphiques (concept neuf de jeudi). | ⬜                                                                                                                                                                      |
| 24       | 8-14 juin  | CRUD Outfit + composition de tenues + **suite RSpec rétroactive sur `GarmentsController`** (dette de sem 22)                                                                                                                                                                                                                                                  | OutfitGarment join, page de composition d'outfit, premiers tests RSpec (Outfit + rétroactifs Garment, voir "Dette technique acceptée" section Suivi sem 22)             |
| 25       | 15-21 juin | Likes, Comments, Follows, profils publics + **LANCEMENT RECHERCHE EMPLOI**                                                                                                                                                                                                                                                                                     | Models sociaux générés (Like, Comment, Follow) + Likes/Comments/Follow fonctionnels, profil user public. **LinkedIn + GitHub à jour. 3 premières candidatures Rails.** |

### Phase 2 — React fondamentaux (sem 26-31, 22 juin → 2 août)

**Focus apprentissage** : React (Scrimba CS Career Path + react.dev officiel).
**Odin Rails** : APIs Rails + Testing RSpec à fond (faiblesse classique des juniors).
**Nine to Fine** : en maintenance (1 jour/sem pour ne pas perdre Rails).
**Sandbox du soir** : `~/code/sandbox/rails/` continue pour les exos Odin Rails du matin (APIs, RSpec). **Pas de sandbox React dédié par défaut** — les mini-projets de l'après-midi (`react-todo`, `react-flashcards`, etc.) sont déjà la matérialisation ciblée des concepts React appris. Création d'un `~/code/sandbox/react/` uniquement si une faiblesse spécifique nécessite des micro-exos isolés (composants, hooks, contextes).

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 26 | 22-28 juin | JSX, composants, props | Mini-projet 1 : `react-todo` (renommable) |
| 27 | 29 juin-5 juil | useState, événements, listes | Mini-projet 2 : `react-flashcards` |
| 28 | 6-12 juil | useEffect, fetch, async | Mini-projet 3 : `react-weather` (consomme API publique) |
| 29 | 13-19 juil | Composition, lifting state, custom hooks | Refacto des 3 mini-projets avec hooks custom |
| 30 | 20-26 juil | React Router + formulaires contrôlés | Mini-projet 4 : `react-notes` (multi-pages, CRUD local) |
| 31 | 27 juil-2 août | Contexte, state global léger | Ajout dark mode + auth fake (Context) à `react-notes` |

### Phase 3 — TypeScript (sem 32-35, 3-30 août)

**Focus apprentissage** : TypeScript (Total TypeScript "Beginner's TypeScript" de Matt Pocock).
**Odin Rails** : Performance, caching, background jobs (Sidekiq), mailers.
**Sandbox du soir** : `~/code/sandbox/rails/` pour Odin Rails matin + création de `~/code/sandbox/typescript/` (sem 32) pour micro-exos TS isolés (generics, narrowing, utility types, discriminated unions) avant application aux migrations des mini-projets React de l'après-midi.

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 32 | 3-9 août | Types primitifs, interfaces, types de fonctions | Migration `react-todo` → TS |
| 33 | 10-16 août | Generics, narrowing, types utilitaires | Migration `react-weather` → TS (types pour API response) |
| 34 | 17-23 août | TS avancé : discriminated unions, `satisfies`, mapped types | Migration `react-notes` → TS strict |
| 35 | 24-30 août | TS + React patterns pro (props strictes, hooks typés, contextes typés) | Tous mini-projets en TS strict, README pro pour chacun. **Projet vitrine acté : Nine to Fine v2.** |

### Phase 4 — Projet vitrine + emploi intensif (sem 36-39, 31 août → 27 sept)

**Focus apprentissage** : Next.js (Learn Next.js officiel) si dans les temps. Sinon, vanilla React+TS+Vite.
**Odin Rails** : Advanced topics + révision en mode entretien (questions techniques classiques).
**Sandbox du soir** : **usage réduit**. Le slot bascule progressivement en **préparation entretiens techniques** (questions Rails/React/TS, algorithmes basiques, system design junior) au fur et à mesure que les candidatures s'intensifient. `~/code/sandbox/nextjs/` créé uniquement si besoin de micro-exos isolés sur App Router, server components, server actions, etc.

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 36 | 31 août-6 sept | Setup projet vitrine Nine to Fine v2 : SPA React+TS+Tailwind ⇄ API Rails | API JSON Rails (refacto v1) + front React TS scaffold |
| 37 | 7-13 sept | Fonctionnalités cœur + intégration agent IA | 2-3 features clés en place, premier appel API Anthropic depuis le back |
| 38 | 14-20 sept | Polish UI Tailwind, tests, déploiement | Déployé (Vercel front + Render/Fly back), README pro, vidéo démo 90s |
| 39 | 21-27 sept | Finitions + emploi à 100% | **10+ candidatures/semaine**, préparation entretiens techniques (React, Rails, TS) |

---

## Recherche emploi — jalons

| Période | Cible |
|---|---|
| **Mi-juin** (sem 25) | LinkedIn + GitHub propres. 3 premières candidatures Rails. |
| **Mi-juillet** (sem 29) | 3-5 candidatures/semaine. 1 contact alumni Le Wagon/semaine. |
| **Mi-août** (sem 33) | 5-10 candidatures/semaine. |
| **Septembre** | 10+ candidatures/semaine. Entretiens en cours. |

**Plateformes cibles** : Welcome to the Jungle, LinkedIn Jobs, Indeed France, Collective.work, réseau alumni Le Wagon.

---

## Règles pédagogiques (Claude → Chris)

Ces règles s'appliquent uniquement au cadre apprentissage. Les règles de comportement général (challenge, vérification doc, concision, etc.) sont définies dans le `CLAUDE.md` global.

1. **Jamais la solution directement** — toujours le "pourquoi" d'abord.
2. **Questions de vérification** avant de passer à la suite ("explique-moi pourquoi tu utilises `useEffect` ici plutôt que `useMemo`").
3. **Continuité du cursus** : chaque exercice du soir s'appuie sur les précédents de la semaine.
4. **2 alternatives** quand pertinent, avec trade-offs.
5. **Adapter le niveau** : Rails = challenger fort (niveau pro). React / TS / Tailwind / Next = vulgariser plus (apprentissage en cours).
6. **Signaler les erreurs fréquentes** liées au code que Chris vient d'écrire.
7. **Lecture / vidéo quotidienne** suggérée. Source officielle, vérifiée 2 fois, datée.
8. **Slot du soir = consolidation par concept** : au minimum 1 exo dirigé par concept vu dans la journée (Odin + focus phase + production projet), adapté au contenu réellement étudié et codé, jamais générique. Les exos sont définis en fin de journée avec Chris, en s'appuyant sur ce qui l'a marqué / posé problème / mérite consolidation.
9. **Projets Odin remplacés par Nine to Fine + sandbox** : les "Project: X" du parcours Odin (Micro-Reddit, Forms, Members Only, Private Events, Flight Booker, etc.) ne sont **pas** faits tels quels. Leur valeur pédagogique est récupérée différemment : (a) les concepts sont appliqués dans Nine to Fine l'après-midi, (b) les sous-portions les plus formatrices sont isolées en exos sandbox le soir, (c) les Knowledge Check sont **répondus par écrit** (force la verbalisation).
10. **Sandbox par techno** : `~/code/sandbox/` (dossier parent) contient un sous-dossier par technologie (`rails/`, `tailwind/` créés en sem 22 ; `react/`, `typescript/`, `nextjs/` créés aux phases ultérieures si nécessaire). Chaque sous-dossier est un repo Git autonome avec son `.gitignore` adapté. Organisation interne **par concept** (ex: `rails/queries/`, `rails/callbacks/`), date dans les noms de fichiers de chaque session. Voir `~/code/sandbox/README.md`.

---

## Suivi (vivant)

Source unique de vérité pour le journal de bord. À mettre à jour à la fin de chaque journée.

### Sem 22 (25-31 mai 2026)

**Accompli**
- **Lundi 25 mai** : Conception complète : 24 user stories, schéma DB, kanban GitHub, roadmap. Install et config Devise (username, email, password).
- **Mardi 26 mai** : Model User + validation username. ApplicationController (authenticate_user! + configure_permitted_parameters). PagesController (home publique avec skip_before_action). Navbar (user_signed_in?, current_user.username, login/logout/signup). Flashes (_flashes.html.erb). Devise views générées + champ username dans sign up. `db:create` + `db:migrate` OK. Commit + push GitHub.
- **Mercredi 27 mai** :
  - **Matin** : Mise en place de l'environnement de travail Claude. Créé `~/.claude/CLAUDE.md` global (comportement permanent). Créé `CLAUDE.md` projet (stack, models, conventions, démarrage de session). Créé `PLANNING.md` (18 sem, ritual, phases, règles péda). Fix 4 problèmes CI pré-existants (PR #29 mergée : lint rubocop, fixtures users, pages_controller_test, dossier test/system). Upgrade image_processing 1→2 + ajout mini_magick explicite (PR #30 mergée). Setup vault Obsidian `~/Obsidian/DevJobReady/` avec symlink PLANNING.md. Activation protection branche `main` sur GitHub. Migration `NOTES.md` → section Suivi (PR #31, #32, #33 mergées).
  - **Après-midi (setup + apprentissage Tailwind)** : Création `.vscode/settings.json` projet (Tailwind IntelliSense pour ERB). Création `~/Library/.../snippets/erb.json` (snippets `er`/`pe`). Activation `editor.tabCompletion: "on"` dans `dotfiles/settings.json` (commit `9d88492` sur branche `chore/vscode-settings-update`, à pousser vendredi). Config `~/.gitignore_global` avec `.DS_Store` + autres junk macOS. Nettoyage worktrees Claude obsolètes et branches `claude/*`. Mémoire `dotfiles-setup.md` créée pour les futures sessions. Commit PR #34 mergée (`chore: configure VS Code for Tailwind IntelliSense and update planning`).
  - **Apprentissage Tailwind v4** : Lecture *Installation* + *Styling with utility classes*. Découverte échelle Tailwind (1 unité = 4px), paliers de couleurs (50-950), syntaxe arbitraire `[...]`, philosophie utility-first, différences v3/v4 (gradients `bg-linear-to-*`, opacité `/N`).
  - **Production (1re vraie hero responsive)** : Exercice dirigé Mode B avec Claude. Construction d'une hero Nine to Fine sur `home.html.erb` avec dégradé doré, typographie champagne `#E7DBC4`, CTA "Get started" linké à Devise sign up. Refactor architecture layout (`application.html.erb`) : retrait `container mx-auto` et `mt-28` pour permettre les sections full-width. Styling navbar (`bg-zinc-800`, `flex items-center justify-between`, `gap-2`). Application du responsive mobile-first (`text-4xl md:text-5xl lg:text-6xl`, `p-4 md:p-8 lg:p-12`, `min-h-[70vh]`, etc.). Commit PR #35 mergée (`feat: add responsive hero section on home with navbar styling`).
  - **Compétences git renforcées** : Distinction `origin` (remote) vs branche. Stratégies de merge (Merge commit / Squash / Rebase) et choix de Squash and merge par défaut. Workflow complet branche → push → PR → squash merge → pull main → cleanup branche. Gestion du warning `not yet merged to HEAD` post-squash.
- **Jeudi 28 mai** :
  - **Matin (Odin Rails, lecture profonde)** : *Active Record Queries* (chap. Odin 24). Revu : `find` / `find_by` / `where`, scopes, chaînage de scopes, `.pluck`, `.includes` (eager loading + N+1), `.joins`, `where.not`, `has_many :through` avec option `:source`.
  - **Avant-midi (Tailwind, lecture profonde)** : *Responsive design* (3e dans la liste "Prochain" Tailwind). Mobile-first, breakpoints `sm/md/lg/xl/2xl`, container queries v4 (`@container`, `@sm`...), variants `max-*`, customisation via `@theme`. Relecture en parallèle de *Styling with utility classes* et *Hover, focus and other states* pour cohérence avec les résumés Obsidian créés.
  - **Setup environnement** :
    - Section **"Mode coach"** ajoutée au `CLAUDE.md` projet : Chris code 100% du code de production, Claude guide / challenge / explique sans toucher aux fichiers de prod sauf bypass explicite ("écris-le pour moi"). Fichiers méta (CLAUDE.md, PLANNING.md, etc.) restent éditables par Claude après confirmation.
    - **Vault Obsidian restructurée** : création de `Apprentissage/Rails/` (7 sous-dossiers par grand domaine : Active Record, Controllers, Views & Forms, Asset Pipeline & Hotwire, APIs, Mailers/Jobs/Realtime, Transverses) avec `index.md` + 1ère note `has_many_through - class_name, foreign_key, source.md` dans `Active Record/`. Création de `Apprentissage/Tailwind/` (9 sous-dossiers calqués sur la taxo officielle Tailwind) avec `index.md` + 3 notes dans `Core concepts/` : `styling-with-utility-classes`, `hover-focus-and-other-states`, `responsive-design`. Convention : frontmatter YAML standardisé (`created`, `stack`, `version`, `chapitre_doc`/`chapitre_odin`, `tags`, `sources`).
    - **Split Ghostty** configuré (shell pur + Claude Code CLI) pour basculer le workflow code en terminal dès l'aprem.
  - **Après-midi (Production, ~5h en mode coach CLI)** : génération et test des **6 models structurels** sur la branche `models-associations-validations` (PR #38 ouverte en fin de journée). Workflow : Chris code 100% du code en VS Code + shell, Claude coache en CLI parallèle (questions de design avant chaque model, debug live, challenge sur les choix). **7 commits atomiques** : Category + docs archi + Garment + Outfit + OutfitGarment + Tag + Tagging. **~38 tests Minitest verts**, 0 failure, 0 skip.

    Détail par model :
    - **Category** (global, non-scopé user) : `name` unique case-insensitive via `validates uniqueness: { case_sensitive: false }` + index DB `LOWER(name)` matché ; `position` (integer, ordre d'affichage UI). `has_many :garments, dependent: :restrict_with_error`. Seed idempotent avec `find_or_create_by!` (5 catégories : Top / Bottom / Outerwear / Footwear / Accessory).
    - **Garment** : `belongs_to :user`, `belongs_to :category`, `name` (presence, length max 200) + `color` (presence — décision validée pour permettre filtrage par couleur côté UI sans dépendre d'enrichissement IA) + `description` + `brand` (optionnels). `User has_many :garments, dependent: :destroy` (RGPD).
    - **Outfit** : `belongs_to :user`, `name` unique scopé user case-insensitive (composite index `(user_id, LOWER(name))`) + `description` optionnel. `User has_many :outfits, dependent: :destroy`.
    - **OutfitGarment** (pure join) : `belongs_to :outfit` + `belongs_to :garment`, validation `uniqueness: { scope: :outfit_id }` + index DB composite unique sur `[outfit_id, garment_id]`. Asso `has_many :garments, through: :outfit_garments` activée côté Outfit, symétriquement `has_many :outfits, through:` côté Garment.
    - **Tag** : `belongs_to :user`, `name` unique scopé user case-insensitive (même pattern qu'Outfit), `length max 50`. `User has_many :tags, dependent: :destroy`.
    - **Tagging** (**polymorphique** — concept nouveau de la journée) : `belongs_to :tag`, `belongs_to :taggable, polymorphic: true`. Validation `uniqueness: { scope: [:taggable_type, :taggable_id] }` sur `tag_id`. Asso `has_many :tagged_garments` et `has_many :tagged_outfits` via `through: :taggings, source: :taggable, source_type: "Garment"/"Outfit"` côté Tag. Asso `has_many :taggings, as: :taggable, dependent: :destroy` côté Garment et Outfit.

  - **Difficultés / pièges réellement rencontrés (m'ont vraiment coincé)** :
    - **Piège `default: 0` + `validates presence`** : sur le champ `position` de Category, le couple `null: false, default: 0` côté DB faisait échouer la validation `presence: true` côté Rails parce que `0.present? == true`. Cause : ActiveRecord lit le default DB à `new`, donc l'attribut n'est jamais "blank". Fix : rollback migration + supprimer `default: 0` + re-migrate. **Règle à retenir** : tout `validates presence: true` est mensonger si la DB injecte un default non-blank.
    - **`valid?` doit être appelé** pour peupler `errors` : 2 tests `is_invalid_without_X` plantaient avec `assert_includes [], "can't be blank"` parce que le test ne faisait pas `assert_not record.valid?` avant de lire `errors`. ActiveRecord ne lance pas les validations à `Model.new`, seulement à `valid?` / `save` / `update`. Pattern correct : `assert_not record.valid?` puis `assert_includes record.errors[:champ], "msg"`.
    - **`restrict_with_error` → l'erreur va sur `:base`** (pas sur le nom de l'asso) dans Rails 8. Source vérifiée dans `activerecord-8.1.3/lib/active_record/associations/has_many_association.rb:22`. Le message exact est `"Cannot delete record because dependent garments exist"` (ne contient PAS le mot "restrict"). **Réflexe à mémoriser** : ne JAMAIS écrire un `assert_includes` / `assert_match` sur un message d'erreur Rails sans avoir d'abord vu en console (ou via `puts record.errors.messages`) ce que Rails produit réellement. Claude m'a induit en erreur 2 fois sur ce point — la consigne s'applique aussi à lui.
    - **Typo dans label de fixture → `PG::ForeignKeyViolation` au load fixtures**, vécu **2 fois aujourd'hui** : `chirs` au lieu de `chris` dans `garments.yml`, puis `vintagee` au lieu de `vintage` dans `tags.yml`. Rails calcule un ID hash du label → mismatch avec la fixture cible → FK rejetée par PG au commit du load. **Réflexe** : FK violation au load fixtures = vérifier l'orthographe des labels en priorité, c'est 90% des cas.
    - **`has_many :garments` non ajouté dans Category** au moment de la création de Garment → comportement brutal (`PG::ForeignKeyViolation` au lieu de `restrict_with_error` Rails-level). Claude a oublié de me rappeler ce retour dans Category. **Règle à graver** : toute nouvelle association demande **2 éditions de models** (un côté + l'autre côté), un join table en demande **3**. Le `dependent:` n'agit que si le `has_many` correspondant existe.

  - **Nouveaux concepts maîtrisés aujourd'hui (à graver)** :
    - **Defense en profondeur DB + Rails** : `validates uniqueness` côté Rails seul est insuffisant (race condition possible entre 2 requêtes parallèles). Toujours doubler avec un `add_index` DB unique matchant la même sémantique (case, scope).
    - **`t.references X, foreign_key: true`** : raccourci pour 3 choses (column + index + FK constraint). Toujours préférer à `t.integer :user_id` manuel. `null: false` est ajouté par défaut depuis Rails 5.
    - **`belongs_to` auto-valide presence depuis Rails 5** : message d'erreur `"must exist"` (pas `"can't be blank"`). Pour rendre optionnel : `belongs_to :x, optional: true`.
    - **`uniqueness: { scope: :user_id, case_sensitive: false }`** + index DB composite avec expression : `add_index :tags, "user_id, LOWER(name)", unique: true, name: "..."` (le `name:` est obligatoire avec une expression d'index).
    - **Tester les 2 faces d'une contrainte scopée** : "même user, doublon → KO" ET "user différent, même name → OK". Sans le 2e test, le scope pourrait être silencieusement cassé.
    - **`dependent: :restrict_with_error`** vit côté **parent** (pas enfant), erreur ajoutée sur `errors[:base]`.
    - **Associations polymorphiques** : 2 colonnes (`taggable_id` + `taggable_type`) au lieu d'une FK. **Pas de FK constraint DB possible** (une FK ne pointe qu'à une table). Donc `dependent: :destroy` côté `has_many :X, as: :taggable` est ESSENTIEL pour éviter données orphelines.
    - **Fixtures polymorphiques** : syntaxe `taggable: black_tshirt (Garment)` — le `(TypeName)` est obligatoire pour que Rails calcule `taggable_type`.
    - **`has_many :X, through: :join, source: :Y, source_type: "Z"`** : permet à un model de filtrer ses associations polymorphiques par type (ex : `tag.tagged_garments` retourne seulement les Garments, pas les Outfits).
    - **`!` partout en code de test** : `create!`, `save!`, `update!`, `destroy!`. Échec bruyant = debug en 5s. Sans `!`, échec silencieux puis test qui plante 4 lignes plus loin → 20 min de debug pour 1 ligne manquante.
    - **Pas de TODO commenté** dans les models : on ajoute une asso `has_many :X` au moment où le model X existe, pas avant. Le code commenté se périme et trompe le lecteur.

  - **Choix de design importants actés** :
    - **Category globale vs per-user** : choix **global** (seedée) parce que (a) cohérence forte pour l'UI et (b) suggestions IA Phase 4 nécessiteront un référentiel commun. Pas de `belongs_to :user`.
    - **Tag scopé user** (`belongs_to :user`, uniqueness scopée) : chaque user a sa propre taxo de tags ("été" chez Chris et "été" chez John = deux entités distinctes). Liberté UX maximale, le coût est un peu d'éclatement de référentiel — pertinent parce qu'un tag est très personnel ("comfy", "weekend dad").
    - **Tagging polymorphique** plutôt que 2 tables séparées (`garment_taggings` + `outfit_taggings`) : un seul model, asso symétrique sur Garment ET Outfit via `as: :taggable`. Plus DRY, plus extensible si on rajoute un jour `Look` ou autre type de taggable.
    - **Color obligatoire sur Garment** : décision Chris contre la reco initiale Claude d'optionnel. Argument retenu : filtrage par couleur est un besoin métier UX direct, indépendant de l'enrichissement IA futur. Pas de friction réelle à demander 1 mot de couleur à la saisie.
    - **Categories non-supprimables** : `restrict_with_error` côté model + absence d'action `destroy` côté controller à venir = double protection. Une category vide reste non-supprimable par décision produit (taxonomie inhérente à l'application).
    - **Pas d'index unique sur `[user_id, name]` pour Garment** : 2 t-shirts blancs Levi's = scénario réel, l'unicité bloquerait abusivement. Pour Outfit et Tag par contre : unicité scopée car deux outfits / tags du même nom = ambiguïté UX et données pourries (un tag est un identifiant sémantique, pas un objet duplicable).
    - **OutfitGarment unique sur `[outfit_id, garment_id]`** : un même garment ne devrait jamais figurer 2x dans le même outfit (absurde métier).
    - **Cascade de destruction Garment** : `outfit_garments` et `taggings` partent en cascade (`dependent: :destroy`), mais `Outfit` et `Tag` survivent (perte d'un garment ≠ perte d'une tenue / d'un tag réutilisé ailleurs).

  - **Mises à jour collatérales** :
    - `CLAUDE.md` projet : section "Architecture data" enrichie avec les 6 models actés (Category globale, Tag per-user, Tagging polymorphique, scopes et `dependent:` documentés).
    - `app/models/user.rb` : `has_many :garments, :outfits, :tags` avec `dependent: :destroy` partout (RGPD).
    - `test/fixtures/users.yml` : ajout fixtures `chris` et `john` (avec hash bcrypt placeholder — à remplacer par vrai hash quand les controller tests / sign_in arrivent en sem 22-24).
    - `db/seeds.rb` : bloc Category idempotent avec `find_or_create_by!` (rappel : `destroy_all` dans seeds.rb = anti-pattern, utiliser `bin/rails db:reset` pour repartir from scratch en dev).

  - **Points à consolider en exo sandbox ce soir (30-45 min)** :
    - **Priorité 1 (concept le plus neuf) : associations polymorphiques** dans `~/code/sandbox/rails/polymorphic/`. Créer un mini-cas : model `Note` polymorphique pouvant appartenir à `Project` OU `Task`. Tester `as: :notable`, `has_many through:` avec `source/source_type`, fixture syntaxe `notable: foo (Project)`. Exercer la suppression cascade et vérifier l'absence de FK constraint DB (limitation polymorphic).
    - **Bonus si temps** : reproduire le piège `default: 0 + validates presence` sur un autre model. Comprendre quand un default DB est OK (valeur logiquement "vide" comme `false` pour un boolean) vs quand il rend `presence: true` muet.
    - Reports : exos Queries (`.pluck`, `.includes` vs `.joins`) reportés à demain matin pour ne pas surcharger.

  - **À revoir / approfondir en priorité (focus apprentissage post-aprem)** — les 3 zones où je dois encore consolider :

    **1. Polymorphisme** (concept neuf, pas encore solide) :
    - Côté model **polymorphique** (Tagging) : `belongs_to :taggable, polymorphic: true` → génère **2 colonnes** en DB : `taggable_id` (integer) + `taggable_type` (string). Comprendre que `taggable_type` stocke littéralement le nom de la classe ("Garment", "Outfit") sous forme de string.
    - Côté model **taggable** (Garment, Outfit) : `has_many :taggings, as: :taggable, dependent: :destroy`. **Le `as:` est la pièce qu'on oublie facilement** — sans lui, Rails chercherait une FK `garment_id` sur taggings (qui n'existe pas en polymorphic) et planterait.
    - **Pas de `foreign_key: true` possible** sur `t.references :taggable, polymorphic: true`. **Pourquoi ?** Une FK constraint DB ne peut pointer que vers UNE table physique. Polymorphic vise N tables → impossible. **Conséquence** : aucun filet de sécurité côté PG. Si on supprime un Garment sans `dependent: :destroy` → taggings orphelins silencieux en DB.
    - **`has_many :X, through: :Y, source: :Z, source_type: "T"`** : pattern à mémoriser pour filtrer un polymorphic par type côté model parent (Tag). Le `source:` dit "le nom de l'asso dans Y", le `source_type:` filtre sur le type polymorphic. Sans `source_type:`, Tag ne saurait pas séparer ses garments de ses outfits.
    - **Fixtures polymorphiques** : syntaxe `taggable: black_tshirt (Garment)` — le `(TypeName)` est **obligatoire**, sans ça Rails ne sait pas quel `taggable_type` mettre, et le fixture loading plante au `PG::ForeignKeyViolation`.
    - **Questions d'auto-test à se poser** : (a) si je supprime une fixture Garment qui est référencée par un Tagging polymorphic, qu'est-ce qui se passe ? (b) comment écrire `tag.tagged_outfits` si Tag n'avait pas `source_type:` mais juste `through:` ?
    - **À reviser** : doc officielle https://guides.rubyonrails.org/association_basics.html#polymorphic-associations + exo sandbox prévu ce soir (model `Note` polymorphique sur `Project`/`Task`).

    **2. `add_index` dans les migrations** (6 patterns à distinguer clairement) :
    - **Auto via `t.references X`** : ajoute un index **simple, NON unique** sur `X_id`. Sert au lookup rapide via la FK. Présent par défaut, pas besoin d'`add_index` manuel pour ça.
    - **Auto via `t.references X, polymorphic: true`** : ajoute un index **composite, NON unique** sur `[X_type, X_id]`. Sert au lookup polymorphic inverse (donne-moi tous les taggings d'un Garment).
    - **Index unique simple** : `add_index :categories, :name, unique: true`. Rejeté par PG si doublon. **Case-sensitive par défaut.**
    - **Index unique avec expression** : `add_index :categories, "LOWER(name)", unique: true, name: "index_categories_on_lower_name"`. **Le `name:` explicite est obligatoire avec une expression** (Rails ne sait pas auto-nommer un index sur une expression). Permet de matcher une validation Rails `case_sensitive: false`.
    - **Index unique composite simple** : `add_index :outfit_garments, [:outfit_id, :garment_id], unique: true, name: "..."`. Unicité de la **paire** — interdit "même garment 2x dans même outfit".
    - **Index unique composite avec expression** : `add_index :outfits, "user_id, LOWER(name)", unique: true, name: "..."`. Combine scope (`user_id`) ET case-insensitive (`LOWER(name)`). Pattern utilisé pour Outfit et Tag.
    - **Règle pro à graver** : **chaque `validates uniqueness` côté Rails doit avoir son `add_index unique` matchant côté DB**, avec la **même sémantique** (case, scope). Sinon race condition : 2 requêtes parallèles passent la validation Rails et créent un doublon que PG accepte (parce que l'index DB n'existe pas ou est case-sensitive).
    - **Question d'auto-test** : pourquoi ne peut-on pas faire `add_index :categories, :name, unique: true, case_sensitive: false` ? (Réponse : `case_sensitive` n'existe pas comme option d'`add_index` — la sémantique case-insensitive se code via l'expression `LOWER(name)` dans l'index lui-même.)
    - **À reviser** : doc `add_index` https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_index + ouvrir `db/schema.rb` après chaque migration pour visualiser ce qui a été réellement créé en DB.

    **3. Associations complexes** (`has_many through`, `source`, `source_type`, `as:`) :
    - **`has_many :X, through: :Y`** : Y doit être lui-même une asso connue du model (typiquement un `has_many` vers la join table). Permet de "court-circuiter" la join table pour accéder directement à la cible. Ex : `Outfit has_many :garments, through: :outfit_garments` → `outfit.garments` retourne les Garments, pas les OutfitGarments.
    - **`source:`** : utile quand le nom de l'asso côté Y diffère du nom qu'on veut côté parent. Le `source:` dit explicitement "le nom de l'asso DANS le join model". **Réflexe** : si Rails plante avec "could not find the source association", c'est qu'il faut nommer explicitement le `source:`.
    - **`source_type:`** : indispensable quand `source:` pointe vers une asso polymorphique, pour filtrer sur le type. Sinon Rails ne sait pas comment résoudre. Ex : `Tag has_many :tagged_garments, through: :taggings, source: :taggable, source_type: "Garment"`.
    - **`as: :X`** côté `has_many` (Garment, Outfit qui sont les "taggable") : déclare "je suis le côté polymorphic, mes taggings me référencent comme `:taggable`". Sans ça, Rails chercherait une FK `garment_id` sur taggings → plantage.
    - **Ordre de création obligatoire** :
      1. Créer le **join model** d'abord (OutfitGarment ou Tagging).
      2. **Revenir dans les 2 parents** pour ajouter (a) `has_many :join, dependent: :destroy` (b) `has_many :cible, through: :join` (avec `source/source_type` si polymorphic).
      3. **Activer les tests d'asso** après les 2 étapes.
    - **Tester les 2 directions** : si `Outfit has_many :garments through:`, vérifier en test que `outfit.garments` **ET** `garment.outfits` fonctionnent. Si un seul est testé, l'autre peut être silencieusement cassé (ex : si tu oublies le retour dans Garment).
    - **Variantes `dependent:` à connaître** sur `has_many` : `:destroy` (cascade Ruby), `:delete_all` (cascade SQL pure, skip callbacks), `:nullify` (set FK à NULL, requires nullable), `:restrict_with_error` (bloque + erreur sur `:base`), `:restrict_with_exception` (bloque + raise). Pas applicable côté `belongs_to`.
    - **Question d'auto-test** : si je supprime un Garment, que se passe-t-il pour (a) les OutfitGarments qui le référencent, (b) les Outfits qui le contenaient via OutfitGarment, (c) les Taggings polymorphiques le pointant, (d) les Tags référencés par ces Taggings ?
    - **À reviser** : doc https://guides.rubyonrails.org/association_basics.html#the-has-many-through-association + relire le model Tag.rb tel qu'écrit aujourd'hui (le seul model du projet qui combine `through:` + `source:` + `source_type:` en un seul endroit).

  - **Soir prévu** : retour dans la session Claude app pour 3 exos sandbox ciblés (1 Queries + 1 Tailwind + 1 Models/Tests) + mise à jour matricielle du PLANNING.md (18 sem × 4 stacks, lectures jour par jour jusqu'au 27 sept).

- **Vendredi 29 mai (matinée + midi)** :

  - **Matin — Odin Rails** : lecture profonde **20. Form Basics** + Knowledge Check répondu par écrit (règle péda 9). Décision en milieu de matinée d'enchaîner **28. Advanced Forms** plutôt que **22. Sessions/Cookies/Auth** : continuité directe avec Form Basics + application immédiate au CRUD Garment de l'aprem + Devise déjà fonctionnel rend chap. 22 moins urgent (relégué slot du soir ou samedi). Notes Obsidian créées : `Apprentissage/Rails/Views & Forms/form-basics.md` (form_with, CSRF, params imbriqués, `render :new, status: :unprocessable_entity`, triche `_method`) + `Apprentissage/Rails/Views & Forms/advanced-forms.md` (`collection_select`, `fields_for`, `accepts_nested_attributes_for`, `_destroy` + `allow_destroy`, pattern many-to-many appliqué à OutfitGarment). Index Rails mis à jour.

  - **Avant-midi — Tailwind v4** : pivot acté — la chaîne YouTube **Tailwind Labs n'a aucune vidéo récente sur v4** (vérifié par Chris : pas de contenu plus jeune qu'un an, zéro mention v4). Lecture profonde des **docs officielles tailwindcss.com + blog post de lancement v4.0** à la place. Note Obsidian créée : `Apprentissage/Tailwind/Transverses/tailwind-v4-overview.md`. Couvre : nouveau engine (rebuilds 8-100× plus rapides), CSS-first config (`@theme` remplace `tailwind.config.js`), auto content detection (fini le `content:` array), dynamic utility values (`grid-cols-15` direct sans arbitrary syntax), container queries first-class (`@container`, `@sm:`...), palette OKLCH P3, gradients étendus (angles directs `bg-linear-45`, interpolation `/oklch`, conic + radial), transforms 3D, variants nouveaux (`not-*`, `starting:`, `in-*`, `nth-*`), outil migration v3→v4. Index Tailwind mis à jour (ordre lecture : 3-4 marqués ✅, 5 marqué ⏳ avec lien vers la note).

  - **Workflow PLANNING.md (matinée)** : 2 PR mergées.
    - **PR #39** (`chore(planning): defer Friday exos + routine to Saturday`) : déplace les exos sandbox du soir jeudi (polymorphic + piège `default: 0`/`validates presence`) à samedi + déplace la routine `/end-of-day` (initialement prévue vendredi midi) à samedi. Saturday row enrichie avec 5 chantiers + priorité de coupe (ménage dotfiles puis Tailwind si débordement).
    - **PR #40** (`chore(planning): add Saturday strategic discussion + Option D decision`) : ajoute item `(0) PRIORITÉ MATIN` dans Saturday row + section Ajustements détaillée avec contexte de la décision + Option D + **5 points à trancher samedi matin**. Marqué non-coupable.

  - **Décision stratégique actée (midi)** : **Option D** pour Phases 2-3-4 — saupoudrer Nine to Fine sur Phases 2-3 (**1.5 j/sem** au lieu de 1) pour viser **v1 polishée + déployée mi-juillet**, et reformuler Phase 4 en **sprint d'enrichissement** (IA + Tailwind v4 polish + deploy + refactor partiel) plutôt que refonte SPA complète. **+ Contrainte additionnelle** : produire **un projet React/TS vitrine séparé** d'ici fin Phase 4 (en plus de N to F). 5 points concrets à trancher samedi matin (voir section "Ajustements pour la suite", point "PRIORITÉ MATIN").

  - **Workflow git matinée** : 3 PR ouvertes et mergées (#39, #40, et le récap matinée lui-même). Cleanup branche locale `chore/planning-saturday-strategic-refresh` faite. **Branche `feature/garment-crud` créée vide**, à rebaser sur main à jour avant attaque CLI cet aprem.

  - **Méta-leçon prise (à graver)** : **vérifier la date des ressources externes avant de les recommander** — leçon après ma fausse référence initiale à une "playlist Tailwind v4" sur YouTube Tailwind Labs qui n'existait pas / était périmée. À étendre à toute ressource externe (tutos, vidéos, articles). Ma mémoire d'entraînement peut être périmée — confronter à la réalité avant de recommander.

  - **Aprem prévu** : CRUD Garment selon programme sem 22 vendredi (controller + vues new/show/index/edit + flow local + premier styling Tailwind sur page Garment). Setup : Claude Code CLI en Ghostty split (panel shell pour `rails s` + git + VS Code, panel CLI pour coaching). Mode coach actif : Chris code 100% du code de prod, Claude challenge sans toucher aux fichiers via Edit/Write (sauf bypass explicite).

- **Vendredi 29 mai (après-midi)** : Production CRUD Garment complet en mode coach strict, ~3h sur branche `feature/garment-crud`. **PR #42 mergée** (commit `2855fb2` sur main).

  - **Livrables code** : 7 routes RESTful (`resources :garments`), `GarmentsController` complet (7 actions, before_actions `set_garment` + `set_categories` sur les 4 actions concernées, strong params via `params.expect` Rails 8), 5 vues (`index`, `show`, `new`, `edit`, `_form.html.erb` partial partagé), flow testé en local end-to-end : create valide + invalide (422 + erreurs inline), read (index avec `includes` + `order`, show), update valide (303) + invalide (422), destroy (303 + turbo_confirm).

  - **Méthode** : Mode coach strict respecté de bout en bout. Chris a tapé 100% du code de production, Claude a coaché en CLI parallèle (questions de design avant chaque étape, debug live, challenge des choix, lecture du code via `Read` uniquement, jamais `Edit`/`Write`). Bypass explicite ponctuel sur les fichiers méta (PLANNING.md, Obsidian, ouverture PR) en fin d'aprem.

  - **Concepts maîtrisés et idiomes Rails 8 appliqués** :
    - **Routes RESTful** : `resources :garments` → 7 actions, 8 lignes (PATCH + PUT pour `update`). Réflexe pro acté : **lire la colonne `Prefix` de `bin/rails routes`** = nom littéral du helper, ne pas deviner.
    - **Scoping per user via association** : `current_user.garments.find(params[:id])` partout dans `set_garment` → sécurité (404 si garment d'un autre user, on ne révèle pas l'existence) + chargement en 1 ligne. **JAMAIS** `Garment.find` puis check authorization à part.
    - **Strong params `params.expect`** (Rails 8) au lieu de `params.require.permit`. Idiome confirmé via lecture du template scaffold Rails 8.1.3 (`railties-8.1.3/.../scaffold_controller/templates/controller.rb.tt`).
    - **Statuts HTTP Turbo critiques** :
      - `status: :unprocessable_content` (422) sur `render :new`/`render :edit` après échec → Turbo voit 422 → remplace le DOM avec le form re-rendu. **À noter** : `:unprocessable_entity` (ancien) est auto-traduit en `:unprocessable_content` côté Rails (constant `ActionDispatch::Constants::UNPROCESSABLE_CONTENT` résout selon la version de Rack — Rack 3.2.6 sur ce projet → `:unprocessable_content`).
      - `status: :see_other` (303) sur redirect après `update` success ET `destroy` → force Turbo à GET la redirect au lieu de redo PATCH/DELETE.
    - **`form_with model: garment`** : magie centrale. Génère URL + méthode HTTP + CSRF + valeurs pré-remplies + texte du submit, switche POST/PATCH selon `garment.new_record?`. Permet UN SEUL partial `_form.html.erb` partagé entre `new` et `edit`.
    - **Partials avec locals explicites** : `render "form", garment: @garment`. Pattern pro qui explicite la dépendance du partial, le rend testable/réutilisable.
    - **`button_to` vs `link_to` pour les actions non-GET** : `button_to ..., method: :delete` (jamais `data: { turbo_method: }` sur button_to — c'est l'ancien pattern UJS-link). `link_to` reste pour les GET. `button_to` pour POST/PATCH/DELETE.
    - **`collection_select(:method, collection, value_method, text_method, options)`** : signature à graver. Appliquée pour `category_id` avec `prompt:` pour guider l'UX (sélection obligatoire de toute façon via `belongs_to :category` auto-presence).
    - **N+1 prevention** : `current_user.garments.includes(:category).order(created_at: :desc)` sur index. Vérifiable dans les logs Rails (1 `Garment Load` + 1 `Category Load` avec `WHERE id IN (...)`).
    - **`.order(...)` toujours** sur les collections affichées (sinon PG ne garantit aucun ordre).
    - **DevTools Network** : 5 statuts à connaître (200, 303, 422, 404, 500). Workflow pro = garder Network ouvert pendant le dev.

  - **Pièges réellement rencontrés (par ordre chrono, à graver)** :
    1. **Confusion PUT vs PATCH** sémantique HTTP. PUT = remplacement complet, PATCH = partiel. Rails route les 2 vers `update` (rétrocompat depuis Rails 4 qui a basculé le défaut). Question d'entretien fréquente.
    2. **Confusion singulier/pluriel des helpers** : `edit_garments_path` au lieu de `edit_garment_path` (faute classique). **Réflexe** : lire la colonne Prefix.
    3. **Bug `current_user.new`** au lieu de `current_user.garments.new` (oubli `.garments`) → `NoMethodError`. Pattern à graver : quand tu écris `current_user.X`, demande-toi si X est une collection ou une méthode User.
    4. **Oubli `status: :see_other` sur update success** (mis sur destroy mais oublié sur update). Bug Turbo subtil : redirect refait un PATCH → erreur silencieuse.
    5. **`button_to "Delete", garment, data: { turbo_method: :delete }`** au lieu de `method: :delete`. Mélange UJS-link / Turbo-button. Génère un POST → `RoutingError [POST] "/garments/2"`.
    6. **`@categories = nil` au re-render après échec** : `render :new` dans `create` ne re-trigger PAS l'action `new` ni ses setups. **Solution propre** : `before_action :set_categories, only: %i[new create edit update]` couvre les 4 cas. **Mea culpa Claude** : reco initiale "appel explicite dans `new`/`edit`" était sous-optimale, le before_action couvre nativement les re-renders.
    7. **`errors[:category_id]` vide quand `belongs_to :category` valide presence** : l'auto-validation `belongs_to` (Rails 5+) range l'erreur sur `errors[:category]`, **pas** sur `errors[:category_id]`. Fix : check sur `:category` dans le partial. **Réflexe** : `errors.attribute_names` en console pour voir où Rails range ses erreurs. Ne devine jamais.

  - **Notes Obsidian créées** (7 notes ciblées sur les pièges + concepts critiques de l'aprem + workflow debugging + workflow lint) :
    - `Apprentissage/Rails/Views & Forms/form-with-html-deconstruction.md` — décomposition HTML précise (ce que `form_with model:` génère vs HTML brut, magie POST/PATCH via `new_record?`, le hidden `_method`). Complète [[form-basics]] avec un focus "ce que Rails écrit pour toi sous le capot".
    - `Apprentissage/Rails/Controllers/scoping-current-user.md` — pattern `current_user.garments.find` (sécurité + chargement + idiome).
    - `Apprentissage/Rails/Controllers/before-action-rerenders-pitfall.md` — piège `render :new` qui ne re-trigger pas les setups, solution `before_action` sur les 4 actions.
    - `Apprentissage/Rails/Active Record/belongs-to-error-key-trap.md` — `errors[:category]` vs `errors[:category_id]` quand `belongs_to` valide presence.
    - `Apprentissage/Rails/Asset Pipeline & Hotwire/turbo-status-codes-303-422.md` — pourquoi 303 sur destroy/update success et 422 sur form invalide, lecture via DevTools Network.
    - `Apprentissage/Rails/Transverses/debugging-workflow-pro.md` — workflow pro de debugging (logs terminal Rails + DevTools Network + console + bullet gem). À internaliser.
    - `Apprentissage/Rails/Transverses/rubocop-rails-omakase.md` — workflow lint (commande `bundle exec rubocop -a` vs `-A`, lecture des offenses, intégration CI). Concept lint vu en bout d'aprem en débloquant la CI rouge de la PR #42.
    - Index Rails mis à jour avec ces 7 nouvelles entrées.

  - **Vérification source** (règle péda 4) : avant de valider `:unprocessable_content`, `params.expect`, `status: :see_other`, lecture directe du template scaffold Rails 8.1.3 dans `railties-8.1.3/.../templates/controller.rb.tt`. Source de vérité authoritative. Ma mémoire seule est insuffisante.

  - **Reste à faire cet après-midi (suite immédiate, sur nouvelle branche `feature/garment-crud-tailwind` à créer depuis main à jour)** :
    - Pass styling Tailwind sur `index`, `show`, `_form` (cohérent avec palette zinc + champagne `#E7DBC4` de la home).
    - Mini-affinement : remplacer `params[:id]` par `params.expect(:id)` dans `set_garment` (idiome Rails 8 pur, différentiel mineur, non-bloquant).
    - Lien "Edit" sur la page `show` (UX cohérente REST).
    - Gestion fallback pour `brand`/`description` `nil` sur `show` (`.presence || "—"`).
    - Upload photo via Active Storage reporté sem 23.

  - **À instaurer dans le projet (timing à acter)** :
    - **Gem `bullet`** (détection automatique des N+1 + missing eager loading) — à ajouter au `Gemfile` groupe `development`. Configurée pour alerter en console + footer HTML en dev. Standard dans tous les projets Rails sérieux. **Timing suggéré** : début sem 23 quand on attaque le CRUD Outfit (jointures plus complexes via `has_many :through`, terrain idéal pour N+1).

  - **Dette technique acceptée — tests controller Garment manquants** :
    - **Constat** : la PR #42 a mergé un `GarmentsController` de 7 actions (54 lignes) avec un fichier `test/controllers/garments_controller_test.rb` **vide** (0 run, 0 assertion, juste les commentaires placeholder du scaffold). Le flow CRUD a été testé **manuellement en local end-to-end** (signup → create valide + invalide → read → update valide + invalide → destroy), mais **aucun test automatisé n'existe**. C'est un trou critique pour un projet vitrine — toute regression future passera silencieusement.
    - **Décision (vendredi 29 mai)** : ne **pas** combler avec Minitest maintenant. RSpec arrive en sem 24 (Phase 1, jeudi 11 ou vendredi 12 juin). Écrire les tests Minitest puis les ré-écrire en RSpec ferait du travail jeté. On accepte la dette **pour ~10 jours**, le temps d'arriver à RSpec.
    - **À écrire en sem 24** (en plus du programme normal sem 24 — CRUD Outfit + composition tenues) : **suite RSpec rétroactive sur `GarmentsController`** couvrant les 7 actions, avec à minima :
      - `index` : retourne uniquement les garments de `current_user` (test de scoping → vérifier qu'un garment d'un autre user n'apparaît pas).
      - `show` : 404 si garment d'un autre user, 200 si garment du current_user.
      - `new` : 200, formulaire rendu avec `@categories` chargé.
      - `create` : params valides → redirect 302 + garment en DB + `user_id == current_user.id` ; params invalides (name vide, color vide, category_id manquant) → 422 + form re-rendu avec erreurs.
      - `edit` : 404 si garment d'un autre user, 200 si garment du current_user, `@categories` chargé.
      - `update` : params valides → redirect 303 ; params invalides → 422.
      - `destroy` : redirect 303 + garment supprimé en DB ; 404 si garment d'un autre user.
      - **Test de sécurité IDOR explicite** : un user A connecté qui appelle `/garments/<id_du_user_B>` → 404 pour show/edit/update/destroy.
    - **Risque accepté** : si un bug de regression survient sur Garment d'ici sem 24, on le détecte uniquement par test manuel ou par bug en local. Mitigation : zone Garment fonctionnellement stable jusqu'à sem 24 (pas de nouveau CRUD touchant Garment dans le programme sem 23 — uniquement Tailwind + Active Storage).
    - **À ne PAS oublier** : ce report est **explicitement noté ici** pour éviter le piège classique "on a oublié d'écrire les tests" en mode "ça marchait en manuel, on est passés à autre chose".

  - **Consolidation perso à revoir (Chris)** : workflow de lecture des logs. Aujourd'hui les logs Rails (terminal `bin/rails s`) ont été consultés ponctuellement pour vérifier le N+1 sur index, mais le réflexe pro n'est pas encore solide. À travailler en miroir : lecture **terminal Rails** (logs des requêtes SQL, params reçus, erreurs avec stack trace) **+ DevTools Network** (statuts HTTP, headers, response body, requêtes XHR/Turbo). Voir nouvelle note Obsidian `Transverses/debugging-workflow-pro.md` créée aujourd'hui.

- **Vendredi 29 mai (fin d'après-midi)** : Pass de styling Tailwind v4 sur les 5 vues du CRUD Garment, en mode coach strict (Chris tape 100% du code, Claude challenge / explique / relit via `Read`). Branche `feature/garment-crud-tailwind` depuis main à jour. **PR #45 ouverte** (commits `e5e50ee` + `deebfcf`).

  - **Livrables** :
    - **Token `@theme`** dans `app/assets/tailwind/application.css` : `--color-champagne: #E7DBC4` → génère `text-champagne` / `bg-champagne` (config CSS-first v4, source unique de la couleur de marque). zinc / yellow / red restent les built-in Tailwind, non redéfinis.
    - **`_form` partagé** : champs verticaux (label `block text-sm font-medium text-zinc-700` + input `block w-full rounded-md border border-zinc-300 px-3 py-2 ... focus:ring-2 focus:ring-zinc-500` + erreur `text-sm text-red-600`). Classe CSS custom `field-error` **supprimée** → utility-first strict (conforme CLAUDE.md). Submit primaire `bg-zinc-900 text-champagne hover:bg-zinc-700`.
    - **`new` / `edit`** : enveloppe `min-h-screen flex items-center justify-center` + fond dégradé hero `bg-linear-to-tr from-yellow-900 to-yellow-50` (identique home) + card `max-w-lg rounded-xl shadow-xl overflow-hidden` (header photo placeholder `h-75` + body `p-6 md:p-8`).
    - **`show`** : grande card `max-w-6xl` divisée **60/40** via `grid grid-cols-1 md:grid-cols-5` + `col-span-3` / `col-span-2` (empilé mobile, 2 colonnes dès `md`). Photo `h-64 md:h-auto` (stretch grille desktop). Attributs en `<dl>` sémantique. Outfits + tags en pills `rounded-full` (`flex flex-wrap gap-2`) + empty states `italic text-zinc-400`. Actions Edit (primaire) + Delete (`button_to` destructif outline rouge) côte à côte via `flex-1` (+ `form_class: "flex-1"` sur le button_to).
    - **`index`** : grille de cards `grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6` sur fond dégradé doré. Cards cliquables (`link_to garment do … end`, `block`) avec effet au survol `relative transition duration-300 ease-out hover:scale-105 hover:shadow-2xl hover:z-10`. État vide stylé. Badge catégorie pill + `shrink-0`.
    - **Layout** : navbar `sticky top-0 z-50` posée sur le `<header>` (pas le `<nav>`) + `font-sans` sur `<body>`. Navbar passée au token `text-champagne`.
    - **Controller** : `params[:id]` → `params.expect(:id)` dans `set_garment` (idiome scaffold Rails 8.1.3, confirmé par lecture du template).

  - **Classes / concepts Tailwind v4 particuliers appliqués** (détail dans la note Obsidian) : `@theme` + tokens couleur ; `bg-linear-to-tr from-* to-*` (gradient v4) ; `grid-cols-N` + `col-span-N` pour des ratios propres ; responsive mobile-first `md:` ; `hover:scale-*` + `relative` + `hover:z-*` (effet grow sans débordement cassé) ; `flex-1` (largeurs égales) ; `flex-wrap gap-*` (pills) ; `overflow-hidden` + `rounded-*` (clip des coins arrondis) ; `shrink-0` (anti-écrasement flex) ; `min-h-screen` vs `h-screen` (jamais figer une hauteur sur un conteneur centré) ; `text-shadow-lg/30` ; **valeurs dynamiques v4** (`h-75` = 300px sans config).

  - **Pièges réellement rencontrés (à graver)** :
    - **Un espace dans une classe = classe cassée** : `to yellow-50` (au lieu de `to-yellow-50`) → dégradé sans couleur d'arrivée (fond vers transparent). Variantes du même piège : `bg-whiterounded-md`, `cursors pointer`, `flex.`, `justifybetween`, `rounded-mdhover:bg-zinc-700` (jointure mangée en recompactant une chaîne multi-lignes). **Réflexe** : après toute fusion/réécriture de classes, relire « chaque classe est-elle isolée par un espace ? ».
    - **`sticky top-0` qui ne colle pas** : la nav était seule dans un `<header>` de sa propre hauteur → conteneur trop court, elle sort de l'écran aussitôt. Fix : poser le `sticky` sur le `<header>` (enfant direct de `<body>`, donc conteneur = tout le scroll). Règle : sticky colle tant que **son parent reste visible** ; 2e cause classique = un ancêtre en `overflow-hidden/auto/scroll`.
    - **`text-zinc-900` sur `<body>`** (proposé par Claude, **refusé à raison par Chris**) : impose une couleur globale qui rend le texte illisible dans les sections à fond sombre (navbar). La **couleur de texte reste contextuelle**, jamais figée à la racine ; seule la **police** (`font-sans`) est légitimement globale. Mea culpa Claude.
    - **`@garment.outfit.any?`** (singulier) → `NoMethodError`, pris à tort pour un problème de controller. Les associations vivent au niveau **model** ; lire le message d'erreur exact (nom de méthode + ligne) avant d'émettre une hypothèse.
    - **`grid-col-5`** (manque le `s`, c'est `grid-cols-5`) → pas de split desktop. **`<dl>` ré-ouvert à chaque paire** → HTML malformé. **`row: 3`** au lieu de `rows: 3` sur `text_area` (attribut HTML, pas une classe), deux fois.
    - **Select natif** : police différente (résolue par `font-sans` global hérité via preflight) + surlignage **mauve** = couleur d'accent **système macOS**, non stylable proprement sur un `<select>` natif (popup rendu par l'OS). Décision : accepter (cosmétique lié à la config perso), pas de composant custom aujourd'hui.

  - **Décisions design actées** :
    - **Champagne = accent sur fond sombre uniquement** (texte de bouton `bg-zinc-900 text-champagne`, rappel du CTA home) — JAMAIS texte courant sur card claire (illisible).
    - Index = **grille de cards** (app garde-robe visuelle) ; show = **split 60/40** photo|infos, colonne photo prévue pour un futur swipe d'outfits.
    - Cards index **cliquables épurées** (clic → show, actions sur show) car `<a>` / `button_to` imbriqués = HTML invalide.

  - **Notes Obsidian créées** :
    - `Apprentissage/Tailwind/Transverses/garment-crud-styling-classes-et-structure.md` — résumé des classes Tailwind v4 particulières / principales du chantier + schéma de la structure des vues (enveloppe section + card, grid 60/40, grille responsive).

  - **Dette / reports** :
    - Upload photo **Active Storage reporté sem 23** (zones photo en placeholder `bg-zinc-100`).
    - Pills outfits/tags non cliquables (pas encore de routes `outfits`/`tags`) → `<span>`, cliquables au CRUD Outfit sem 24.
    - **Extraction d'un partial `_field`** (DRY des chaînes de classes input répétées 5×) discutée mais **reportée délibérément** : on style en utilities brutes d'abord, on extrait une fois le pattern stabilisé. Position pro retenue = composant / partial Rails, **PAS `@apply`** (anti-pattern Tailwind Labs + interdit par CLAUDE.md « utility-first strict »).
    - Dette tests RSpec controller (PR #42) inchangée → toujours sem 24.

  - **Rendu visuel non vérifié par Claude** (lecture de code uniquement) : validation à l'œil par Chris dans le navigateur (dégradé cohérent avec la home, sticky au scroll, scale des cards, lisibilité du titre index sur le haut clair du dégradé).

**Blocages**
- _Rien à signaler pour l'instant._

**Ajustements pour la suite**

- **Samedi 30 mai — PRIORITÉ MATIN — Refonte stratégique planning Phases 2-3-4**.

  **Contexte** : vendredi 29 mai midi, en relisant le PLANNING, Chris a réalisé qu'à partir de Phase 2 Nine to Fine passe en "maintenance 1 j/sem", qu'en Phase 3 il disparaît, et que Phase 4 est censée être une **refonte SPA complète** (Rails API + React+TS+Tailwind front + IA + deploy) sur 4 semaines. Risque identifié : (a) sprint Phase 4 trop tendu pour 4 semaines, (b) pendant la recherche emploi en Phases 2-3 (lancée mi-juin), la vitrine = v1 brute non déployée → on se montre avant d'être prêt, (c) 4 semaines sans toucher N to F (Phase 3) = friction de remise en route.

  **Décision actée** : **Option D — saupoudrer N to F sur Phases 2-3 (1.5 j/sem)** pour viser **v1 polishée + déployée mi-juillet**, et faire de **Phase 4 un sprint d'enrichissement** (IA + Tailwind v4 polish + deploy + éventuel refactor partiel) plutôt qu'une refonte SPA complète. **+ Contrainte additionnelle** : Chris veut **aussi un projet React/TS vitrine séparé** à montrer d'ici fin Phase 4, en plus de N to F.

  **5 points à trancher samedi matin à tête reposée** :

  1. **Cadence N to F en Phase 2-3** : 1.5 j/sem confirmé ou ajustable ? Quel jour fixe de la semaine ? Quelles features prioritaires pour atteindre "v1 polishée + déployée mi-juillet" (Tags UI ? Recherche/filtres ? Tailwind polish complet ? Tests RSpec robustes ? Deploy via Kamal ?) ?
  2. **Recalibrage du slot React/TS** : si on donne 1.5 j/sem à N to F au lieu de 1, ça mange 0.5 j sur quoi exactement (sandbox du soir ? après-midi React ? les 2 ?) ? Impact sur la profondeur React/TS à présenter en entretien.
  3. **Choix du projet React/TS vitrine séparé** : upgrade d'un mini-projet existant (ex: `react-notes` → app sérieuse avec auth + sync + offline + IA) vs concept neuf (mood/habit tracker, outil prep entretiens, lecteur RSS perso, etc.) ? À quel moment du planning il démarre ? Comment il s'imbrique avec la migration TS des mini-projets en Phase 3 ? Est-ce qu'il consomme déjà l'API Rails (ou une autre API) ?
  4. **Refonte Phase 4** : préciser le scope sprint d'enrichissement N to F (IA + Tailwind v4 polish + deploy + refactor partiel ?). Avec quel reste de temps pour finaliser le projet vitrine React/TS séparé ?
  5. **Maj concrète du `PLANNING.md`** : refonte des tableaux semaine-par-semaine de Phases 2-3-4 + section "Recherche emploi — jalons" pour aligner les jalons sur la nouvelle réalité (vitrine N to F prête mi-juillet, candidatures avec app présentable à partir d'août, projet React/TS séparé visible mi-septembre).

  **Méthode samedi** : ouvrir cette section avant de toucher au code de la journée. Discuter point par point avec Claude (challenge attendu). Acter les décisions dans le PLANNING.md (refonte des tableaux). Seulement ensuite passer aux 5 autres chantiers tactiques (Odin catch-up, sandbox exos, etc.).

- **Samedi 30 mai (suite)** : voir détail des 5 chantiers tactiques dans le tableau "Sem 22" — rattrapage Odin 17/18/19, exo sandbox piège `default: 0 + validates presence` (polymorphic déplacé à dimanche), Tailwind layouts, routine `/end-of-day`, ménage dotfiles.

- **Dimanche 31 mai — DÉROGATION explicite à la règle "Dimanche OFF obligatoire"** (actée vendredi 29 mai en fin de journée).

  **Contexte de la dérogation** : vendredi 29 mai 21h. Chris a livré CRUD Garment (PR #42) + styling Tailwind v4 (PR #45) + 8 notes Obsidian de qualité + récap PLANNING détaillé (PR #43, #44, #46). En fin de journée, fatigué, Chris décide de **ne PAS faire l'exo dirigé du soir** (slot ritual normal) et de **décaler 3 exos de révision à dimanche**, en assumant la rupture avec sa propre règle "Dimanche OFF obligatoire" (cf. ritual quotidien + tableau sem 22 + règle péda).

  **Challenge de Claude refusé par Chris** : Claude a explicitement challengé la décision en proposant 2 alternatives (Option A : redistribution sur lundi soir / Option B : 1 seul exo light dimanche). Chris a maintenu sa demande avec l'argument "je sais ce que je fais". Décision respectée et notée ici pour traçabilité.

  **Les 3 exos décalés dimanche** (détail dans la cellule du tableau sem 22) :
  1. **`_field` partial DRY** sur `app/views/garments/_form.html.erb` — extraction du pattern d'input répété 5×. Court (~20-30 min). Mentionné explicitement comme "reporté délibérément" dans le récap Tailwind PR #46.
  2. **Mini-exo Tailwind grid 60/40 sandbox** dans `~/code/sandbox/tailwind/grid-60-40/` — reproduire le split de `show.html.erb` (~30-45 min).
  3. **Polymorphic Rails sandbox** dans `~/code/sandbox/rails/polymorphic/` — `Note` polymorphique sur `Project`/`Task`, `as: :notable`, `has_many through:` + `source/source_type`, cascade. Initialement reporté de jeudi soir à samedi, redéplacé samedi → dimanche pour alléger samedi (~45-60 min).

  **Compteur dérogations à surveiller sur 18 semaines** :
  - Dérogation 1 : **dimanche 31 mai 2026** (sem 22). Motif : exos sandbox décalés.
  - Règle d'alerte : si **≥ 3 dérogations en 6 semaines glissantes**, signal de surcharge → revoir le rythme de la phase courante avec Chris (cadence Odin, charge Nine to Fine, volume sandbox).
  - À mettre à jour à chaque future dérogation (date + motif + numéro d'ordre).

<!-- Ajouter une section par semaine au fur et à mesure -->
<!-- Compteur dérogations dimanche OFF : 1 (31 mai 2026, sem 22, exos sandbox) -->

