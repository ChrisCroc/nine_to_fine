# Nine to Fine

Application Rails de gestion de garde-robe et de tenues. Projet vitrine principal de Chris pour démontrer un niveau fullstack + intégration IA dans l'objectif d'un poste de dev junior pour fin septembre 2026.

## Stack

- **Rails 8.1.3** (Ruby `.ruby-version`)
- **PostgreSQL** (`pg ~> 1.1`)
- **Devise** pour l'authentification (avec champ `username` ajouté)
- **Tailwind CSS** via gem `tailwindcss-rails`
- **Hotwire** : Turbo + Stimulus
- **Propshaft** (asset pipeline moderne Rails 8)
- **Importmap-rails** (JS sans bundler)
- **Solid Cache + Solid Queue** (cache & jobs DB-backed Rails 8)
- **Jbuilder** pour les futures réponses JSON / API
- **Kamal** + Dockerfile pour le déploiement

## Architecture data (en construction)

```
User has_many Garments, Outfits, Likes, Comments, WishlistItems, Follows

Garment belongs_to User
Garment has_many Outfits, through: OutfitGarments

Outfit belongs_to User
Outfit has_many Garments, through: OutfitGarments
Outfit has_many Likes
Outfit has_many Comments

OutfitGarment belongs_to Garment, Outfit

Like belongs_to User, Outfit
Comment belongs_to User, Outfit
WishlistItem belongs_to User
Follow belongs_to User
```

## Conventions de ce projet

- **Tests obligatoires** sur les models (RSpec à introduire en sem 24, voir PLANNING.md)
- **Pas de logique métier dans les controllers** : controllers minces, models gros, services pour la logique transverse
- **Services pour la couche IA** : un dossier `app/services/ai/` pour les appels à l'API Anthropic (suggestions de tenues)
- **Tailwind dans les vues** : pas de CSS custom sauf cas particulier
- **Branches** : jamais de commit direct sur `main`. Travailler sur des branches `feature/`, `fix/`, `chore/`
- **Commits** : messages en anglais, format `type: short description` (`feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`)

## Sandbox d'exercices

Dossier parent `~/code/sandbox/` contenant un sous-dossier par technologie, chacun étant un repo Git autonome :

- `~/code/sandbox/rails/` — repo [ChrisCroc/sandbox-rails](https://github.com/ChrisCroc/sandbox-rails) (anciennement `sandbox_s1`, renommé 2026-05-28). App Rails 8 dédiée aux exos de consolidation.
- `~/code/sandbox/tailwind/` — fichiers HTML standalone avec Tailwind via CDN.
- `react/`, `typescript/`, `nextjs/` : à créer aux phases ultérieures si besoin.

**Usage** : slot du soir (30-45 min) dans le ritual quotidien. Exos basés sur Knowledge Check Odin + sous-portions des "Project: X" Odin + cas limites du code de l'aprem dans Nine to Fine. Voir règles pédagogiques 8, 9, 10 du `PLANNING.md`.

**Convention de commit pour le sandbox Rails** : `exo(<concept>): <short desc>` (ex: `exo(callbacks): add before_save normalize_name on Garment`).

Mémoire détaillée : `~/.claude/projects/-Users-chriscroc-code-nine-to-fine/memory/sandbox-setup.md`.

## État actuel

Source unique de vérité : section **"Suivi (vivant)"** dans `PLANNING.md`. À mettre à jour à la fin de chaque journée.

## Démarrage de session

Dès le **premier message** de Chris dans une nouvelle session sur ce projet, ta toute première action — avant de répondre à son message — est de :

1. Lire la **date du jour** (fournie dans le contexte system)
2. Déterminer la **semaine ISO** et la **phase courante** d'apprentissage selon `PLANNING.md`
3. Annoncer à Chris la phase et la semaine en cours.
4. Annoncer le **programme COMPLET du jour, slot par slot**, avec un sujet précis pour chacun :
   - **Matin (Odin Rails, 1h30-2h)** : nom du chapitre exact à voir, basé sur la section **"Progression apprentissage / Odin Project"** de `PLANNING.md` (le prochain de la liste, avec lien si dispo)
   - **Avant-midi (Focus apprentissage, 2h30-3h)** : sujet/ressource précis basé sur la section **"Progression apprentissage"** de la stack de la phase courante (Tailwind / React / TS / Next), avec lien
   - **Après-midi (Production projet, 2h30-3h)** : tâche du jour selon le tableau "Détail jour par jour" de la semaine en cours
   - **Soir (Exo dirigé, 30-45 min)** : annonce qu'on définira le sujet ensemble en fin de journée, en continuité avec ce que Chris aura codé
   - **Vendredi PM (uniquement si on est vendredi, dès sem 25)** : tâches de recherche emploi
5. Citer les **blocages ou ajustements** notés la veille dans la section Suivi.
6. **Si c'est lundi** (ou première session de la semaine) : proposer à Chris de fetcher les issues GitHub de la semaine via `gh issue list` et de mettre à jour la section Suivi avec les US visées cette semaine. Le kanban GitHub Projects n'étant pas lu automatiquement, c'est le moyen de garder le PLANNING.md aligné avec le backlog.

Si la date du jour ne correspond à aucune journée détaillée, demande à Chris ce qu'il veut prioriser.

**Puis** réponds normalement à son message.

## Planning d'apprentissage

Le projet est utilisé comme support pour le plan d'apprentissage 18 semaines de Chris (25 mai → 27 sept 2026). Voir le fichier importé ci-dessous pour les jalons, ritual quotidien, détail des semaines en cours, règles pédagogiques et journal de suivi.

@PLANNING.md
