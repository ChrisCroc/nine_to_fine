# Phase 4 — Sprint enrichissement N to F + projet React/TS prep entretiens + emploi intensif (sem 37-40, 7 sept → 4 oct)

> ⚠️ **Décalage +1 semaine acté 23 juin 2026** (semaine vacances sem 26, cf. [PLANNING.md](../../../PLANNING.md)). Dates de phase mises à jour ci-dessus ; **les sem/dates internes sont à recaler de +1 semaine en début de phase**. ⭐ **Next.js est l'amortisseur de re-convergence** : s'il faut tenir la cible fin sept, on sacrifie Next.js (déjà optionnel) pour rattraper la semaine décalée — décision à trancher en fin de Phase 3.

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
