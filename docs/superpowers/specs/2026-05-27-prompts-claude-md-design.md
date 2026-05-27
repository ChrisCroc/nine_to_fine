# Spec — Refonte du prompt système Chris Crokaert en 4 livrables

**Date** : 2026-05-27
**Auteur** : Chris Crokaert
**Statut** : Validé en brainstorming, à produire

## Contexte

Chris Crokaert (Christophe Crokaert), dev junior post-Le Wagon (camp 2258, mai 2026), basé en Belgique, vise un poste de dev junior à Paris ou full remote d'ici fin septembre 2026. Il dispose d'un prompt système monolithique. L'objectif est de le décomposer en 4 livrables ciblés, chacun avec un rôle distinct, pour exploiter pleinement les mécanismes de chargement automatique de Claude Code et de Claude.ai (Projects).

## Objectifs

1. Avoir un comportement Claude cohérent et personnalisé sur **tous les projets** (CLI et web)
2. Avoir un contexte projet Nine to Fine clair, autonome et auto-chargé
3. Avoir un planning d'apprentissage **vivant** sur 18 semaines (25 mai → 27 septembre 2026) pour structurer l'objectif d'employabilité
4. Maximiser les chances de décrocher un poste junior fin septembre 2026 en optimisant l'apprentissage de la stack cible : Ruby on Rails (consolidation pro), Tailwind, React, TypeScript, et intégration d'agents IA

## Architecture des livrables

| # | Fichier / Destination | Chargement |
|---|---|---|
| 1 | `~/.claude/CLAUDE.md` (global Claude Code) | Auto dans toutes les sessions CLI |
| 2 | System prompt Claude.ai Project (web/desktop) | À coller dans "Custom instructions" du Project |
| 3 | `CLAUDE.md` racine projet Nine to Fine | Auto dès `cd nine_to_fine/` et lancement Claude Code |
| 4 | `PLANNING.md` racine projet Nine to Fine | Importé via `@PLANNING.md` depuis le CLAUDE.md projet |

## Contenu des livrables

### Livrable #1 — `~/.claude/CLAUDE.md` (global Claude Code)

Format : CLI concis, sections à puces.

Sections :
- Qui je suis (2-3 lignes)
- Stack et setup (Mac M4 Pro, AZERTY, Ghostty, VS Code)
- Comment je veux que tu codes (commentaires obligatoires quoi+pourquoi, bonnes pratiques pro, challenger, signaler erreurs fréquentes, adapter au niveau)
- Règles d'apprentissage (jamais la solution directe, le pourquoi d'abord, questions de vérification, 2 alternatives)
- Comportement (direct, pas de flatterie, dire "je ne sais pas", demander confirmation actions importantes, prévenir si irréversible, plan avant tâche longue, clarifier si flou, **se relire avant de proposer**, **challenger ce que je dis — pas que les choix techniques — et argumenter le contre-point**, **toujours consulter la doc officielle et les ressources disponibles avant de répondre sur un sujet technique précis : pas se reposer sur la mémoire**, **vérifier les chiffres, pourcentages, opinions que je balance — ne pas les prendre pour acquis**)
- Format réponses (solution directe d'abord, détails ensuite, FR par défaut)
- Projets persistants (Nine to Fine = projet vitrine principal)

Suppressions vs. ancien prompt : aucune mention de Readapt, aucune mention de Shortcut iPhone YouTube.

### Livrable #2 — System prompt Claude.ai Project (web)

Même contenu que #1 mais format **narratif** (paragraphes au lieu de puces). Autonome (le chat web n'a pas le contexte d'un repo ouvert).

Ajouts vs. #1 :
- Ressources d'apprentissage explicites (Odin Project pour Rails, Scrimba + react.dev pour React, Total TypeScript pour TS, Tailwind Labs YouTube pour Tailwind, Learn Next.js officiel)
- Plateformes recherche emploi (Welcome to the Jungle, LinkedIn Jobs, Indeed France, Collective.work, alumni Le Wagon)

### Livrable #3 — `CLAUDE.md` racine Nine to Fine

Format CLI concis.

Sections :
- Nine to Fine : 1 phrase de description
- Stack (Rails 8, PostgreSQL, Devise avec username, Tailwind, Hotwire/Turbo)
- Architecture data : récap des models et relations (extrait de NOTES.md)
- Conventions de ce projet (tests obligatoires sur models, pas de logique métier dans controllers, services pour la couche IA)
- Import : `@PLANNING.md`

### Livrable #4 — `PLANNING.md` racine Nine to Fine

Sections :
- Objectif global (poste junior fin sept 2026)
- Ritual quotidien fixe
- Planning par phase (4 phases, 18 semaines)
- Sujets Odin Project par phase (Rails — consolidation ciblée à partir de l'état actuel)
- Règles pédagogiques (comment Claude doit coacher)
- Recherche emploi : jalons globaux
- Section "Suivi" vivante (accomplissements semaine, blocages, ajustements)

## Plan d'apprentissage 18 semaines (25 mai → 27 septembre 2026)

### Ritual quotidien fixe

| Slot | Durée | Activité |
|---|---|---|
| Matin | 1h30-2h | Odin Project (Rails — sujet du jour défini) |
| Avant-midi | 2h30-3h | Focus apprentissage de la phase courante |
| Après-midi | 2h30-3h | Production projet (Nine to Fine ou mini-projet selon phase) |
| Soir | 30-45 min | Exercice dirigé par Claude (continuité hebdo) |
| Vendredi PM | 1h (à partir de sem 25) | Recherche emploi (candidatures, LinkedIn, alumni) |
| Samedi | 4-5h | Rattrapage / projet / recherche emploi |
| Dimanche | OFF | Repos obligatoire (anti-burnout) |

Volume cible : 40-55h/semaine.

### Phase 1 — Rails pro + Tailwind (sem 22-25, 25 mai → 21 juin)

Focus apprentissage : **Tailwind CSS** (Tailwind Labs YouTube + docs officielles).
Sujets Odin Rails : Active Record avancé (callbacks, scopes, query optim), Forms avancées, Authentication "from scratch" (avant d'utiliser Devise).

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 22 | 25-31 mai | Finir scaffolding models Nine to Fine + Tailwind setup | Tous les models (Garment, Outfit, Category, OutfitGarment, Tag, Like, Comment, Follow). Tailwind installé. 1ère page stylée. |
| 23 | 1-7 juin | CRUD Garment complet + intro Tailwind layouts | Upload photo (Active Storage), index/show/new/edit Garments, navbar Tailwind responsive |
| 24 | 8-14 juin | CRUD Outfit + composition de tenues | OutfitGarment join, page composition d'outfit, premiers tests RSpec |
| 25 | 15-21 juin | Likes, Comments, profils publics + **lancement recherche emploi** | Likes/Comments fonctionnels, profil user public. **LinkedIn + GitHub à jour. 3 premières candidatures Rails.** |

### Phase 2 — React fondamentaux (sem 26-31, 22 juin → 2 août)

Focus apprentissage : **React** (Scrimba CS Career Path + react.dev officiel).
Sujets Odin Rails : APIs Rails + Testing RSpec à fond (faiblesse classique des juniors).

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 26 | 22-28 juin | JSX, composants, props | Mini-projet 1 : `react-todo` (noms par défaut, renommables) |
| 27 | 29 juin-5 juil | useState, événements, listes | Mini-projet 2 : `react-flashcards` |
| 28 | 6-12 juil | useEffect, fetch, async | Mini-projet 3 : `react-weather` (consomme API publique) |
| 29 | 13-19 juil | Composition, lifting state, custom hooks | Refacto des 3 mini-projets avec hooks custom |
| 30 | 20-26 juil | React Router + formulaires contrôlés | Mini-projet 4 : `react-notes` (multi-pages, CRUD local) |
| 31 | 27 juil-2 août | Contexte, state global léger | Ajout dark mode + auth fake (Context) à `react-notes` |

Nine to Fine en maintenance pendant cette phase (1 jour/sem pour ne pas oublier Rails).

### Phase 3 — TypeScript (sem 32-35, 3-30 août)

Focus apprentissage : **TypeScript** (Total TypeScript "Beginner's TypeScript" de Matt Pocock).
Sujets Odin Rails : Performance, caching, background jobs (Sidekiq), mailers.

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 32 | 3-9 août | Types primitifs, interfaces, types fonctions | Migration `react-todo` → TS |
| 33 | 10-16 août | Generics, narrowing, types utilitaires | Migration `react-weather` → TS (types pour API response) |
| 34 | 17-23 août | TS avancé : discriminated unions, satisfies, mapped types | Migration `react-notes` → TS strict |
| 35 | 24-30 août | TS + React patterns pro (props strictes, hooks typés, contextes typés) | Tous mini-projets en TS strict, README pro chacun. **Décision actée : projet vitrine = Nine to Fine v2.** |

### Phase 4 — Projet vitrine + emploi intensif (sem 36-39, 31 août → 27 sept)

Focus apprentissage : **Next.js** (Learn Next.js officiel) si dans les temps. Sinon, vanilla React+TS+Vite.
Sujets Odin Rails : Advanced topics + révision en mode entretien (questions techniques classiques).

| Sem | Dates | Objectif | Livrables |
|---|---|---|---|
| 36 | 31 août-6 sept | Setup projet vitrine Nine to Fine v2 : SPA React+TS+Tailwind ⇄ API Rails | API JSON Rails (refacto Nine to Fine v1) + front React TS scaffold |
| 37 | 7-13 sept | Fonctionnalités cœur + intégration agent IA | 2-3 features clés en place, premier appel API Anthropic depuis le back |
| 38 | 14-20 sept | Polish UI Tailwind, tests, déploiement | Déployé (Vercel front + Render/Fly back), README pro, vidéo démo 90s |
| 39 | 21-27 sept | Finitions + emploi à 100% | **10+ candidatures/semaine**, préparation entretiens techniques (React, Rails, TS) |

### Recherche emploi — jalons globaux

- **Mi-juin (sem 25)** : LinkedIn + GitHub propres, 3 candidatures Rails
- **Mi-juillet (sem 29)** : 3-5 candidatures/sem, 1 contact alumni/sem
- **Mi-août (sem 33)** : 5-10 candidatures/sem
- **Septembre** : 10+ candidatures/sem, entretiens en cours

Plateformes : Welcome to the Jungle, LinkedIn Jobs, Indeed France, Collective.work, alumni Le Wagon.

## Règles de comportement permanent (livrables #1 et #2)

Ces règles s'appliquent à toutes les sessions, tous projets confondus :

1. Direct, pas de flatterie, pas de "bien vu" / "tu as raison" automatique
2. Si je ne sais pas, je le dis, je n'invente pas
3. **Challenger ce que Chris dit — pas seulement les choix techniques. Toute affirmation. Argumenter le contre-point.**
4. **Toujours consulter la doc officielle et les ressources disponibles avant de répondre sur un sujet technique précis. Ne pas se reposer sur la mémoire.**
5. **Vérifier les chiffres, pourcentages, opinions que Chris balance. Ne pas les prendre pour acquis.**
6. Se relire avant de proposer une réponse ou du code
7. Chaque ligne de code expliquée (quoi + pourquoi)
8. Demander confirmation avant chaque action irréversible ; prévenir si irréversible
9. Plan avant tâche longue, clarifier si question floue
10. **Jamais de `git push`. Jamais de modification directe sur `main` / `master`.** Travail sur branches uniquement.
11. **Bash autorisé sans demander** : commandes de lecture (`ls`, `pwd`, `cat`, `grep`, `find`), `git status`, `git diff`, `git log`, `git add`, `git commit`. Toute autre commande Bash : demander confirmation.
12. **Réponses droit au but**. Pas de blabla, pas de phrases de transition inutiles, pas de récap superflu. Concision maximale dans la limite des explications nécessaires.

## Règles pédagogiques (livrable #4 — spécifiques à l'apprentissage)

1. Jamais la solution directement — le "pourquoi" d'abord
2. Questions de vérification avant de passer à la suite
3. Continuité entre exercices du soir (logique de cursus, chaque exercice s'appuie sur les précédents)
4. 2 alternatives quand pertinent, avec trade-offs
5. Adapter le niveau : Rails = challenger fort (pro), React/TS/Tailwind = vulgariser plus
6. Signaler erreurs fréquentes liées au code que Chris vient d'écrire
7. Lecture/vidéo quotidienne suggérée (source vérifiée 2x, datée)

## Plateformes d'apprentissage validées

| Stack | Plateforme principale | Pourquoi |
|---|---|---|
| Rails | Odin Project (Full Stack Ruby on Rails) | Parcours déjà entamé. Consolidation ciblée à partir de Active Record/Validations/Associations (déjà acquis). |
| React | Scrimba CS Career Path + react.dev | Scrimba pour interactif. react.dev = meilleure doc officielle gratuite en 2026. |
| TypeScript | Total TypeScript "Beginner's TypeScript" (Matt Pocock) | Matt Pocock = référence TS 2026, format dense interactif, mieux que Scrimba. |
| Tailwind | Tailwind Labs YouTube + docs officielles | Adam Wathan en live coding, pro, rapide. |
| Next.js | Learn Next.js officiel (gratuit, ~6h) | Phase 4 si dans les temps. |

## Comment installer / utiliser les fichiers

### Livrable #1 — `~/.claude/CLAUDE.md`
```bash
# Placer le contenu dans ~/.claude/CLAUDE.md (créer si inexistant)
# Sera chargé automatiquement à chaque session Claude Code, tous projets confondus
```

### Livrable #2 — System prompt Claude.ai
1. Claude.ai → sidebar gauche → Projects → "+ Create project"
2. Nom : "Chris — Dev Job Ready Sept 2026"
3. Coller le contenu dans "Custom instructions"
4. Optionnel : uploader le CLAUDE.md du projet et le PLANNING.md dans "Project knowledge"

### Livrables #3 et #4 — Fichiers projet Nine to Fine
```bash
# À placer à la racine du projet
/Users/chriscroc/code/nine_to_fine/CLAUDE.md
/Users/chriscroc/code/nine_to_fine/PLANNING.md
```
Le `@PLANNING.md` dans le CLAUDE.md projet force l'import automatique du planning à chaque session.

## Hors-scope (ne pas inclure dans cette spec)

- Détail de chaque exercice du soir (sera défini au fil de l'eau par Claude au cours du soir)
- Détail des features Nine to Fine v2 (à brainstormer en sem 35)
- Process d'évaluation hebdomadaire formel (peut être ajouté plus tard dans PLANNING.md si besoin)
- Templates de candidatures / CV (sera traité dans une session dédiée)
