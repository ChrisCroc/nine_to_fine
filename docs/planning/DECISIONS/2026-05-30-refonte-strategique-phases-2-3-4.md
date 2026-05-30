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
