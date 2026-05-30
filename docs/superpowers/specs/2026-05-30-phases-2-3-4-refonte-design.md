# Spec — Refonte stratégique Phases 2-3-4 + restructuration documentation planning

**Date** : 2026-05-30
**Auteur** : Chris Crokaert (avec assistance Claude — brainstorming superpowers)
**Statut** : Validé en brainstorming samedi 30 mai 2026 matin, à produire (plan d'implémentation à suivre)

## Contexte

Vendredi 29 mai 2026 midi, Chris a identifié 3 risques sur le PLANNING.md tel que rédigé en sem 22 :

1. **Phase 4 surchargée** : 4 sem pour refondre Nine to Fine en SPA React+TS+Tailwind ⇄ API Rails + ajouter agent IA + déployer = sprint irréaliste à scope inchangé.
2. **Trou de vitrine pendant la recherche emploi** : recherche emploi démarre mi-juin (sem 25). À ce stade, Nine to Fine = un seul CRUD Garment + auth Devise + hero Tailwind. Insuffisant pour appuyer une candidature.
3. **N to F disparaît en Phase 3** (Aug, focus TS) → 4 sem sans toucher au projet vitrine = friction de remise en route, risque d'oubli de contexte.

**Décision actée vendredi midi (Option D)** : saupoudrer N to F sur Phases 2-3 (1.5 j/sem au lieu de 1) pour viser **v1 polishée + déployée mi-juillet**, et reformuler Phase 4 en **sprint d'enrichissement** plutôt que refonte complète.

**Contrainte additionnelle Chris** : produire **un projet React/TS vitrine séparé** d'ici fin Phase 4, en plus de Nine to Fine.

Samedi 30 mai matin, brainstorming superpowers pour trancher les 5 points concrets et acter l'architecture documentaire.

## Objectifs

1. **Réaligner Phases 2-3-4** sur la stratégie Option D + projet React/TS séparé.
2. **Constituer un portfolio de 3 artefacts** distincts d'ici fin sept 2026.
3. **Rendre le PLANNING.md soutenable à 18 sem** : architecture documentaire qui ne devient pas un mur de texte de 2700+ lignes.
4. **Préserver le contexte critique** au démarrage de session Claude (zéro perte sur la phase courante + Suivi récent).
5. **Conserver tout ce qui sort du scope v1** dans un backlog structuré (`FEATURES_FUTURES.md`) — rien de jeté.

## Décisions stratégiques actées (récap brainstorming)

| # | Décision | Détail |
|---|---|---|
| **Q1 Scope v1 mi-juillet** | **B + tags-light** | Outfit CRUD + composition + Likes + Comments + Follows + profil user public + tags via input texte "comma-separated" + recherche par nom + filtres `link_to` (couleur OU category OU tag, un seul à la fois) + Tailwind polish global + **deploy Kamal** sur VPS Hetzner (Fly.io en plan B explicite si setup VPS bloque à J-3). ~12-13 j de travail étalés sem 22 → sem 29. |
| **Q2 Recalibrage cadence** | **N to F 1.5 j/sem en Phase 2-3, prélevé sur après-midi React/TS (Option α)** | Préserve Odin matin + sandbox soir. Impact ~-10% volume React/TS. Possible sacrifice d'un mini-projet React P2 (de 4 à 3). |
| **Q3 Projet React/TS vitrine** | **Outil de prep entretiens techniques** | Flashcards Rails/React/TS/algo + spaced repetition algorithm (SM-2 simplifié) + mode "entretien blanc chronométré" + IA Anthropic (génération de questions + évaluation réponses). Stack : Vite + React + TS strict + Tailwind + localStorage/IndexedDB + Anthropic SDK avec proxy minimal. **Démarrage sem 35** (dernière sem P3). |
| **Q3 bis Skill Claude Code** | **`job-tracker`** créée samedi sem 25 (20-21 juin) | Skill custom pour suivre les candidatures via slash commands (`/candidatures add`, `/candidatures list`, `/candidatures relance`). Stockage markdown ou JSON. IA Anthropic native. **3e artefact du portfolio**. |
| **Q4a Structure Phase 4** | **AA — spécialisation par jours, avec adaptabilité** | Lundi-mardi N to F / Mercredi-jeudi React/TS prep entretiens / Vendredi 100% emploi / Soir prep entretiens techniques / Samedi rattrapage + entretiens passés/à passer. |
| **Q4b Scope N to F Phase 4** | **Minimal au départ, escalade Standard si on avance** | Minimal = IA suggester de tenues (service `app/services/ai/outfit_suggester.rb` + streaming Anthropic + persistence) + tests RSpec + polish mobile + README pro + vidéo démo 90s. Standard si fin sem 37 on a ≥5 j cumulés restants. Drag-and-drop composition outfit → `FEATURES_FUTURES.md` priorité haute. Ambitieux (refacto + autocomplete tags + autres Stimulus) → `FEATURES_FUTURES.md`. |
| **Q5a Forme refonte PLANNING** | **Option II hybride** | Tableaux refondus Phases 2-3-4 + decision log persistant + mini-bullets jour-type par semaine (pas de tableau day-by-day complet comme sem 22 pour les semaines futures — fait au fil du temps). |
| **Q5b Jalons emploi** | **Reformulation détaillée maintenant** | Réf explicite aux vitrines actives à chaque jalon (mi-juin, mi-juillet, mi-août, mi-sept). |
| **Bonus Split** | **B+ — Split hybride avec import phase courante** | PLANNING.md léger (~150 lignes) + `docs/planning/` structuré. Imports `@` dans CLAUDE.md : `PLANNING.md` + `SUIVI-COURANT.md` + `PROGRESSION.md` + `PHASES/phase-{courante}.md`. Le reste lu à la demande via Read. |
| **Bonus Règle lecture Suivi** | Mardi-vendredi : focus veille + sem en cours / Lundi : sem précédente complète + sem en cours qui démarre | Ajouté dans CLAUDE.md section "Démarrage de session". |

## Architecture documentaire cible

### Arborescence

```
/Users/chriscroc/code/nine_to_fine/
├── CLAUDE.md (imports @ ajustés)
├── PLANNING.md (allégé, ~150 lignes)
├── FEATURES_FUTURES.md (NOUVEAU — backlog v1+)
└── docs/
    ├── superpowers/
    │   └── specs/
    │       └── 2026-05-30-phases-2-3-4-refonte-design.md (ce fichier)
    └── planning/ (NOUVEAU dossier)
        ├── PROGRESSION.md (NOUVEAU — extrait depuis PLANNING.md actuel)
        ├── PHASES/
        │   ├── phase-1.md (NOUVEAU — sem 22-25, hérite du contenu actuel)
        │   ├── phase-2.md (NOUVEAU — sem 26-31, refonte complète)
        │   ├── phase-3.md (NOUVEAU — sem 32-35, refonte)
        │   └── phase-4.md (NOUVEAU — sem 36-39, refonte AA)
        ├── JALONS-EMPLOI.md (NOUVEAU — extrait + reformulé)
        ├── SUIVI/
        │   ├── SUIVI-COURANT.md (NOUVEAU — sem en cours + sem précédente)
        │   └── ARCHIVE/ (NOUVEAU dossier, vide au départ)
        └── DECISIONS/
            └── 2026-05-30-refonte-strategique-phases-2-3-4.md (NOUVEAU — decision log persistant)
```

### Imports `@` dans `CLAUDE.md` projet

```markdown
@PLANNING.md
@docs/planning/SUIVI/SUIVI-COURANT.md
@docs/planning/PROGRESSION.md
@docs/planning/PHASES/phase-1.md
```

(L'import `phase-1.md` est mis à jour à chaque transition de phase : `phase-2.md` à partir de sem 26, etc. 4 éditions sur 4 mois.)

### Estimation taille / contexte chargé

| Fichier | Taille cible | Auto-chargé ? |
|---|---|---|
| PLANNING.md | ~150 lignes | ✅ |
| SUIVI-COURANT.md | ~100-200 lignes (rolling 2 sem max) | ✅ |
| PROGRESSION.md | ~60-80 lignes | ✅ |
| PHASES/phase-{courante}.md | ~80-120 lignes par phase | ✅ (phase courante seulement) |
| **Total contexte démarrage** | **~400-550 lignes** | — |
| Vs PLANNING.md actuel + sem 22 Suivi | ~520+ lignes (et croissant) | — |

Gain réel : **structure stable à 18 sem** (vs croissance linéaire actuelle vers 2700+ lignes), légère réduction contexte de démarrage immédiat (~5-20%).

## Contenu cible de chaque fichier

### `PLANNING.md` (allégé)

Structure cible :
1. **Titre + vision/objectif** (qq lignes — repris tel quel)
2. **Portfolio final 3 artefacts** (NOUVEAU encart court — N to F + Outil prep entretiens + Skill `job-tracker`)
3. **Plan par phase — vue de haut** (tableau 4 lignes, 1 par phase, avec lien vers `docs/planning/PHASES/phase-{n}.md`)
4. **Ritual quotidien fixe** (tableau existant — repris tel quel, ajout note "structure AA en Phase 4")
5. **Règles pédagogiques** (10 règles existantes — reprises telles quelles)
6. **Pointeurs vers sous-fichiers** : "Détail Phase n → docs/planning/PHASES/phase-n.md", "Suivi vivant → docs/planning/SUIVI/", "Jalons emploi → docs/planning/JALONS-EMPLOI.md", "Decisions log → docs/planning/DECISIONS/", "Features futures → FEATURES_FUTURES.md"
7. **Imports `@`** (sous CLAUDE.md projet, pas dans PLANNING.md — PLANNING ne fait pas d'imports lui-même dans cette architecture, c'est CLAUDE.md qui orchestre)

**Ce qui sort de PLANNING.md** :
- Section "Progression apprentissage / Odin Project + Tailwind + React + TS + Next" → `docs/planning/PROGRESSION.md`
- Tableaux détaillés Phase 1, 2, 3, 4 → `docs/planning/PHASES/phase-{n}.md`
- "Détail jour par jour — Sem 22" → reste dans `phase-1.md` (et plus tard dans `SUIVI-COURANT.md` après archivage)
- Section "Recherche emploi — jalons" → `docs/planning/JALONS-EMPLOI.md`
- Section "Suivi (vivant)" → `docs/planning/SUIVI/SUIVI-COURANT.md`

### `docs/planning/PHASES/phase-1.md` (NOUVEAU — sem 22-25)

Hérite du contenu Phase 1 actuel + enrichissements :
- Sem 22-24 : inchangé en grandes lignes, sauf scope élargi sem 23-24 → intégrer tags comma-separated + recherche light + filtres dans CRUD Garment et Outfit quand le moment se présente.
- **Sem 25 enrichie** : livrables Likes + Comments + Follows + profil public + **skill Claude Code `job-tracker`** (samedi 20-21 juin) + lancement candidatures (3 premières) + LinkedIn/GitHub polish.
- Mini-bullets jour-type par semaine (pas full day-by-day comme sem 22).
- Détail day-by-day sem 22 conservé (référence post-Suivi-COURANT après archivage).

### `docs/planning/PHASES/phase-2.md` (NOUVEAU — sem 26-31, refonte complète)

Header : "Focus apprentissage React" + "N to F 1.5 j/sem (1 demi-aprem/sem prélevée sur React)" + "Possible 3 mini-projets React au lieu de 4 si glissement".

6 semaines, chaque sem :
- **Apprentissage React** : sujet du Scrimba/react.dev (table existante reprise).
- **Mini-projet React** : nom + features (à reconfirmer si on passe à 3 mini-projets).
- **N to F livrables cumulés 1.5 j/sem** : sem 26-27 → Outfit CRUD + composition (OutfitGarment via fields_for / accepts_nested_attributes_for). Sem 28 → Tailwind polish global + setup Kamal. Sem 29 → tags comma-separated + recherche par nom + filtres link_to + deploy Kamal en prod. Sem 30-31 → polish + bug fixes + premières candidatures évoluent vers N to F déployé.
- Mini-bullets jour-type.

### `docs/planning/PHASES/phase-3.md` (NOUVEAU — sem 32-35)

Header : "Focus apprentissage TypeScript" + "N to F 1.5 j/sem maintenu en maintenance/polish" + "Sem 35 démarrage projet React/TS prep entretiens".

4 semaines :
- Migration TS des mini-projets React P2 (sem 32-34).
- N to F en maintenance + polish ponctuel (1.5 j/sem).
- **Sem 35 spécifique** : scaffold projet React/TS prep entretiens (Vite + React + TS strict + Tailwind + structure dossiers + premier composant `<Flashcard>` + premier test Vitest).

### `docs/planning/PHASES/phase-4.md` (NOUVEAU — sem 36-39, refonte AA)

Header : "Structure AA — spécialisation par jours" + "Adaptabilité hebdo" + "Scope N to F = Minimal (escalade Standard si on avance)".

Structure semaine type :
- **Lundi-mardi** : N to F sprint enrichissement Minimal.
- **Mercredi-jeudi** : projet React/TS prep entretiens.
- **Vendredi** : 100% emploi (10+ candidatures + relances via skill `job-tracker` + suivi entretiens en cours).
- **Soir** : prep entretiens techniques (questions Rails/React/TS + révision projets vitrine).
- **Samedi** : rattrapage + entretiens passés/à passer.

4 semaines :
- Sem 36 : Setup feature IA suggester + premier service Anthropic + streaming response. MVP projet React/TS (flashcards + spaced repetition localStorage).
- Sem 37 : Feature IA finie (UI + persistence des suggestions + edge cases) + tests RSpec services IA. Projet React/TS : intégration IA Anthropic.
- Sem 38 : Polish global N to F (mobile, accessibility, README pro). Projet React/TS : polish UI Tailwind + déploiement Vercel.
- Sem 39 : Bug-fixing + vidéo démo 90s N to F + finitions projet React/TS + emploi 100%.

**Règles d'adaptabilité P4** (section dédiée) :
- **Checkpoint hebdo dimanche soir** (10 min) : revue sem qui passe + alignement sem qui vient.
- **Règle 1** : si pas d'entretien la sem X → temps libéré redistribué sur le projet en retard.
- **Règle 2** : si entretien tombe milieu de sem → on coupe sur **un seul** projet (le moins urgent au regard du jalon emploi).
- **Règle 3** : escalade scope N to F P4 Minimal → Standard validable **fin sem 37 seulement**, et uniquement si **(a)** IA suggester + tests RSpec + polish v1 Minimal sont terminés à fin sem 37 **et (b)** il reste ≥ 4 j cumulés sur les lundis-mardis sem 38-39 (soit tout le buffer N to F P4 restant). Standard escalation light = audit Bullet + indexes manquants + premier niveau cache Solid_cache. Scope ambitieux (refacto + autocomplete tags + Stimulus avancé) reste hors P4 dans tous les cas.

### `docs/planning/PROGRESSION.md` (NOUVEAU)

Extrait depuis section "Progression apprentissage" actuelle de PLANNING.md. Contenu inchangé :
- Odin Project — Full Stack Ruby on Rails (Fait / Prochain / Skip délibéré / URL)
- Tailwind CSS (Fait / Prochain)
- React (Fait / Prochain)
- TypeScript (Fait / Prochain)
- Next.js (Fait / Prochain)

Critique pour démarrage de session (annonce sujet matin Odin + avant-midi focus phase).

### `docs/planning/JALONS-EMPLOI.md` (NOUVEAU — reformulé détaillé)

```markdown
# Jalons recherche emploi — Chris Crokaert

| Jalon | Cible candidatures/sem | Vitrines présentables |
|---|---|---|
| **Mi-juin (sem 25)** | 3 premières candidatures Rails | N to F en construction : CRUD Garment + Outfit + composition + tags + social en cours. **Skill `job-tracker` activée** (créée samedi sem 25). LinkedIn + GitHub propres. |
| **Mi-juillet (sem 29)** | 3-5 candidatures/sem + 1 contact alumni/sem | **N to F v1 polishée + déployée Kamal (Hetzner)** = vitrine 1 active. |
| **Mi-août (sem 33)** | 5-10 candidatures/sem | N to F en maintenance + mini-projets TS bien avancés. Pas de nouveau livrable majeur côté projet. |
| **Mi-sept (sem 37-38)** | 10+ candidatures/sem + entretiens en cours | **Projet React/TS prep entretiens MVP + IA Anthropic** = vitrine 2 active. Portfolio complet = 3 artefacts (N to F + Prep entretiens + skill `job-tracker`). |

**Plateformes cibles** : Welcome to the Jungle, LinkedIn Jobs, Indeed France, Collective.work, réseau alumni Le Wagon.
```

### `docs/planning/SUIVI/SUIVI-COURANT.md` (NOUVEAU)

Reçoit la section "Suivi (vivant)" actuelle de PLANNING.md.

**Politique de rolling** :
- À tout moment, contient **la semaine en cours + la semaine précédente complète**.
- Début de mois (au plus tard **le premier lundi du mois suivant**) : archive de tout le mois précédent vers `SUIVI/ARCHIVE/{YYYY-MM}.md`. SUIVI-COURANT.md ne garde que la sem en cours (et la sem précédente si on est en début de sem). Rotation déclenchée via routine `/end-of-day` (à créer samedi sem 22) ou à défaut manuellement.

**Premier contenu** : Sem 22 actuelle (25-31 mai) reprise telle quelle, sans archivage immédiat (on n'archive qu'à fin mai / début juin).

### `docs/planning/SUIVI/ARCHIVE/` (NOUVEAU dossier, vide au départ)

Format : un fichier par mois (`2026-05.md`, `2026-06.md`, etc.) avec le Suivi des sem qui s'y rapportent.

Rotation déclenchée par routine `/end-of-day` (à créer samedi sem 22) ou manuellement en début de mois.

### `docs/planning/DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md` (NOUVEAU — decision log)

Contenu : le "decision log persistant" — explication des arbitrages pris ce samedi 30 mai. Sert de mémoire stable des choix pour ne pas perdre le fil dans 3 mois.

Structure :
1. Contexte du déclencheur (vendredi 29 mai midi, 3 risques identifiés).
2. Options envisagées vendredi (Option A/B/C/D + raisons d'écarter A/B/C).
3. Option D actée + contrainte additionnelle (projet React/TS séparé).
4. 5 points tranchés samedi matin (récap des Q1-Q5 du brainstorming) avec raisons.
5. Bonus split architecture documentaire (Stratégie B+).
6. Implications opérationnelles (Phases 2-3-4 refondues, FEATURES_FUTURES créé, etc.).
7. Conditions de re-évaluation (à quelles conditions on rediscuterait ces choix ; ex : si en sem 28 N to F n'est pas à 60% du scope v1, signal d'alerte).

### `FEATURES_FUTURES.md` (NOUVEAU — racine projet)

Structure cible :

```markdown
# Features Futures — Nine to Fine

Backlog des features sorties du scope v1 mi-juillet, à réintégrer post-emploi (oct 2026+) ou au gré des opportunités.

Chaque feature : nom, contexte d'origine (quand/pourquoi sortie), description précise, dépendances techniques, estimation, slot suggéré de réintégration.

## Priorité haute

### Drag-and-drop composition outfit
- **Contexte d'origine** : sortie samedi 30 mai 2026 (refonte stratégique Phase 4, Q4b). Marquée "essentielle à terme" par Chris.
- **Description** : sur la page de composition d'un outfit, permettre de glisser-déposer des garments depuis la liste latérale vers la zone "tenue en cours de composition". Réordonner par drag dans la zone.
- **Stack** : Stimulus controller `outfit_composer_controller.js` + bibliothèque `Sortable.js` (importmap) ou alternative native HTML5 drag-and-drop. Persistance via update PATCH/AJAX vers `outfit_garments_controller`.
- **Estimation** : 2-3 j (Stimulus + Sortable.js + UX + tests système Capybara).
- **Slot suggéré** : Phase 4 sem 38-39 si on a escaladé vers Standard, sinon post-emploi (oct 2026+).

## Priorité moyenne

### Autocomplete Stimulus sur input tags
- **Contexte d'origine** : sortie Q1 brainstorming 30 mai. V1 utilise input texte "comma-separated" (UX éprouvée Gmail/GitHub/StackOverflow). Autocomplete = polish ultérieur.
- **Description** : suggestions de tags existants pendant la saisie, avec filtrage live et création-on-the-fly si tag inconnu.
- **Stack** : Stimulus controller + endpoint JSON `tags#autocomplete?q=...`.
- **Estimation** : 1.5-2 j.
- **Slot suggéré** : post-emploi ou Phase 4 ambitieuse.

### Combinaison de filtres (couleur ET tag ET category)
- **Contexte d'origine** : sortie Q1. V1 = 1 filtre à la fois via link_to.
- **Description** : combiner plusieurs filtres simultanément.
- **Stack** : Refactor du scoping côté model + UI checkboxes / pills désélectionnables.
- **Estimation** : 1-2 j.
- **Slot suggéré** : post-emploi.

### Ransack ou équivalent (recherche full-text)
- **Contexte d'origine** : sortie Q1. V1 = recherche par nom uniquement via scope simple.
- **Description** : recherche full-text avec gem Ransack ou pg_search.
- **Stack** : gem + UI search bar avancée.
- **Estimation** : 2 j.
- **Slot suggéré** : post-emploi.

### Refactor partiel modèle (à identifier post-v1)
- **Contexte d'origine** : sortie Q4b. Si après v1 un modèle s'avère mal posé (typiquement Outfit ou Tagging), refactoring.
- **Description** : TBD selon ce qui se révèle problématique.
- **Estimation** : variable.
- **Slot suggéré** : post-emploi.

### Audit perf + Solid_cache + Bullet + indexes
- **Contexte d'origine** : sortie Q4b. Scope "Standard" P4 si on a le temps.
- **Description** : ajout gem `bullet` (groupe development) pour détection N+1, configuration `Solid_cache` pour cache fragment sur home/index, audit des indexes manquants sur les jointures fréquentes.
- **Estimation** : 2-3 j cumulés.
- **Slot suggéré** : Phase 4 Standard escalation (fin sem 37 si conditions Règle 3 remplies) ou post-emploi.

## Priorité basse

### (à compléter au fil du temps)

```

## Imports `CLAUDE.md` projet ajustés

Section actuelle :
```markdown
@PLANNING.md
```

Section cible :
```markdown
@PLANNING.md
@docs/planning/SUIVI/SUIVI-COURANT.md
@docs/planning/PROGRESSION.md
@docs/planning/PHASES/phase-1.md
```

À chaque transition de phase, mettre à jour la dernière ligne :
- sem 26 : `@docs/planning/PHASES/phase-2.md`
- sem 32 : `@docs/planning/PHASES/phase-3.md`
- sem 36 : `@docs/planning/PHASES/phase-4.md`

## Règles ajoutées dans `CLAUDE.md` projet section "Démarrage de session"

Ajout après l'étape 6 actuelle :

```markdown
**Lecture du Suivi au démarrage de session** :
- **Mardi à vendredi** : focus sur la journée de la veille + la semaine en cours. Annonce du programme du jour en référence directe à ce qui a été fait hier (continuité fine).
- **Lundi (ou première session de la semaine)** : lecture intégrale de la semaine précédente complète + de la semaine en cours qui démarre. Annonce du démarrage de semaine avec récap des accomplissements + blocages + ajustements de la sem précédente, **avant** le programme du jour. Couplé avec la routine `gh issue list` du lundi (déjà prévue).
```

## Hors scope de cette refonte

- Migration du contenu vers Obsidian. Le vault Obsidian reste dédié aux notes d'apprentissage (Apprentissage/Rails/, Apprentissage/Tailwind/, etc.). Le PLANNING reste dans le repo.
- Création du skill `/end-of-day` Claude Code. Prévue samedi 30 mai dans les chantiers tactiques séparés. Ce spec ne le couvre pas.
- Rédaction concrète du `FEATURES_FUTURES.md` au-delà de la structure initiale et des items déjà listés. Les items "priorité basse" seront ajoutés au fil du temps.
- Implementation des features de `FEATURES_FUTURES.md`. Elles sont par définition reportées.
- Mise à jour du contenu de `CLAUDE.md` global utilisateur (`~/.claude/CLAUDE.md`). Cette refonte concerne le `CLAUDE.md` projet uniquement.

## Vérifications post-implémentation (checklist à l'issue du plan)

1. PLANNING.md fait < 200 lignes effectives.
2. SUIVI-COURANT.md contient exactement la sem 22 (puisque pas encore de sem 23).
3. ARCHIVE/ existe mais est vide (rotation déclenchée à fin mai / début juin).
4. Tous les imports `@` de CLAUDE.md projet pointent vers des fichiers existants et non vides.
5. Démarrage de session Claude (test manuel) : Claude annonce correctement Phase 1, sem 22, programme du jour samedi, en se référant au Suivi sem 22.
6. FEATURES_FUTURES.md contient au moins drag-and-drop + autocomplete tags + combinaison filtres + Ransack + refactor partiel + audit perf, tous marqués "non implémenté".
7. Decision log 2026-05-30-...md existe et contient les 7 sections prévues.
8. Refonte tableaux Phases 2-3-4 : chaque sem a au moins objectif + livrables + mini-bullets jour-type.
9. JALONS-EMPLOI.md reformulé avec colonne "Vitrines présentables" remplie pour les 4 jalons.
10. Git : tous les fichiers ajoutés/modifiés sont committés avec message convention (`chore(planning): ...` ou `docs(planning): ...`).

## Conditions de re-évaluation

Le plan acté ici doit être re-discuté si :
- **Fin sem 26 (28 juin)** : N to F n'a pas atteint Outfit CRUD + composition fonctionnels. → signal de retard, possible recalibrage du scope v1 vers A (minimum).
- **Fin sem 28 (12 juillet)** : Tailwind polish + setup Kamal pas commencés. → menace sur jalon mi-juillet, fallback Fly.io activé.
- **Fin sem 31 (2 août)** : N to F v1 pas déployée en prod. → jalon mi-juillet manqué, repli scope ou décalage déploiement à mi-août.
- **Fin sem 34 (23 août)** : aucune réponse positive aux candidatures. → réviser CV, LinkedIn, qualité narratif, possible élargissement plateformes / villes / remote-only.
- **Fin sem 37 (13 sept)** : projet React/TS prep entretiens pas en mesure d'être déployé. → repli sur un MVP plus minimaliste sans IA Anthropic (juste flashcards + spaced repetition).

## Étapes suivantes

1. Self-review de ce spec (placeholder, contradictions, ambiguïté, scope) — fait juste après écriture.
2. Revue par Chris : il relit ce fichier et confirme / demande des modifications.
3. Si validé, passage au skill `writing-plans` pour produire le plan d'exécution étape par étape (création de chaque fichier, ordre des édits, commits, vérifications).
