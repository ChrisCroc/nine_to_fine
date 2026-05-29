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
| Vendredi | 29 mai     | CRUD Garment (controller + vues new/show/index/edit) + tester le flow en local + premier styling Tailwind sur la page Garment                                                                                                                                                                                                                                  | ⬜                                                                                                                                                                      |
| Samedi   | 30 mai     | **Journée chargée (~7-8h, Chris dispo toute la journée)**. **(0) PRIORITÉ MATIN — Refonte stratégique planning Phases 2-3-4** : Option D actée vendredi 29 mai midi + projet React/TS vitrine séparé à acter — voir liste des 5 points à trancher dans la section "Ajustements pour la suite". À faire AVANT les autres chantiers (tête reposée, refonte concrète des tableaux Phase 2-3-4). (1) **Rattrapage Odin lectures courtes** : 17. Asset Pipeline + 18. Importmaps + 19. Turbo Drive (compense le saut à 20. Form Basics vendredi matin). (2) **Exos sandbox reportés de jeudi soir** : polymorphic (`~/code/sandbox/rails/polymorphic/` — model `Note` polymorphique sur `Project`/`Task`, tester `as: :notable`, `has_many through:` avec `source/source_type`, cascade `dependent: :destroy`) + piège `default: 0 + validates presence` sur un autre model. (3) **Tailwind** : layouts (Tailwind Labs YouTube vidéo "Building responsive layouts") + navbar responsive. (4) **Routine `/end-of-day`** (reportée de vendredi pause midi) : créer avec Claude un skill Claude Code (`~/.claude/skills/end-of-day/SKILL.md`) qui génère la mise à jour du Suivi à partir des commits du jour + propositions d'exos sandbox. (5) **Ménage dotfiles** : 3 fichiers modifiés à commiter séparément, investiguer `package.json` non tracké, décider sort branche `chore/vscode-settings-update` (commit `9d88492`). **Priorité de coupe si débordement** : ménage dotfiles → reportable, puis Tailwind → reportable. La refonte stratégique (0) n'est PAS coupable. | ⬜ |
| Dimanche | 31 mai     | OFF                                                                                                                                                                                                                                                                                                                                                            | ⬜                                                                                                                                                                      |
| 24       | 8-14 juin  | CRUD Outfit + composition de tenues                                                                                                                                                                                                                                                                                                                            | OutfitGarment join, page de composition d'outfit, premiers tests RSpec                                                                                                 |
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

- **Samedi 30 mai (suite)** : voir détail des 5 chantiers tactiques dans le tableau "Sem 22" — rattrapage Odin 17/18/19, exos sandbox polymorphic + piège default, Tailwind layouts, routine `/end-of-day`, ménage dotfiles.

<!-- Ajouter une section par semaine au fur et à mesure -->
