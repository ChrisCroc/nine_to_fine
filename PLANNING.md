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
| **Phase 1** | 25 mai → 21 juin (sem 22-25) — ⭐ **techniquement bouclée 12 juin (9 j d'avance)**, sem 25 = consolidation dispersée + features sociales N to F + lancement emploi | Rails pro + Tailwind | [`docs/planning/PHASES/phase-1.md`](docs/planning/PHASES/phase-1.md) |
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
| **Fin de journée** | 5-10 min | **Reco 2 vidéos par Claude** (GoRails / Drifting Ruby ; Railscasts si concept intemporel flaggé) | 🎬 **Consolidation passive** : 2 vidéos backward (concept du jour) ou forward (concept à venir), choix selon contexte. Voir routine `Fin de session` dans [`CLAUDE.md`](CLAUDE.md). |
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
11. **Note Obsidian post-lecture** : après **chaque lecture profonde** de Chris (Odin Rails, Tailwind, React, TypeScript, Next.js — matin et avant-midi), Claude rédige automatiquement une note de consolidation dans `~/Obsidian/DevJobReady/Apprentissage/<Techno>/<sous-dossier>/<concept>.md`. La note couvre : (a) **résumé conceptuel** de ce qui a été lu, (b) **application directe Nine to Fine** quand pertinent, (c) **pièges à graver** + erreurs fréquentes, (d) **Knowledge Check répondus par écrit** (lié à la règle 9), (e) **liens internes** vers notes existantes, (f) **"à approfondir plus tard"**. Frontmatter standardisé (`created`, `stack`, `version`, `chapitre_doc` ou `chapitre_odin`, `tags`, `sources`). Index de la techno (`Apprentissage/<Techno>/index.md`) mis à jour avec mini-description. Sources externes vérifiées (cf. CLAUDE.md global "consulte la doc officielle avant de répondre").

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
