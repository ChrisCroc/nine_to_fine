# Phase 2 — React fondamentaux + N to F polish/deploy (sem 26-31, 22 juin → 2 août)

> ⭐ **Note de continuité Phase 1 → Phase 2** : Phase 1 techniquement bouclée vendredi 12 juin 2026 (9 jours d'avance — voir [Bilan Phase 1](phase-1.md#-bilan-phase-1--bouclée-vendredi-12-juin-9-jours-en-avance)). Sem 25 (15-21 juin, fin Phase 1) inclut une **journée consolidation hybride mercredi 17 juin** (Stimulus avancé + Metaprog) + soirs sandbox dirigés (Turbo Streams, AR Queries, APIs Phase 4 prep). Démarrage Phase 2 React lundi 22 juin (sem 26) **inchangé** — la timeline emploi septembre 2026 n'est pas impactée.

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
