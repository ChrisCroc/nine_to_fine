# Refonte stratégique Phases 2-3-4 + restructuration documentaire — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructurer la documentation de planning Nine to Fine (PLANNING.md monolithique → architecture découpée `docs/planning/` + FEATURES_FUTURES.md + decision log), refonder les Phases 2-3-4 conformément aux 5 décisions stratégiques actées samedi 30 mai 2026 (Option D + projet React/TS séparé), et mettre à jour CLAUDE.md projet (imports + règle lecture Suivi).

**Architecture:** Stratégie B+ : PLANNING.md racine allégé (~150 lignes) + `docs/planning/` structuré (PHASES par phase, SUIVI courant + ARCHIVE mensuelle, PROGRESSION, JALONS-EMPLOI, DECISIONS). Imports `@` dans CLAUDE.md projet : `PLANNING.md` + `SUIVI-COURANT.md` + `PROGRESSION.md` + `PHASES/phase-{courante}.md`. Le reste lu via Read tool à la demande. Branche de travail dédiée, commits atomiques par lot logique (~6 commits), PR groupée à la fin.

**Tech Stack:** Markdown uniquement. Git pour le versioning. `gh` CLI pour la PR. Pas de tests automatisés (validation = inspection visuelle + vérifications structurelles).

**Spec source:** [`docs/superpowers/specs/2026-05-30-phases-2-3-4-refonte-design.md`](../specs/2026-05-30-phases-2-3-4-refonte-design.md) (PR #48, déjà mergé ou en attente de merge — si en attente, baser cette branche par-dessus).

---

## Pré-requis

- Branche `docs/planning-spec-phases-2-3-4-refonte` (PR #48) mergée OU on travaille à partir de cette branche pour enchaîner.
- Travailler sur **une nouvelle branche** dédiée à l'implémentation : `chore/planning-restructure-phases-2-3-4`.
- Confirmer que `git status` est propre avant de démarrer.

### Étape pré-0 : Setup branche de travail

- [ ] **Vérifier l'état git et la branche de base**

```bash
git status
git branch --show-current
git log --oneline -3
```

Expected : working tree clean, sur `main` ou `docs/planning-spec-phases-2-3-4-refonte`.

- [ ] **Si PR #48 mergée → repartir de main à jour. Sinon → repartir de la branche du spec.**

```bash
# Cas A : PR #48 mergée
git checkout main
git pull
git checkout -b chore/planning-restructure-phases-2-3-4

# Cas B : PR #48 pas encore mergée, on enchaîne dessus
git checkout docs/planning-spec-phases-2-3-4-refonte
git pull
git checkout -b chore/planning-restructure-phases-2-3-4
```

Expected : nouvelle branche créée, working tree clean.

---

## File Structure

### Fichiers à **créer** (11 fichiers + 1 dossier)

| Fichier | Responsabilité | Taille cible |
|---|---|---|
| `FEATURES_FUTURES.md` | Backlog des features sorties du scope v1, structurées | ~80-120 lignes |
| `docs/planning/PROGRESSION.md` | État d'avancement Odin / Tailwind / React / TS / Next | ~60 lignes (extrait tel quel) |
| `docs/planning/JALONS-EMPLOI.md` | Jalons recherche emploi reformulés avec vitrines | ~30 lignes |
| `docs/planning/SUIVI/SUIVI-COURANT.md` | Journal vivant rolling sem en cours + précédente | ~280 lignes initialement (sem 22 complète) |
| `docs/planning/SUIVI/ARCHIVE/.gitkeep` | Préserver le dossier vide dans git | 0 ligne |
| `docs/planning/PHASES/phase-1.md` | Détail Phase 1 sem 22-25 + tableau day-by-day | ~90 lignes |
| `docs/planning/PHASES/phase-2.md` | Refonte Phase 2 sem 26-31 (N to F 1.5j/sem) | ~80 lignes |
| `docs/planning/PHASES/phase-3.md` | Refonte Phase 3 sem 32-35 (N to F continue + sem 35 React/TS) | ~60 lignes |
| `docs/planning/PHASES/phase-4.md` | Refonte Phase 4 sem 36-39 (structure AA + adaptabilité) | ~100 lignes |
| `docs/planning/DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md` | Decision log persistant | ~80 lignes |

### Fichiers à **modifier** (2 fichiers)

| Fichier | Modification |
|---|---|
| `PLANNING.md` | Allégé à ~150 lignes : vision + plan haut niveau + ritual + règles péda + pointeurs vers sous-fichiers. Sections détaillées extraites. |
| `CLAUDE.md` (projet) | Imports `@` ajustés (4 imports au lieu de 1) + ajout règle "Lecture du Suivi au démarrage de session" |

---

## Task 1 : Création de l'arborescence + .gitkeep pour ARCHIVE/

**Files:**
- Create: `docs/planning/SUIVI/ARCHIVE/.gitkeep`
- Create dirs: `docs/planning/`, `docs/planning/PHASES/`, `docs/planning/SUIVI/`, `docs/planning/SUIVI/ARCHIVE/`, `docs/planning/DECISIONS/`

- [ ] **Step 1 : Créer l'arborescence des dossiers**

```bash
mkdir -p docs/planning/PHASES docs/planning/SUIVI/ARCHIVE docs/planning/DECISIONS
ls -la docs/planning/
```

Expected : 4 sous-dossiers visibles (`PHASES/`, `SUIVI/`, `DECISIONS/` + `SUIVI/ARCHIVE/`).

- [ ] **Step 2 : Créer le .gitkeep dans ARCHIVE/**

Le dossier `ARCHIVE/` est vide initialement. Git n'ignore pas les dossiers vides, mais les exclut du tracking. `.gitkeep` est la convention pour les préserver.

Write `docs/planning/SUIVI/ARCHIVE/.gitkeep` :

```
```

(fichier vide)

- [ ] **Step 3 : Vérifier que git voit le .gitkeep**

```bash
git status
```

Expected : `docs/planning/SUIVI/ARCHIVE/.gitkeep` listé en untracked.

---

## Task 2 : Decision log persistant

**Files:**
- Create: `docs/planning/DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md`

- [ ] **Step 1 : Écrire le decision log**

Write `docs/planning/DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md` avec ce contenu :

````markdown
# Decision log — Refonte stratégique Phases 2-3-4

**Date** : 2026-05-30 (samedi matin)
**Statut** : Acté en brainstorming superpowers
**Spec lié** : [`docs/superpowers/specs/2026-05-30-phases-2-3-4-refonte-design.md`](../../superpowers/specs/2026-05-30-phases-2-3-4-refonte-design.md)
**Plan d'implémentation** : [`docs/superpowers/plans/2026-05-30-phases-2-3-4-refonte-implementation.md`](../../superpowers/plans/2026-05-30-phases-2-3-4-refonte-implementation.md)

## Contexte du déclencheur

Vendredi 29 mai 2026 midi, en relisant le PLANNING.md tel que rédigé en sem 22, Chris a identifié 3 risques :

1. **Phase 4 surchargée** : 4 sem pour refondre Nine to Fine en SPA React+TS+Tailwind ⇄ API Rails + ajouter agent IA + déployer = irréaliste à scope inchangé.
2. **Trou de vitrine pendant la recherche emploi** : recherche emploi démarre mi-juin (sem 25). À ce stade, Nine to Fine = un seul CRUD Garment + auth Devise + hero Tailwind. Insuffisant pour appuyer une candidature.
3. **N to F disparaît en Phase 3** (Aug, focus TS) → 4 sem sans toucher au projet vitrine = friction de remise en route, risque d'oubli de contexte.

## Options envisagées vendredi midi

- **Option A** : garder le planning tel quel et tenir le sprint Phase 4. **Écartée** car risque irréaliste.
- **Option B** : démarrer la SPA React/TS dès Phase 2 en parallèle de l'apprentissage. **Écartée** car contredit la logique pédagogique (apprendre React avant de l'appliquer en vitrine).
- **Option C** : repousser la deadline emploi à fin octobre. **Écartée** car objectif fin septembre = engagement personnel + financier.
- **Option D** (actée) : saupoudrer N to F sur Phases 2-3 (1.5 j/sem au lieu de 1) pour viser **v1 polishée + déployée mi-juillet**, et reformuler Phase 4 en **sprint d'enrichissement** plutôt que refonte complète.

## Contrainte additionnelle Chris

Vendredi soir, Chris a ajouté : il veut **un projet React/TS vitrine séparé** d'ici fin Phase 4, en plus de N to F. Pour montrer la maîtrise React+TS de manière standalone et différenciée du backend Rails.

## 5 points tranchés samedi matin (Q1-Q5 du brainstorming)

### Q1 — Scope v1 N to F mi-juillet : **B + tags-light + Kamal**

- Outfit CRUD + composition (`fields_for` / `accepts_nested_attributes_for`) + Likes + Comments + Follows (polymorphic) + profil user public + tags via input texte "comma-separated" + recherche par nom + filtres `link_to` (couleur OU category OU tag, un seul à la fois) + Tailwind polish global.
- Deploy **Kamal sur VPS Hetzner** (~5€/mois), Fly.io en plan B explicite si setup VPS bloque à J-3.
- ~12-13 j de travail étalés sem 22 → sem 29.

**Pourquoi B et pas A (minimum)** : sans interaction (Like/Comment/Follow), c'est un CRUD glorifié. Polymorphic Tagging déjà en DB sans UI = code mort visible dans les commits, mauvais signal.

**Pourquoi B et pas C (full)** : autocomplete tags + combinaison filtres = features-creep typique avec friction d'apprentissage Stimulus non-prioritaire. Tags-light "comma-separated" est l'UX éprouvée (Gmail / GitHub / StackOverflow).

**Pourquoi Kamal et pas Fly.io directement** : signal différenciant CV/entretien (stack officielle Rails 8 + DevOps light), compétences durables (SSH/Docker/secrets/reverse proxy), coût compétitif vs free tier Fly.io qui dort, cohérence stack (déjà dans Gemfile + Dockerfile + CLAUDE.md). Sources vérifiées : Heroku mort en 2026, Kamal 2 gagne en adoption avec Rails 8.

### Q2 — Recalibrage cadence : **N to F 1.5 j/sem prélevé sur après-midi React/TS (Option α)**

Préserve Odin matin + sandbox soir. Impact ~-10% volume React/TS sur Phases 2-3. Possible sacrifice d'un mini-projet React P2 (de 4 à 3) si glissement.

**Pourquoi pas γ (mix matin Odin + soir sandbox)** : casse le ritual matin protégé du planning, mauvais signal sur la discipline.

### Q3 — Projet React/TS vitrine : **Outil prep entretiens techniques (démarrage sem 35)**

Flashcards Rails/React/TS/algo + spaced repetition algorithm (SM-2 simplifié) + mode "entretien blanc chronométré" + IA Anthropic (génération de questions + évaluation réponses).

Stack : Vite + React + TS strict + Tailwind + localStorage/IndexedDB + Anthropic SDK avec proxy minimal. Démarrage sem 35 (dernière sem P3, en parallèle migration TS).

**Pourquoi pas "Tracker de candidatures (CRM emploi)" → skill Claude Code à la place** : Chris a proposé de gérer le suivi candidatures via une routine Claude Code (slash commands custom) plutôt qu'une app web. Excellente intuition : la skill `job-tracker` devient le **3e artefact du portfolio**, démontre la capacité à étendre Claude Code (signal différenciant 2026), pas la charge d'une app web séparée.

**Pourquoi pas "Upgrade d'un mini-projet existant"** : risque d'avoir un projet "transformé" qui montre l'évolution mais peut paraître bricolé. From-scratch propre est meilleur.

### Q4 — Refonte Phase 4

**Q4a Structure** : **AA — spécialisation par jours, avec adaptabilité**.
- Lundi-mardi : N to F sprint enrichissement.
- Mercredi-jeudi : projet React/TS prep entretiens.
- Vendredi : **100% emploi** (10+ candidatures + relances + suivi entretiens).
- Soir : prep entretiens techniques.
- Samedi : rattrapage + entretiens variables.

**Pourquoi pas Y (alternance par demi-journée)** : saupoudrage maximal, risque de ne rien finir.
**Pourquoi pas Z (alternance par semaine entière)** : si une sem déborde elle mange la suivante.

**Q4b Scope N to F P4** : **Minimal au départ** (IA suggester + tests RSpec + polish mobile + README pro + vidéo démo 90s), escalade Standard conditionnelle (cf. règle 3 d'adaptabilité ci-dessous).

Drag-and-drop composition outfit → `FEATURES_FUTURES.md` priorité haute (marqué "essentiel à terme" par Chris). Ambitieux (refacto + autocomplete tags + autres Stimulus avancés) → `FEATURES_FUTURES.md`.

### Q5 — Forme refonte PLANNING.md

**Q5a Forme** : **Option II hybride** (tableaux refondus + section "Stratégie revisitée" → decision log + mini-bullets jour-type par sem, pas table day-by-day complète pour les semaines futures).

**Q5b Jalons emploi** : reformulation détaillée maintenant (réf explicite vitrines actives par jalon).

## Bonus split architecture documentaire (Stratégie B+)

Adopté pour rendre PLANNING.md soutenable à 18 sem (sinon explose vers ~2700 lignes).

- `PLANNING.md` (racine) allégé ~150 lignes : vision + plan haut niveau + ritual + règles péda + pointeurs.
- `docs/planning/` structuré : `PHASES/phase-{n}.md`, `SUIVI/SUIVI-COURANT.md`, `SUIVI/ARCHIVE/{YYYY-MM}.md`, `PROGRESSION.md`, `JALONS-EMPLOI.md`, `DECISIONS/`.
- Imports `@` dans CLAUDE.md projet : `PLANNING.md` + `SUIVI-COURANT.md` + `PROGRESSION.md` + `PHASES/phase-{courante}.md` (4 imports au lieu de 1 actuellement).
- Reste lu à la demande via Read tool.

**Pourquoi pas A (split minimal — Suivi seulement)** : contexte Claude reste lourd à long terme.
**Pourquoi pas C (PLANNING.md = index <50 lignes)** : perd contexte stable (vision/ritual/règles péda) au démarrage.

## Règle de lecture du Suivi adaptée jour/lundi

Ajoutée dans CLAUDE.md projet section "Démarrage de session" :

- **Mardi-vendredi** : focus journée veille + sem en cours. Annonce du programme du jour en référence directe à ce qui a été fait hier.
- **Lundi (ou 1ère session de la sem)** : lecture intégrale de la semaine précédente complète + sem en cours qui démarre. Annonce démarrage de semaine avec récap accomplissements + blocages + ajustements avant le programme du jour.

## Implications opérationnelles

- Phases 2-3-4 refondues dans `docs/planning/PHASES/phase-{2,3,4}.md`.
- `FEATURES_FUTURES.md` créé avec backlog initial structuré.
- Skill Claude Code `job-tracker` à créer samedi sem 25 (livrable ajouté à `phase-1.md`).
- Projet React/TS prep entretiens scaffold démarre sem 35 (livrable ajouté à `phase-3.md`).
- Imports CLAUDE.md ajustés à chaque transition de phase (sem 26, 32, 36 = 3 éditions).

## Conditions de re-évaluation

Le plan acté ici doit être re-discuté si :

- **Fin sem 26 (28 juin)** : N to F n'a pas atteint Outfit CRUD + composition fonctionnels. → signal de retard, possible recalibrage du scope v1 vers A (minimum).
- **Fin sem 28 (12 juillet)** : Tailwind polish + setup Kamal pas commencés. → menace sur jalon mi-juillet, fallback Fly.io activé.
- **Fin sem 31 (2 août)** : N to F v1 pas déployée en prod. → jalon mi-juillet manqué, repli scope ou décalage déploiement à mi-août.
- **Fin sem 34 (23 août)** : aucune réponse positive aux candidatures. → réviser CV, LinkedIn, qualité narratif, possible élargissement plateformes / villes / remote-only.
- **Fin sem 37 (13 sept)** : projet React/TS prep entretiens pas en mesure d'être déployé. → repli sur un MVP plus minimaliste sans IA Anthropic (juste flashcards + spaced repetition).
````

- [ ] **Step 2 : Vérifier le contenu**

```bash
wc -l docs/planning/DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md
head -10 docs/planning/DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md
```

Expected : ~150-200 lignes, titre "# Decision log — Refonte stratégique Phases 2-3-4" visible.

---

## Task 3 : FEATURES_FUTURES.md (racine projet)

**Files:**
- Create: `FEATURES_FUTURES.md`

- [ ] **Step 1 : Écrire le fichier**

Write `FEATURES_FUTURES.md` avec ce contenu :

```markdown
# Features Futures — Nine to Fine

Backlog des features sorties du scope v1 mi-juillet, à réintégrer post-emploi (oct 2026+) ou au gré des opportunités.

Chaque feature documente : **contexte d'origine** (quand/pourquoi sortie), **description** précise, **stack** technique impliquée, **estimation**, **slot suggéré** de réintégration.

## Priorité haute

### Drag-and-drop composition outfit

- **Contexte d'origine** : sortie samedi 30 mai 2026 (refonte stratégique Phase 4, Q4b). Marquée "essentielle à terme" par Chris.
- **Description** : sur la page de composition d'un outfit, permettre de glisser-déposer des garments depuis la liste latérale vers la zone "tenue en cours de composition". Réordonner par drag dans la zone. Sauvegarde implicite à chaque drop.
- **Stack** : Stimulus controller `outfit_composer_controller.js` + bibliothèque `Sortable.js` (importmap) ou alternative native HTML5 drag-and-drop API. Persistance via PATCH AJAX vers `OutfitGarmentsController`.
- **Estimation** : 2-3 j (Stimulus + Sortable.js + UX + tests système Capybara).
- **Slot suggéré** : Phase 4 sem 38-39 si escalade Standard (cf. règle 3), sinon post-emploi (oct 2026+).

## Priorité moyenne

### Autocomplete Stimulus sur input tags

- **Contexte d'origine** : sortie samedi 30 mai 2026 (brainstorming Q1). V1 utilise input texte "comma-separated" (UX éprouvée Gmail/GitHub/StackOverflow). Autocomplete = polish ultérieur.
- **Description** : suggestions de tags existants pendant la saisie, avec filtrage live et création-on-the-fly si tag inconnu.
- **Stack** : Stimulus controller `tags_input_controller.js` + endpoint JSON `tags#autocomplete?q=...` + scope Rails sur tags du user.
- **Estimation** : 1.5-2 j.
- **Slot suggéré** : post-emploi ou Phase 4 si scope ambitieux escaladé.

### Combinaison de filtres (couleur ET tag ET category)

- **Contexte d'origine** : sortie Q1. V1 = 1 filtre à la fois via `link_to`.
- **Description** : combiner plusieurs filtres simultanément (ex : "tous mes tops bleus tagués weekend").
- **Stack** : refactor du scoping côté model (chaînage de scopes) + UI checkboxes ou pills désélectionnables. Pas de gem nécessaire.
- **Estimation** : 1-2 j.
- **Slot suggéré** : post-emploi.

### Ransack ou équivalent (recherche full-text)

- **Contexte d'origine** : sortie Q1. V1 = recherche par nom uniquement via scope simple.
- **Description** : recherche full-text avec gem Ransack ou pg_search sur name + brand + description.
- **Stack** : gem `ransack` ou `pg_search` + UI search bar avancée.
- **Estimation** : 2 j.
- **Slot suggéré** : post-emploi.

### Refactor partiel modèle (à identifier post-v1)

- **Contexte d'origine** : sortie Q4b. Si après v1 un modèle s'avère mal posé (typiquement Outfit ou Tagging), refactoring.
- **Description** : à préciser quand le problème se révèle. Pas de scope défini par défaut.
- **Stack** : variable.
- **Estimation** : variable.
- **Slot suggéré** : post-emploi.

### Audit perf + Solid_cache + Bullet + indexes

- **Contexte d'origine** : sortie Q4b. Scope "Standard" Phase 4 si on a le temps (règle 3 d'adaptabilité).
- **Description** : ajout gem `bullet` (groupe development) pour détection N+1, configuration `Solid_cache` pour cache fragment sur home/index, audit des indexes manquants sur les jointures fréquentes.
- **Stack** : gem `bullet` + Solid_cache (déjà dans Gemfile Rails 8) + `add_index` migrations.
- **Estimation** : 2-3 j cumulés.
- **Slot suggéré** : Phase 4 Standard escalation (fin sem 37 si conditions règle 3 remplies) ou post-emploi.

## Priorité basse

_(à compléter au fil du temps quand de nouvelles idées émergent)_
```

- [ ] **Step 2 : Vérifier**

```bash
wc -l FEATURES_FUTURES.md
grep -c "^###" FEATURES_FUTURES.md
```

Expected : ~80-100 lignes, **6 features** détaillées (`###` count = 6).

---

## Task 4 : docs/planning/PROGRESSION.md (extraction depuis PLANNING.md)

**Files:**
- Create: `docs/planning/PROGRESSION.md`
- Source: `PLANNING.md` lignes 17-71 (section `## Progression apprentissage`)

- [ ] **Step 1 : Lire la section actuelle pour extraction**

```bash
sed -n '17,71p' PLANNING.md
```

Expected : sortie comprenant la section "## Progression apprentissage" jusqu'à la dernière sous-section Next.js (avant `## Ritual quotidien fixe`).

- [ ] **Step 2 : Écrire docs/planning/PROGRESSION.md**

Write `docs/planning/PROGRESSION.md` avec ce contenu (extraction du PLANNING.md actuel, avec le `## Progression apprentissage` titre transformé en `# Progression apprentissage` puisque devient le titre racine du fichier) :

```markdown
# Progression apprentissage

Source de vérité pour savoir **exactement** où Chris en est sur chaque ressource. À mettre à jour quand un chapitre / vidéo / section est terminé. Claude lit ce fichier au démarrage de session pour proposer le prochain sujet précis du matin et de l'avant-midi.

## Odin Project — Full Stack Ruby on Rails

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

## Tailwind CSS

- **Fait** : Installation + Styling with utility classes + Hover, focus and other states + Responsive design + Tailwind v4 overview (blog post lancement + docs CSS-first, voir notes Obsidian)
- **Prochain (à faire dans l'ordre)** :
  1. Docs section **"Layout"** (Flexbox, Grid, Spacing) — appliquer immédiatement sur Nine to Fine
  2. Tailwind Labs YouTube vidéo **"Building responsive layouts"** (samedi 30 mai prévu)
  3. Docs section **"Customization"** (theme tokens, `@theme`, variants custom)

## React (à démarrer Phase 2, sem 26)

- **Fait** : rien
- **Prochain** : Scrimba "Learn React" (CS Career Path) + react.dev "Learn" en parallèle
- **URLs** : https://scrimba.com/learn/learnreact + https://react.dev/learn

## TypeScript (à démarrer Phase 3, sem 32)

- **Fait** : rien
- **Prochain** : Total TypeScript "Beginner's TypeScript" (gratuit, Matt Pocock)
- **URL** : https://www.totaltypescript.com/tutorials/beginners-typescript

## Next.js (Phase 4, sem 36, optionnel)

- **Fait** : rien
- **Prochain** : Learn Next.js officiel (gratuit, ~6h)
- **URL** : https://nextjs.org/learn
```

Notes sur les évolutions vs source actuelle :
- **Tailwind** : la section "Fait" est mise à jour pour refléter ce qui a été fait en sem 22 (Installation + Styling + Hover focus + Responsive + Tailwind v4 overview). Source : Suivi sem 22 actuel.
- **Tailwind Prochain** : remplacement de la liste Tailwind Labs périmée (vu vendredi 29 mai : pas de vidéo v4 sur cette chaîne) par la liste actuelle réelle.

- [ ] **Step 3 : Vérifier**

```bash
wc -l docs/planning/PROGRESSION.md
head -3 docs/planning/PROGRESSION.md
```

Expected : ~60 lignes, titre `# Progression apprentissage`.

---

## Task 5 : docs/planning/JALONS-EMPLOI.md (reformulé)

**Files:**
- Create: `docs/planning/JALONS-EMPLOI.md`

- [ ] **Step 1 : Écrire le fichier**

Write `docs/planning/JALONS-EMPLOI.md` avec ce contenu :

```markdown
# Jalons recherche emploi — Chris Crokaert

Objectif global : décrocher un poste de **développeur junior** (Paris ou full remote) d'ici **fin septembre 2026**.

## Grille des jalons

| Jalon | Cible candidatures/sem | Vitrines présentables |
|---|---|---|
| **Mi-juin (sem 25)** | 3 premières candidatures Rails | N to F en construction : CRUD Garment + Outfit + composition + tags + social en cours. **Skill `job-tracker` activée** (créée samedi sem 25, livrable de la sem). LinkedIn + GitHub propres. |
| **Mi-juillet (sem 29)** | 3-5 candidatures/sem + 1 contact alumni Le Wagon / sem | **N to F v1 polishée + déployée Kamal (Hetzner)** = vitrine 1 active. |
| **Mi-août (sem 33)** | 5-10 candidatures/sem | N to F en maintenance + mini-projets TypeScript bien avancés. Pas de nouveau livrable majeur côté projet, focus consolidation TS + élargissement candidatures. |
| **Mi-sept (sem 37-38)** | 10+ candidatures/sem + entretiens en cours | **Projet React/TS prep entretiens MVP + IA Anthropic** = vitrine 2 active. Portfolio complet = **3 artefacts** (N to F + Outil prep entretiens + skill Claude Code `job-tracker`). |

## Plateformes cibles

- [Welcome to the Jungle](https://www.welcometothejungle.com/fr/jobs)
- [LinkedIn Jobs](https://www.linkedin.com/jobs/)
- [Indeed France](https://fr.indeed.com/)
- [Collective.work](https://collective.work/) (freelance/missions courtes)
- Réseau alumni Le Wagon (camp 2258 + autres camps)

## Suivi des candidatures

À partir de sem 25, suivi via la **skill Claude Code `job-tracker`** (à créer samedi 20-21 juin). Commandes prévues :

- `/candidatures add "Boîte X — Rails dev — Welcome to Jungle — 2026-06-15"` → ajout d'une entry
- `/candidatures list` → kanban des candidatures par statut (envoyé / réponse RH / call tech / décision / rejet)
- `/candidatures relance` → propositions d'emails à relancer (basé sur date + statut)
- `/candidatures stats` → métriques hebdo (volume, taux de réponse, taux de conversion)

Stockage : fichier markdown ou JSON dans `~/.claude/skills/job-tracker/data/` (ou vault Obsidian DevJobReady, à acter au moment de la création).
```

- [ ] **Step 2 : Vérifier**

```bash
wc -l docs/planning/JALONS-EMPLOI.md
grep -c "^|" docs/planning/JALONS-EMPLOI.md
```

Expected : ~30-40 lignes, tableau de jalons présent (au moins 6 lignes avec `|`).

---

## Task 6 : docs/planning/SUIVI/SUIVI-COURANT.md (extraction du Suivi sem 22)

**Files:**
- Create: `docs/planning/SUIVI/SUIVI-COURANT.md`
- Source: `PLANNING.md` lignes 189-465 (section `## Suivi (vivant)` jusqu'à la fin)

- [ ] **Step 1 : Vérifier le contenu source**

```bash
sed -n '189,200p' PLANNING.md
tail -10 PLANNING.md
```

Expected : début = `## Suivi (vivant)`, fin = dernière entrée d'ajustements vendredi 29 mai.

- [ ] **Step 2 : Extraire vers SUIVI-COURANT.md**

```bash
# Extraire les lignes 189 à fin du fichier
sed -n '189,$p' PLANNING.md > docs/planning/SUIVI/SUIVI-COURANT.md
```

- [ ] **Step 3 : Transformer le titre racine**

Le fichier extrait commence par `## Suivi (vivant)`. Comme c'est désormais un fichier racine, transformer en `# Suivi vivant — Sem en cours + précédente`.

Edit `docs/planning/SUIVI/SUIVI-COURANT.md` :

**old_string** :
```
## Suivi (vivant)

Source unique de vérité pour le journal de bord. À mettre à jour à la fin de chaque journée.
```

**new_string** :
```
# Suivi vivant — Sem en cours + précédente

Source unique de vérité pour le journal de bord récent. À mettre à jour à la fin de chaque journée via la routine `/end-of-day` (à créer sem 22).

**Politique de rolling** : ce fichier contient **la semaine en cours + la semaine précédente complète**. Début de mois (au plus tard le premier lundi du mois suivant), archivage de tout le mois précédent vers `ARCHIVE/{YYYY-MM}.md`.

**Règle de lecture au démarrage de session** :
- Mardi-vendredi : focus journée veille + sem en cours.
- Lundi (ou 1ère session de la sem) : lecture intégrale sem précédente + sem en cours qui démarre, avec récap accomplissements + blocages + ajustements de la sem précédente avant le programme du jour.

**Archives** : voir `docs/planning/SUIVI/ARCHIVE/{YYYY-MM}.md`.
```

- [ ] **Step 4 : Vérifier**

```bash
wc -l docs/planning/SUIVI/SUIVI-COURANT.md
head -5 docs/planning/SUIVI/SUIVI-COURANT.md
grep -c "^### Sem" docs/planning/SUIVI/SUIVI-COURANT.md
```

Expected : ~280 lignes (toute la section Suivi sem 22), titre `# Suivi vivant — Sem en cours + précédente`, 1 section Sem visible (`### Sem 22`).

---

## Task 7 : docs/planning/PHASES/phase-1.md (extraction + enrichissement sem 25)

**Files:**
- Create: `docs/planning/PHASES/phase-1.md`
- Source: `PLANNING.md` lignes 91-113 (section `### Phase 1 — Rails pro + Tailwind`)

- [ ] **Step 1 : Écrire phase-1.md**

Write `docs/planning/PHASES/phase-1.md` avec ce contenu (extraction du PLANNING.md actuel + enrichissement sem 25 conformément à la spec) :

```markdown
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
```

- [ ] **Step 2 : Vérifier**

```bash
wc -l docs/planning/PHASES/phase-1.md
grep -c "^### Sem" docs/planning/PHASES/phase-1.md
grep -c "skill" docs/planning/PHASES/phase-1.md
```

Expected : ~90-110 lignes, **4 sections Sem** (Sem 22, 23, 24, 25), au moins 3 mentions "skill" (référence à `job-tracker`).

---

## Task 8 : docs/planning/PHASES/phase-2.md (refonte complète, NOUVEAU)

**Files:**
- Create: `docs/planning/PHASES/phase-2.md`

- [ ] **Step 1 : Écrire phase-2.md**

Write `docs/planning/PHASES/phase-2.md` avec ce contenu :

```markdown
# Phase 2 — React fondamentaux + N to F polish/deploy (sem 26-31, 22 juin → 2 août)

**Focus apprentissage** : React (Scrimba CS Career Path + react.dev officiel).

**Odin Rails** : APIs Rails + Testing RSpec à fond (faiblesse classique des juniors).

**Nine to Fine** : **1.5 j/sem (vs 1 j/sem dans le planning initial)** pour atteindre **v1 polishée + déployée mi-juillet (sem 29)**. Les 0.5 j/sem supplémentaires sont prélevés sur les après-midi React (Option α de la refonte 30 mai 2026, voir [`DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md`](../DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md)). Impact ~-10% volume React, possible sacrifice d'un mini-projet React (de 4 à 3) si glissement.

**Sandbox du soir** : `~/code/sandbox/rails/` continue pour exos Odin Rails (APIs, RSpec). Pas de sandbox React dédié par défaut — les mini-projets de l'après-midi sont la matérialisation ciblée des concepts React appris.

## Tableau récap

| Sem | Dates | Apprentissage React | Mini-projet React | N to F livrables (1.5 j/sem cumulés) |
|---|---|---|---|---|
| 26 | 22-28 juin | JSX, composants, props | Démarrage `react-todo` | **Outfit CRUD** (controller + vues) si pas fini en sem 23 |
| 27 | 29 juin-5 juil | useState, événements, listes | Fin `react-todo` + démarrage `react-flashcards` | **Composition outfit via `fields_for`** + tests RSpec controllers Outfit |
| 28 | 6-12 juil | useEffect, fetch, async | `react-weather` (consomme API publique) | **Tailwind polish global** + setup Dockerfile + premier `kamal setup` |
| 29 | 13-19 juil | Composition, lifting state, custom hooks | Refacto des 3 mini-projets avec hooks custom | **Deploy Kamal en prod sur Hetzner** + DNS + SSL Let's Encrypt. **Jalon mi-juillet atteint** : v1 polishée + déployée. |
| 30 | 20-26 juil | React Router + formulaires contrôlés | `react-notes` (multi-pages, CRUD local) | Polish post-deploy + bug fixes + premier feedback recruteurs |
| 31 | 27 juil-2 août | Contexte, state global léger | Ajout dark mode + auth fake (Context) à `react-notes` | Maintenance + recherche emploi 5/sem |

## Mini-bullets jour-type

Structure de semaine en Phase 2 (lundi-vendredi) :

- **Matin (1h30-2h)** : Odin Rails (lecture profonde — APIs, RSpec, Forms avancés).
- **Avant-midi (2h30-3h)** : Focus React (Scrimba + react.dev).
- **Après-midi (2h30-3h)** : production React (mini-projet). **1 demi-aprem/sem basculée sur Nine to Fine** (typiquement mercredi ou jeudi, à acter en début de sem).
- **Soir (30-45 min)** : sandbox `~/code/sandbox/rails/` (exos Odin Rails).
- **Vendredi PM (1h dès sem 25 déjà)** : recherche emploi (candidatures + relances via skill `job-tracker`).
- **Samedi (4-5h)** : rattrapage + projet + emploi (variable).
- **Dimanche** : OFF.

## Conditions d'alerte

- **Fin sem 26** : si N to F n'a pas atteint Outfit CRUD + composition fonctionnels → signal de retard, possible recalibrage du scope v1 vers A (minimum, voir spec [section "Conditions de re-évaluation"](../../superpowers/specs/2026-05-30-phases-2-3-4-refonte-design.md)).
- **Fin sem 28** : si Tailwind polish + setup Kamal pas commencés → menace sur jalon mi-juillet, fallback Fly.io activé (deploy sur Fly.io plutôt que Hetzner, ~1 j de moins).
- **Fin sem 31** : si N to F v1 pas déployée en prod → jalon mi-juillet manqué, repli scope ou décalage déploiement à mi-août.
```

- [ ] **Step 2 : Vérifier**

```bash
wc -l docs/planning/PHASES/phase-2.md
grep -c "^| " docs/planning/PHASES/phase-2.md
grep -i "kamal" docs/planning/PHASES/phase-2.md
```

Expected : ~80 lignes, tableau présent (~10 lignes avec `|`), au moins 3 mentions Kamal.

---

## Task 9 : docs/planning/PHASES/phase-3.md (refonte, NOUVEAU)

**Files:**
- Create: `docs/planning/PHASES/phase-3.md`

- [ ] **Step 1 : Écrire phase-3.md**

Write `docs/planning/PHASES/phase-3.md` avec ce contenu :

```markdown
# Phase 3 — TypeScript + N to F maintenance + démarrage projet React/TS vitrine (sem 32-35, 3-30 août)

**Focus apprentissage** : TypeScript (Total TypeScript "Beginner's TypeScript" de Matt Pocock).

**Odin Rails** : Performance, caching, background jobs (Sidekiq), mailers.

**Nine to Fine** : **1.5 j/sem maintenu** (maintenance + polish ponctuel post-deploy).

**Nouveau en sem 35** : démarrage du **projet React/TS vitrine séparé — Outil prep entretiens techniques** (Vite + React + TS strict + Tailwind + localStorage + IA Anthropic). Scaffold propre en parallèle de la migration TS des mini-projets de l'après-midi.

**Sandbox du soir** : `~/code/sandbox/rails/` pour Odin Rails matin + création de `~/code/sandbox/typescript/` (sem 32) pour micro-exos TS isolés (generics, narrowing, utility types, discriminated unions) avant application aux migrations des mini-projets React.

## Tableau récap

| Sem | Dates | Apprentissage TS | Mini-projet TS migration | N to F + autres livrables |
|---|---|---|---|---|
| 32 | 3-9 août | Types primitifs, interfaces, types de fonctions | Migration `react-todo` → TS | N to F maintenance (1.5 j/sem) + premières migrations TS des controllers Garment vers `params.expect` strict (cosmétique) |
| 33 | 10-16 août | Generics, narrowing, types utilitaires | Migration `react-weather` → TS (types pour API response) | N to F maintenance + révision Active Record Callbacks (Odin) appliqués sur `before_save normalize_name` (Garment) |
| 34 | 17-23 août | TS avancé : discriminated unions, `satisfies`, mapped types | Migration `react-notes` → TS strict | N to F maintenance + audit Bullet réel + corrections N+1 résiduelles |
| 35 | 24-30 août | TS + React patterns pro (props strictes, hooks typés, contextes typés) | Tous mini-projets en TS strict, README pro pour chacun. **+ Démarrage projet React/TS vitrine "Prep entretiens"** : scaffold Vite + React + TS strict + Tailwind + structure dossiers + premier composant `<Flashcard>` + premier test Vitest. | N to F maintenance + **projet vitrine acté : Nine to Fine v2 = N to F v1 + sprint Phase 4** |

## Mini-bullets jour-type

Structure de semaine en Phase 3 (lundi-vendredi) :

- **Matin (1h30-2h)** : Odin Rails (Performance, Caching, Sidekiq, Mailers).
- **Avant-midi (2h30-3h)** : Focus TypeScript (Total TypeScript).
- **Après-midi (2h30-3h)** : migration TS d'un mini-projet React. **1 demi-aprem/sem basculée sur Nine to Fine** (maintenance / polish / bug fix résiduel).
- **Soir (30-45 min)** : sandbox `~/code/sandbox/typescript/` (micro-exos TS isolés).
- **Vendredi PM (1h)** : recherche emploi (5-10 candidatures/sem). Suivi via skill `job-tracker`.
- **Samedi (4-5h)** : rattrapage + projet + emploi (variable). À partir de sem 35 : ajout du démarrage projet React/TS vitrine.
- **Dimanche** : OFF.

## Conditions d'alerte

- **Fin sem 34** : si aucune réponse positive aux candidatures depuis mi-juin → réviser CV, LinkedIn, qualité narratif, possible élargissement plateformes / villes / remote-only.
- **Fin sem 35** : si le scaffold projet React/TS vitrine pas démarré → décaler à sem 36 en sacrifiant 1 demi-jour de N to F P4 (acceptable).
```

- [ ] **Step 2 : Vérifier**

```bash
wc -l docs/planning/PHASES/phase-3.md
grep -i "vite" docs/planning/PHASES/phase-3.md
grep -i "prep entretien" docs/planning/PHASES/phase-3.md
```

Expected : ~60 lignes, mention Vite, mention "prep entretien" présentes.

---

## Task 10 : docs/planning/PHASES/phase-4.md (refonte AA, NOUVEAU)

**Files:**
- Create: `docs/planning/PHASES/phase-4.md`

- [ ] **Step 1 : Écrire phase-4.md**

Write `docs/planning/PHASES/phase-4.md` avec ce contenu :

```markdown
# Phase 4 — Sprint enrichissement N to F + projet React/TS prep entretiens + emploi intensif (sem 36-39, 31 août → 27 sept)

**Focus apprentissage** : Next.js (Learn Next.js officiel) si dans les temps. Sinon, vanilla React + TS + Vite.

**Odin Rails** : Advanced topics + révision en mode entretien (questions techniques classiques).

**Nine to Fine** : **sprint enrichissement Minimal** (IA suggester + tests + polish + démo). Escalade Standard conditionnelle.

**Projet React/TS prep entretiens** : continuation depuis sem 35. MVP fonctionnel → IA Anthropic → polish → deploy Vercel.

**Sandbox du soir** : **usage réduit**. Le slot bascule progressivement en **préparation entretiens techniques** (questions Rails/React/TS, algorithmes basiques, system design junior) au fur et à mesure que les candidatures s'intensifient. `~/code/sandbox/nextjs/` créé uniquement si besoin de micro-exos isolés.

## Structure de semaine type — AA (spécialisation par jours)

| Jour | Slot | Activité |
|---|---|---|
| **Lundi-mardi** | Toute la journée | **Nine to Fine sprint enrichissement** (IA suggester + tests + polish) |
| **Mercredi-jeudi** | Toute la journée | **Projet React/TS prep entretiens** (MVP → IA → polish → deploy) |
| **Vendredi** | Toute la journée | **100% emploi** : 10+ candidatures + relances via skill `job-tracker` + suivi entretiens en cours |
| **Soir (tous jours)** | 1-2h | **Prep entretiens techniques** : questions Rails/React/TS classiques + révision projets vitrine + system design |
| **Samedi** | 4-5h | Rattrapage + entretiens passés/à passer (variable selon réponses) |
| **Dimanche** | — | OFF (sauf urgence entretien lundi à préparer) |

## Tableau récap par semaine

| Sem | Dates | N to F (lun-mar) | Projet React/TS (mer-jeu) | Emploi (ven + ad hoc) |
|---|---|---|---|---|
| 36 | 31 août-6 sept | Setup feature IA suggester (`app/services/ai/outfit_suggester.rb`) + premier service Anthropic + streaming response | MVP flashcards + spaced repetition (SM-2) + persistence localStorage | 10+ candidatures + suivi entretiens |
| 37 | 7-13 sept | Feature IA finie (UI + persistence des suggestions + edge cases) + tests RSpec services IA | Intégration IA Anthropic (génération questions + évaluation réponses) + proxy minimal | 10+ candidatures + entretiens |
| 38 | 14-20 sept | Polish global (mobile, accessibility, README pro, vidéo démo 90s) + bug fixes. **Si Standard escaladé (cf. règle 3)** : audit Bullet + indexes manquants + premier niveau Solid_cache. | Polish UI Tailwind + déploiement **Vercel** + README pro projet vitrine | 10+ candidatures + entretiens |
| 39 | 21-27 sept | Finitions + cohérence portfolio (README cross-linking) + repos GitHub propres | Finitions projet vitrine + cohérence portfolio | **Emploi à 100%** : finitions candidatures + entretiens prévus |

## Scope N to F P4 (référence)

### Minimal (par défaut, ~6 j budget)

- Feature **"suggère-moi une tenue"** via API Anthropic :
  - Service `app/services/ai/outfit_suggester.rb` (input : météo / occasion / mood. output : sélection de garments cohérents + justification IA).
  - Streaming response côté controller + UI Hotwire (Turbo Stream pour stream tokens-by-tokens).
  - Persistence des suggestions (model `OutfitSuggestion` ? ou simplement `Outfit` créé à partir de la suggestion).
- Tests RSpec sur le service (mock SDK Anthropic) + tests controller.
- Polish mobile responsive (audit visuel + corrections).
- README pro (objectif, stack, architecture, démo, deploy).
- Vidéo démo 90s (Loom ou similaire).

### Standard escaladable (si règle 3 d'adaptabilité remplie, ~3 j budget supplémentaire)

- Audit Bullet (gem déjà installée idéalement en sem 23) + corrections N+1.
- Indexes manquants sur les jointures fréquentes.
- Premier niveau Solid_cache (cache fragment sur home + index garments).

### Ambitieux (toujours hors scope P4 → FEATURES_FUTURES.md)

- Drag-and-drop composition outfit (priorité haute dans backlog).
- Autocomplete Stimulus sur input tags.
- Refacto partiel modèle (à identifier post-v1).
- Autres Stimulus controllers avancés.

## Règles d'adaptabilité P4

### Checkpoint hebdomadaire dimanche soir (10 min)

Revue de la sem qui passe + alignement sur la sem qui vient. Marqueurs à évaluer :

- Combien de candidatures envoyées cette semaine ? Combien de réponses ?
- Combien d'entretiens passés / à venir ?
- N to F : où en est-on sur le scope Minimal de la sem ?
- Projet React/TS : où en est-on sur la roadmap MVP → IA → polish → deploy ?
- Sandbox prep entretiens : couvre-t-on les sujets vus en entretien récent ?

### Règle 1 — Si pas d'entretien la sem X

Temps libéré redistribué sur le projet en retard. Typiquement : si pas d'entretien et N to F en avance → bascule sur projet React/TS pour rattraper.

### Règle 2 — Si entretien tombe milieu de sem

On coupe sur **un seul** projet (le moins urgent au regard du jalon emploi). Pas les deux. Préserver au moins un des deux projets en avancement régulier.

### Règle 3 — Escalade scope N to F Minimal → Standard

Validable **fin sem 37 seulement**, et uniquement si :

- (a) IA suggester + tests RSpec + polish v1 Minimal sont **terminés** à fin sem 37.
- (b) Il reste **≥ 4 j cumulés** sur les lundis-mardis sem 38-39 (soit tout le buffer N to F P4 restant).

Standard escalation light = audit Bullet + indexes manquants + premier niveau Solid_cache. Scope ambitieux reste **hors P4** dans tous les cas.

## Conditions d'alerte

- **Fin sem 37** : si projet React/TS prep entretiens pas en mesure d'être déployé sur Vercel → repli sur un MVP plus minimaliste sans IA Anthropic (juste flashcards + spaced repetition + localStorage). README explique l'arbitrage.
- **Fin sem 39** : si pas d'offre signée → poursuivre candidatures + continuer à enrichir N to F + projet React/TS post-objectif officiel (oct 2026+).
```

- [ ] **Step 2 : Vérifier**

```bash
wc -l docs/planning/PHASES/phase-4.md
grep -c "Règle" docs/planning/PHASES/phase-4.md
grep -i "minimal" docs/planning/PHASES/phase-4.md
grep -i "kamal" docs/planning/PHASES/phase-4.md
```

Expected : ~100-120 lignes, 3 règles d'adaptabilité, scope Minimal documenté, pas de mention Kamal (deploy = déjà fait sem 29).

---

## Task 11 : Commit du lot 1 (setup + decision log + features + extractions + phases)

- [ ] **Step 1 : Status check**

```bash
git status
```

Expected : 11 nouveaux fichiers untracked (decision log + features_futures + 4 PHASES + JALONS + PROGRESSION + SUIVI-COURANT + .gitkeep ARCHIVE).

- [ ] **Step 2 : Stage et commit**

```bash
git add docs/planning/ FEATURES_FUTURES.md
git status
git commit -m "$(cat <<'EOF'
docs(planning): scaffold new docs/planning/ architecture + FEATURES_FUTURES backlog

- Create docs/planning/ structure : PHASES/, SUIVI/ARCHIVE/, DECISIONS/.
- Add decision log persisting the 2026-05-30 strategic refonte rationale.
- Add FEATURES_FUTURES.md backlog (drag-and-drop, autocomplete, Ransack, etc.).
- Extract PROGRESSION + JALONS-EMPLOI from PLANNING.md into dedicated files.
- Extract Sem 22 Suivi into SUIVI/SUIVI-COURANT.md (rolling source).
- Create phase-1.md (sem 22-25 enriched), phase-2.md (refonte 1.5 j/sem), phase-3.md (refonte + sem 35 React/TS scaffold), phase-4.md (refonte AA + adaptability rules).

PLANNING.md and CLAUDE.md still untouched at this commit — done in next commits.

Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
EOF
)"
```

Expected : commit créé, `git status` clean.

- [ ] **Step 3 : Vérifier l'arborescence**

```bash
find docs/planning -type f | sort
ls -la FEATURES_FUTURES.md
```

Expected : liste de 9 fichiers + .gitkeep, FEATURES_FUTURES.md à la racine.

---

## Task 12 : Refonte de PLANNING.md (allégé)

**Files:**
- Modify: `PLANNING.md` (réécriture complète, ~150 lignes cible)

- [ ] **Step 1 : Sauvegarder la version actuelle pour référence**

```bash
cp PLANNING.md /tmp/PLANNING-pre-refonte-30mai.md
wc -l /tmp/PLANNING-pre-refonte-30mai.md
```

Expected : ~465 lignes sauvegardées.

- [ ] **Step 2 : Réécrire PLANNING.md (allégé)**

Write `PLANNING.md` (overwrite complet) avec ce contenu :

```markdown
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

## Portfolio final — 3 artefacts (acté 30 mai 2026)

À présenter à recruteurs / dans entretiens d'ici fin sept 2026 :

1. **Nine to Fine** (Rails 8 full-stack) — app de gestion garde-robe + composition tenues + social + IA suggester. Déployée Kamal sur Hetzner. **Vitrine 1, active mi-juillet**.
2. **Outil prep entretiens techniques** (React + TS + Tailwind + IA Anthropic) — flashcards + spaced repetition SM-2 + entretien blanc chronométré + génération/évaluation questions via IA. Déployée Vercel. **Vitrine 2, active mi-sept**.
3. **Skill Claude Code `job-tracker`** (extension d'outil IA + scripting markdown) — slash commands custom pour suivi candidatures. Code sur GitHub. **Activée mi-juin (sem 25)**, signal différenciant 2026.

## Plan par phase — vue haut niveau

| Phase | Dates | Focus | Détail |
|---|---|---|---|
| **Phase 1** | 25 mai → 21 juin (sem 22-25) | Rails pro + Tailwind | [`docs/planning/PHASES/phase-1.md`](docs/planning/PHASES/phase-1.md) |
| **Phase 2** | 22 juin → 2 août (sem 26-31) | React fondamentaux + N to F polish/deploy | [`docs/planning/PHASES/phase-2.md`](docs/planning/PHASES/phase-2.md) |
| **Phase 3** | 3 août → 30 août (sem 32-35) | TypeScript + N to F maintenance + démarrage projet React/TS vitrine | [`docs/planning/PHASES/phase-3.md`](docs/planning/PHASES/phase-3.md) |
| **Phase 4** | 31 août → 27 sept (sem 36-39) | Sprint enrichissement N to F + projet React/TS prep entretiens + emploi intensif (structure AA) | [`docs/planning/PHASES/phase-4.md`](docs/planning/PHASES/phase-4.md) |

## Ritual quotidien fixe

Volume cible : **40-55h/semaine** (8-11h par jour sur 5 jours + 4-5h le samedi). Dimanche off obligatoire (anti-burnout).

| Slot | Durée | Activité | Rôle pédagogique |
|---|---|---|---|
| **Matin** | 1h30-2h | **Odin Project — Rails** (sujet du jour défini selon la phase) | 📖 **Lecture profonde de consolidation** post-bootcamp — pas de code à produire en parallèle |
| **Avant-midi** | 2h30-3h | **Focus apprentissage** de la phase courante (Tailwind / React / TS / Next selon période) | 📖 **Lecture profonde** de la doc officielle — même logique que le matin |
| **Après-midi** | 2h30-3h | **Production projet** (Nine to Fine en P1 / mini-projets en P2-3 / vitrine en P4) | 🛠️ **Application directe** des concepts du matin et du midi dans du code de prod |
| **Soir** | 30-45 min | **Exercice dirigé avec Claude** dans la sandbox (`~/code/sandbox/<techno>/`) | 🎯 **Consolidation ciblée** : 1 exo min. par concept du jour (règle péda 8) |
| **Vendredi PM** | 1h (dès sem 25) | **Recherche emploi** : candidatures, mise à jour LinkedIn/GitHub, contacts alumni | — |
| **Samedi** | 4-5h | **Rattrapage / projet / recherche emploi** | Lectures Odin courtes (Asset Pipeline, Importmaps, Turbo Drive) si décalage en semaine |
| **Dimanche** | OFF | Repos obligatoire (ou lecture légère exceptionnelle si rattrapage urgent) | — |

**Note Phase 4** : structure spéciale **AA — spécialisation par jours** (lun-mar N to F, mer-jeu React/TS, ven 100% emploi, soir prep entretien). Voir [`PHASES/phase-4.md`](docs/planning/PHASES/phase-4.md).

## Règles pédagogiques (Claude → Chris)

Ces règles s'appliquent uniquement au cadre apprentissage. Les règles de comportement général (challenge, vérification doc, concision, etc.) sont définies dans le `CLAUDE.md` global.

1. **Jamais la solution directement** — toujours le "pourquoi" d'abord.
2. **Questions de vérification** avant de passer à la suite ("explique-moi pourquoi tu utilises `useEffect` ici plutôt que `useMemo`").
3. **Continuité du cursus** : chaque exercice du soir s'appuie sur les précédents de la semaine.
4. **2 alternatives** quand pertinent, avec trade-offs.
5. **Adapter le niveau** : Rails = challenger fort (niveau pro). React / TS / Tailwind / Next = vulgariser plus (apprentissage en cours).
6. **Signaler les erreurs fréquentes** liées au code que Chris vient d'écrire.
7. **Lecture / vidéo quotidienne** suggérée. Source officielle, vérifiée 2 fois, datée.
8. **Slot du soir = consolidation par concept** : au minimum 1 exo dirigé par concept vu dans la journée, adapté au contenu réellement étudié et codé.
9. **Projets Odin remplacés par Nine to Fine + sandbox** : les "Project: X" du parcours Odin ne sont **pas** faits tels quels. Leur valeur pédagogique est récupérée via : (a) Nine to Fine l'après-midi, (b) sous-portions isolées en exos sandbox le soir, (c) Knowledge Check **répondus par écrit**.
10. **Sandbox par techno** : `~/code/sandbox/` contient un sous-dossier par technologie (`rails/`, `tailwind/` créés en sem 22 ; `react/`, `typescript/`, `nextjs/` créés aux phases ultérieures si nécessaire). Organisation interne **par concept**, date dans les noms de fichiers.

## Pointeurs vers documentation détaillée

- **Progression apprentissage** (Odin / Tailwind / React / TS / Next — état d'avancement) : [`docs/planning/PROGRESSION.md`](docs/planning/PROGRESSION.md)
- **Détail Phase N** : `docs/planning/PHASES/phase-{1,2,3,4}.md`
- **Suivi vivant** (journal sem en cours + précédente) : [`docs/planning/SUIVI/SUIVI-COURANT.md`](docs/planning/SUIVI/SUIVI-COURANT.md)
- **Archives Suivi** (mensuel) : `docs/planning/SUIVI/ARCHIVE/{YYYY-MM}.md`
- **Jalons recherche emploi** : [`docs/planning/JALONS-EMPLOI.md`](docs/planning/JALONS-EMPLOI.md)
- **Decisions stratégiques** (logs persistants) : `docs/planning/DECISIONS/`
- **Features futures** (backlog v1+) : [`FEATURES_FUTURES.md`](FEATURES_FUTURES.md)

## Sandbox d'exercices

Dossier parent `~/code/sandbox/` contenant un sous-dossier par technologie, chacun étant un repo Git autonome :

- `~/code/sandbox/rails/` — repo [ChrisCroc/sandbox-rails](https://github.com/ChrisCroc/sandbox-rails). App Rails 8 dédiée aux exos de consolidation.
- `~/code/sandbox/tailwind/` — fichiers HTML standalone avec Tailwind via CDN.
- `react/`, `typescript/`, `nextjs/` : à créer aux phases ultérieures si besoin.

**Usage** : slot du soir (30-45 min) dans le ritual quotidien. Exos basés sur Knowledge Check Odin + sous-portions des "Project: X" Odin + cas limites du code de l'aprem dans Nine to Fine. Voir règles pédagogiques 8, 9, 10.

**Convention de commit pour le sandbox Rails** : `exo(<concept>): <short desc>` (ex: `exo(callbacks): add before_save normalize_name on Garment`).

Mémoire détaillée : `~/.claude/projects/-Users-chriscroc-code-nine-to-fine/memory/sandbox-setup.md`.
```

- [ ] **Step 3 : Vérifier**

```bash
wc -l PLANNING.md
grep -c "^## " PLANNING.md
grep -c "docs/planning/" PLANNING.md
```

Expected : ~120-160 lignes, 8 sections H2, au moins 8 références à `docs/planning/`.

- [ ] **Step 4 : Commit**

```bash
git add PLANNING.md
git status
git commit -m "$(cat <<'EOF'
docs(planning): slim down PLANNING.md to ~150 lines + pointers to docs/planning/

- Replace monolithic 465-line PLANNING.md with a high-level orchestration file.
- Sections kept inline : Objectif, Portfolio (NEW), Plan par phase (high-level table only), Ritual quotidien, Règles pédagogiques, Sandbox d'exercices.
- Sections moved to docs/planning/ : Progression apprentissage, per-phase details, Suivi vivant, Jalons emploi.
- Add explicit pointers section to navigate sub-files.
- Add Portfolio final (3 artefacts) section reflecting the 2026-05-30 strategic refonte.

Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
EOF
)"
```

Expected : commit créé, `git status` clean.

---

## Task 13 : Mise à jour de CLAUDE.md projet (imports + règle Suivi)

**Files:**
- Modify: `CLAUDE.md` (projet, racine)

- [ ] **Step 1 : Lire la section actuelle "Démarrage de session" pour identifier le point d'insertion**

```bash
grep -n "Démarrage de session" CLAUDE.md
grep -n "^@" CLAUDE.md
tail -10 CLAUDE.md
```

Expected : repérage de la section + de la ligne `@PLANNING.md` actuelle (probablement vers la fin).

- [ ] **Step 2 : Remplacer la ligne unique `@PLANNING.md` par 4 imports**

Edit `CLAUDE.md` :

**old_string** :
```
@PLANNING.md
```

**new_string** :
```
@PLANNING.md
@docs/planning/SUIVI/SUIVI-COURANT.md
@docs/planning/PROGRESSION.md
@docs/planning/PHASES/phase-1.md
```

Note : `phase-1.md` est l'import de la **phase courante**. À mettre à jour à chaque transition de phase :
- Sem 26 (22 juin) : remplacer par `@docs/planning/PHASES/phase-2.md`
- Sem 32 (3 août) : remplacer par `@docs/planning/PHASES/phase-3.md`
- Sem 36 (31 août) : remplacer par `@docs/planning/PHASES/phase-4.md`

- [ ] **Step 3 : Ajouter la règle "Lecture du Suivi au démarrage de session"**

Le bloc "## Démarrage de session" actuel du CLAUDE.md projet comprend une liste numérotée 1-6. Ajouter après l'item 6 (avant la ligne "Si la date du jour ne correspond à aucune journée détaillée...") un nouveau point 7 :

Edit `CLAUDE.md` :

**old_string** :
```
6. **Si c'est lundi** (ou première session de la semaine) : proposer à Chris de fetcher les issues GitHub de la semaine via `gh issue list` et de mettre à jour la section Suivi avec les US visées cette semaine. Le kanban GitHub Projects n'étant pas lu automatiquement, c'est le moyen de garder le PLANNING.md aligné avec le backlog.

Si la date du jour ne correspond à aucune journée détaillée, demande à Chris ce qu'il veut prioriser.
```

**new_string** :
```
6. **Si c'est lundi** (ou première session de la semaine) : proposer à Chris de fetcher les issues GitHub de la semaine via `gh issue list` et de mettre à jour la section Suivi avec les US visées cette semaine. Le kanban GitHub Projects n'étant pas lu automatiquement, c'est le moyen de garder le PLANNING.md aligné avec le backlog.
7. **Lecture adaptée du Suivi** :
   - **Mardi à vendredi** : focus sur la journée de la veille + la semaine en cours. Annonce du programme du jour en référence directe à ce qui a été fait hier (continuité fine).
   - **Lundi (ou première session de la semaine)** : lecture intégrale de la **semaine précédente complète** + de la semaine en cours qui démarre. Annonce du démarrage de semaine avec récap des accomplissements + blocages + ajustements de la sem précédente **avant** le programme du jour. Couplé avec la routine `gh issue list` du lundi (point 6).

Si la date du jour ne correspond à aucune journée détaillée, demande à Chris ce qu'il veut prioriser.
```

- [ ] **Step 4 : Vérifier**

```bash
wc -l CLAUDE.md
grep -c "^@" CLAUDE.md
grep -A 2 "Lecture adaptée" CLAUDE.md
```

Expected : ~135 lignes (vs 125 actuel + ajouts), 4 imports `@`, section "Lecture adaptée" visible.

- [ ] **Step 5 : Commit**

```bash
git add CLAUDE.md
git status
git commit -m "$(cat <<'EOF'
docs(claude): adjust project CLAUDE.md imports + add Suivi reading rule

- Expand imports from single @PLANNING.md to 4 imports : PLANNING + SUIVI-COURANT + PROGRESSION + PHASES/phase-1 (current phase).
- Add rule 7 in Démarrage de session : adapted Suivi reading depending on the day.
  - Tue-Fri : focus on yesterday + current week.
  - Monday : full previous week recap + current week start.
- Phase-{n}.md import to be updated at each phase transition (sem 26, 32, 36 — manual edits at boundaries).

Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
EOF
)"
```

Expected : commit créé, `git status` clean.

---

## Task 14 : Vérifications post-implémentation

- [ ] **Step 1 : Checklist structurelle**

```bash
# 1. PLANNING.md < 200 lignes effectives
wc -l PLANNING.md

# 2. SUIVI-COURANT.md contient bien la sem 22
grep "^### Sem 22" docs/planning/SUIVI/SUIVI-COURANT.md

# 3. ARCHIVE/ existe mais vide (sauf .gitkeep)
ls -la docs/planning/SUIVI/ARCHIVE/

# 4. Tous les imports @ pointent vers des fichiers existants
for f in $(grep "^@" CLAUDE.md | sed 's/^@//'); do
  test -f "$f" && echo "OK : $f" || echo "MISSING : $f"
done

# 5. FEATURES_FUTURES contient bien drag-and-drop + autres
grep -c "^### " FEATURES_FUTURES.md

# 6. Decision log existe et contient les 7+ sections
grep -c "^## " docs/planning/DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md

# 7. JALONS-EMPLOI a bien la colonne Vitrines présentables
grep -i "vitrine" docs/planning/JALONS-EMPLOI.md

# 8. Phase-4 contient bien les 3 règles d'adaptabilité
grep "^### Règle" docs/planning/PHASES/phase-4.md
```

Expected outputs :
- PLANNING.md : ~120-160 lignes
- `### Sem 22 (25-31 mai 2026)` trouvé dans SUIVI-COURANT.md
- ARCHIVE/ ne contient que `.gitkeep`
- 4 imports `OK` (aucun MISSING)
- FEATURES_FUTURES.md : 6 items `###`
- Decision log : 7+ sections `## `
- JALONS-EMPLOI : au moins 1 mention "vitrine"
- phase-4.md : 3 règles d'adaptabilité

- [ ] **Step 2 : Test manuel de démarrage de session**

```bash
# Simuler un démarrage de session : que voit Claude ?
echo "Imports chargés au démarrage :"
for f in $(grep "^@" CLAUDE.md | sed 's/^@//'); do
  echo "  - $f ($(wc -l < $f) lignes)"
done
echo "Total approximatif lignes chargées :"
grep "^@" CLAUDE.md | sed 's/^@//' | xargs wc -l | tail -1
```

Expected : 4 fichiers listés, total ~400-550 lignes (vs ~520+ lignes actuelles dans PLANNING.md seul).

- [ ] **Step 3 : Vérifier l'historique des commits**

```bash
git log --oneline main..HEAD
```

Expected : 3 commits :
1. `docs(planning): scaffold new docs/planning/ architecture + FEATURES_FUTURES backlog`
2. `docs(planning): slim down PLANNING.md to ~150 lines + pointers to docs/planning/`
3. `docs(claude): adjust project CLAUDE.md imports + add Suivi reading rule`

---

## Task 15 : Push + PR

- [ ] **Step 1 : Push de la branche**

```bash
git push -u origin chore/planning-restructure-phases-2-3-4
```

Expected : nouvelle branche poussée vers `origin`, message du remote suggérant la création de PR.

- [ ] **Step 2 : Créer la PR**

```bash
gh pr create --title "chore(planning): restructure docs into docs/planning/ + refonte phases 2-3-4" --body "$(cat <<'EOF'
## Summary

- Implémente le spec [PR #48 — docs/planning-spec-phases-2-3-4-refonte](https://github.com/ChrisCroc/nine_to_fine/pull/48).
- Restructure la documentation de planning : `PLANNING.md` allégé (~150 lignes) + `docs/planning/` structuré (PHASES par phase, SUIVI courant + ARCHIVE mensuelle, PROGRESSION, JALONS, DECISIONS).
- Refonde Phases 2-3-4 conformément aux 5 décisions actées samedi 30 mai 2026.
- Crée `FEATURES_FUTURES.md` (backlog v1+).
- Ajuste imports CLAUDE.md projet (4 imports au lieu de 1) + ajoute règle de lecture Suivi adaptée jour/lundi.

## Décisions implémentées

| # | Décision |
|---|---|
| Q1 | Scope v1 mi-juillet = B + tags-light + deploy Kamal (Fly.io fallback) → `docs/planning/PHASES/phase-1.md` (sem 23-25) + `phase-2.md` (sem 28-29 deploy) |
| Q2 | N to F 1.5 j/sem en P2-3, 0.5 j sur après-midi React/TS → `phase-2.md` + `phase-3.md` |
| Q3 | Projet React/TS = Outil prep entretiens (démarrage sem 35) + skill `job-tracker` sem 25 → `phase-1.md` sem 25 + `phase-3.md` sem 35 + `phase-4.md` |
| Q4 | Structure AA Phase 4 + scope Minimal escalade Standard → `phase-4.md` |
| Q5 | Forme refonte Option II + jalons emploi détaillés → `JALONS-EMPLOI.md` + decision log |
| Split | Stratégie B+ : 4 imports @ + reste lu à la demande → `CLAUDE.md` ajusté |
| Règle lecture | Mardi-vendredi vs lundi → `CLAUDE.md` point 7 ajouté |

## Commits

1. `docs(planning): scaffold new docs/planning/ architecture + FEATURES_FUTURES backlog`
2. `docs(planning): slim down PLANNING.md to ~150 lines + pointers to docs/planning/`
3. `docs(claude): adjust project CLAUDE.md imports + add Suivi reading rule`

## Test plan

- [ ] Démarrer une nouvelle session Claude Code sur ce projet et vérifier que le programme du jour est annoncé correctement (Phase 1, sem 22, samedi 30 mai).
- [ ] Vérifier visuellement que `docs/planning/PHASES/phase-1.md` est bien chargé en contexte (réf à la sem 22 dans la réponse).
- [ ] Vérifier que le Suivi vivant est lu (réf à la décision stratégique du jour).
- [ ] Lundi prochain (1er juin) : vérifier que la règle "lecture sem précédente complète" se déclenche.
- [ ] Lancer `git log --oneline main..HEAD` et vérifier les 3 commits.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

Expected : PR URL retournée, à transmettre à Chris.

- [ ] **Step 3 : Reporter l'URL de la PR à Chris**

Afficher l'URL de la PR créée à Chris pour qu'il puisse review / merge.

---

## Self-review du plan (à exécuter avant de démarrer l'implémentation)

**1. Spec coverage** — chaque section du spec doit pointer vers une task :

| Section spec | Task |
|---|---|
| Q1 Scope v1 | T7 (phase-1 sem 23-25), T8 (phase-2 sem 28-29 deploy) |
| Q2 Recalibrage | T8 (phase-2 cadence 1.5 j/sem), T9 (phase-3 idem) |
| Q3 Projet React/TS | T7 (phase-1 sem 25 skill), T9 (phase-3 sem 35), T10 (phase-4) |
| Q3 bis Skill job-tracker | T5 (JALONS-EMPLOI section suivi), T7 (phase-1 sem 25) |
| Q4a Structure AA | T10 (phase-4 structure type) |
| Q4b Scope N to F P4 | T10 (phase-4 Minimal/Standard/Ambitieux) |
| Q5a Forme refonte | T7-10 (tableaux + mini-bullets) |
| Q5b Jalons emploi | T5 (JALONS-EMPLOI.md) |
| Bonus Split B+ | T1 (arbo) + T4 (PROGRESSION) + T6 (SUIVI) + T7-10 (PHASES) + T11 (PLANNING allégé) + T13 (CLAUDE imports) |
| Bonus Règle lecture Suivi | T13 (CLAUDE règle 7) |
| Decision log persistant | T2 (création decision log) |
| FEATURES_FUTURES.md | T3 (création + 6 items initiaux) |
| Imports @ ajustés | T13 (CLAUDE.md) |
| Vérifications post-implémentation | T14 (checklist) |

**Coverage : 100%**, pas de gap identifié.

**2. Placeholder scan** :
- "TBD" : utilisé une fois dans le refactor partiel modèle (T3 features futures), c'est intentionnel (la feature elle-même est par définition "à identifier" — pas un placeholder de plan).
- "TODO" : aucun.
- "à compléter au fil du temps" : utilisé une fois dans FEATURES_FUTURES priorité basse, intentionnel.
- "Similar to Task N" : aucun.

**Result** : aucun vrai placeholder. OK.

**3. Type consistency** : pas de types/méthodes/property names à vérifier (documentation Markdown uniquement).

**4. Cohérence fichiers** :
- Decision log placé dans `docs/planning/DECISIONS/` (T2) ✓
- Spec dans `docs/superpowers/specs/` ✓ (différent, créé en amont)
- Plan dans `docs/superpowers/plans/` ✓ (ce fichier)
- Imports CLAUDE.md cohérents avec arbo créée ✓
- PROGRESSION.md mentionne `~/code/sandbox/` mais pas plus de détails — OK, le détail vit dans `~/.claude/projects/.../sandbox-setup.md` mémoire utilisateur

**Résultat self-review** : plan complet, cohérent, prêt à exécution.

---

## Execution Handoff

Plan complet et sauvegardé dans `docs/superpowers/plans/2026-05-30-phases-2-3-4-refonte-implementation.md`.

**Deux options d'exécution :**

1. **Subagent-Driven (recommandé par le skill)** — un subagent frais par tâche, review entre les tâches, itération rapide. Convient bien aux tâches isolables comme celles-ci (création de fichiers indépendants).

2. **Inline Execution** — exécution des tâches dans cette session via `executing-plans`, en mode batch avec checkpoints pour review.

Note mode coach : ces tâches touchent des **fichiers méta** (PLANNING.md, CLAUDE.md projet, docs/) — éditables par Claude après confirmation (CLAUDE.md projet le dit explicitement). Chris a déjà autorisé "commits et PR" pour le travail précédent ; à reconfirmer pour cette phase d'implémentation.

**Quelle approche ?**
