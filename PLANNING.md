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

- **Fait** : Rails Basics, Active Record Basics, Validations, Migrations, **Associations** (✅ dernier complété)
- **Prochain (à faire)** : Active Record Callbacks → Active Record Querying → Forms et Form Helpers → Authentication (manuelle, comprendre Devise) → Building APIs → Testing (Minitest puis introduction RSpec)
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

| Slot | Durée | Activité |
|---|---|---|
| **Matin** | 1h30-2h | **Odin Project — Rails** (sujet du jour défini selon la phase) |
| **Avant-midi** | 2h30-3h | **Focus apprentissage** de la phase courante (Tailwind / React / TS / Next selon période) |
| **Après-midi** | 2h30-3h | **Production projet** (Nine to Fine en P1 / mini-projets en P2-3 / vitrine en P4) |
| **Soir** | 30-45 min | **Exercice dirigé avec Claude** (continuité hebdomadaire) |
| **Vendredi PM** | 1h (dès sem 25) | **Recherche emploi** : candidatures, mise à jour LinkedIn/GitHub, contacts alumni |
| **Samedi** | 4-5h | **Rattrapage / projet / recherche emploi** |
| **Dimanche** | OFF | Repos obligatoire |

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

| Jour | Date | Programme | Statut |
|---|---|---|---|
| Lundi | 25 mai | Conception complète (user stories, schéma DB, kanban GitHub, roadmap) + install et config Devise (username, email, password) | ✅ |
| Mardi | 26 mai | Model User + ApplicationController (authenticate_user! + permitted_parameters) + PagesController (home publique) + navbar + flashes + devise views | ✅ |
| Mercredi | 27 mai | Setup environnement de travail : `~/.claude/CLAUDE.md` global + `CLAUDE.md` projet + `PLANNING.md` 18 sem + fix CI (PR #29) + upgrade image_processing 2.0.1 (PR #30) + vault Obsidian `DevJobReady` | ✅ |
| Jeudi | 28 mai | Générer les **6 models structurels** dans l'ordre : Category → Garment → Outfit → OutfitGarment → Tag → Tagging (`rails g model X`) + migrations + `db:migrate` + vérifier associations en console. **Like/Comment/Follow reportés à sem 25** (générés au moment de leur implémentation). **AiSuggestion reporté à Phase 4 sem 36-37** (intégration agent IA). | ⬜ |
| Vendredi | 29 mai | CRUD Garment (controller + vues new/show/index/edit) + tester le flow en local + premier styling Tailwind sur la page Garment | ⬜ |
| Samedi | 30 mai | Tailwind layouts (Tailwind Labs YouTube : vidéo "Building responsive layouts") + navbar Tailwind responsive | ⬜ |
| Dimanche | 31 mai | OFF | ⬜ |
| 24 | 8-14 juin | CRUD Outfit + composition de tenues | OutfitGarment join, page de composition d'outfit, premiers tests RSpec |
| 25 | 15-21 juin | Likes, Comments, Follows, profils publics + **LANCEMENT RECHERCHE EMPLOI** | Models sociaux générés (Like, Comment, Follow) + Likes/Comments/Follow fonctionnels, profil user public. **LinkedIn + GitHub à jour. 3 premières candidatures Rails.** |

### Phase 2 — React fondamentaux (sem 26-31, 22 juin → 2 août)

**Focus apprentissage** : React (Scrimba CS Career Path + react.dev officiel).
**Odin Rails** : APIs Rails + Testing RSpec à fond (faiblesse classique des juniors).
**Nine to Fine** : en maintenance (1 jour/sem pour ne pas perdre Rails).

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

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 32 | 3-9 août | Types primitifs, interfaces, types de fonctions | Migration `react-todo` → TS |
| 33 | 10-16 août | Generics, narrowing, types utilitaires | Migration `react-weather` → TS (types pour API response) |
| 34 | 17-23 août | TS avancé : discriminated unions, `satisfies`, mapped types | Migration `react-notes` → TS strict |
| 35 | 24-30 août | TS + React patterns pro (props strictes, hooks typés, contextes typés) | Tous mini-projets en TS strict, README pro pour chacun. **Projet vitrine acté : Nine to Fine v2.** |

### Phase 4 — Projet vitrine + emploi intensif (sem 36-39, 31 août → 27 sept)

**Focus apprentissage** : Next.js (Learn Next.js officiel) si dans les temps. Sinon, vanilla React+TS+Vite.
**Odin Rails** : Advanced topics + révision en mode entretien (questions techniques classiques).

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

---

## Suivi (vivant)

Source unique de vérité pour le journal de bord. À mettre à jour à la fin de chaque journée.

### Sem 22 (25-31 mai 2026)

**Accompli**
- **Lundi 25 mai** : Conception complète : 24 user stories, schéma DB, kanban GitHub, roadmap. Install et config Devise (username, email, password).
- **Mardi 26 mai** : Model User + validation username. ApplicationController (authenticate_user! + configure_permitted_parameters). PagesController (home publique avec skip_before_action). Navbar (user_signed_in?, current_user.username, login/logout/signup). Flashes (_flashes.html.erb). Devise views générées + champ username dans sign up. `db:create` + `db:migrate` OK. Commit + push GitHub.
- **Mercredi 27 mai** : Mise en place de l'environnement de travail Claude. Créé `~/.claude/CLAUDE.md` global (comportement permanent). Créé `CLAUDE.md` projet (stack, models, conventions, démarrage de session). Créé `PLANNING.md` (18 sem, ritual, phases, règles péda). Fix 4 problèmes CI pré-existants (PR #29 mergée : lint rubocop, fixtures users, pages_controller_test, dossier test/system). Upgrade image_processing 1→2 + ajout mini_magick explicite (PR #30 mergée). Setup vault Obsidian `~/Obsidian/DevJobReady/` avec symlink PLANNING.md. Activation protection branche `main` sur GitHub. Migration `NOTES.md` → cette section Suivi (PR en cours).

**Blocages**
- _Rien à signaler pour l'instant._

**Ajustements pour la suite**
- _Rien à signaler pour l'instant._

<!-- Ajouter une section par semaine au fur et à mesure -->
