# Phase 3 — TypeScript + N to F maintenance + démarrage projet React/TS vitrine (sem 33-36, 10 août → 6 sept)

> ⚠️ **Décalage +1 semaine acté 23 juin 2026** (semaine vacances sem 26, cf. [PLANNING.md](../../../PLANNING.md)). Dates de phase mises à jour ci-dessus ; **les sem/dates internes (tables, jour par jour) sont à recaler de +1 semaine en début de phase** — non réécrites maintenant (2+ mois d'horizon, re-convergence possible via Next.js Phase 4 optionnel).

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
