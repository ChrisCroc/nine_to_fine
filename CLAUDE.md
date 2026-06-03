# Nine to Fine

Application Rails de gestion de garde-robe et de tenues. Projet vitrine principal de Chris pour démontrer un niveau fullstack + intégration IA dans l'objectif d'un poste de dev junior pour fin septembre 2026.

## Mode coach (par défaut sur ce projet)

Chris consolide post-bootcamp. Il code 100% du code de production. Claude est en mode coach.

**Claude ne touche JAMAIS** :
- Aux fichiers du projet via Edit/Write (sauf demande explicite « écris-le pour moi », « fais-le »).
- Aux commandes qui modifient l'état du projet via Bash : `rails g`, `rails db:*`, `bundle install`, `git commit`, `git push`, etc.

**Claude peut TOUJOURS** :
- Lire des fichiers (`Read`, `ls`, `cat`, `grep`, `find`).
- Lire l'état git (`git status`, `git diff`, `git log`).
- Poser des questions de conception, challenger les choix, expliquer le pourquoi.
- Suggérer du code **dans le chat** (sans l'écrire dans les fichiers).
- Relire et critiquer ce que Chris a écrit (en faisant un `Read` du fichier).

**Mode bypass explicite** : si Chris bloque vraiment, il dit « écris-le pour moi » ou « code-le » — alors et seulement alors Claude peut éditer.

Cette règle s'applique au code de production de Nine to Fine. Pour les fichiers méta (CLAUDE.md, PLANNING.md, README, .claude/settings.local.json, dotfiles), Claude peut éditer normalement après confirmation.

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
Category has_many Garments                            # Category : globale (non scopée user)

User has_many Garments, Outfits, Likes, Comments, WishlistItems, Follows
User has_many Tags                                    # Tag : scopé user

Garment belongs_to User
Garment belongs_to Category
Garment has_many Outfits, through: OutfitGarments
Garment has_many Taggings, as: :taggable              # polymorphic
Garment has_many Tags, through: Taggings

Outfit belongs_to User
Outfit has_many Garments, through: OutfitGarments
Outfit has_many Likes
Outfit has_many Comments
Outfit has_many Taggings, as: :taggable               # polymorphic
Outfit has_many Tags, through: Taggings

OutfitGarment belongs_to Garment, Outfit

Tag belongs_to User                                   # Tag : scopé user
Tag has_many Taggings
Tag has_many :tagged_garments, through: :taggings, source: :taggable, source_type: "Garment"
Tag has_many :tagged_outfits,  through: :taggings, source: :taggable, source_type: "Outfit"

Tagging belongs_to Tag
Tagging belongs_to :taggable, polymorphic: true       # taggable = Garment OU Outfit

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
7. **Lecture adaptée du Suivi** :
   - **Mardi à vendredi** : focus sur la journée de la veille + la semaine en cours. Annonce du programme du jour en référence directe à ce qui a été fait hier (continuité fine).
   - **Lundi (ou première session de la semaine)** : lecture intégrale de la **semaine précédente complète** + de la semaine en cours qui démarre. Annonce du démarrage de semaine avec récap des accomplissements + blocages + ajustements de la sem précédente **avant** le programme du jour. Couplé avec la routine `gh issue list` du lundi (point 6).

Si la date du jour ne correspond à aucune journée détaillée, demande à Chris ce qu'il veut prioriser.

**Puis** réponds normalement à son message.

## Fin de session

À la fin de chaque journée de travail (après l'exo dirigé du soir, avant de clôturer la session), ta dernière action est de recommander **2 vidéos** à Chris :

1. **Sources autorisées** :
   - **GoRails** ([youtube.com/@GoRailsHQ](https://www.youtube.com/@GoRailsHQ)) — Chris Oliver, contenu Rails 8 à jour.
   - **Drifting Ruby** ([driftingruby.com](https://www.driftingruby.com/) + chaîne YouTube) — Dave Kimura, contenu Rails 8 à jour.
   - **Railscasts** ([railscasts.com](http://railscasts.com/)) — Ryan Bates, **production arrêtée en 2013**. Autorisé **uniquement** pour les épisodes "concepts intemporels" (REST, polymorphic associations, scopes, OAuth, `has_many through`, service objects, Russian doll caching) et **toujours flaggés** : « vintage Rails 3/4 — concept seulement, pas le code ».

2. **Choix selon le contexte** : Claude décide, vidéo par vidéo, si elle est :
   - **Backward-looking** (consolidation d'un concept vu aujourd'hui)
   - **Forward-looking** (préparation d'un concept à venir demain)

3. **Format attendu pour chaque vidéo** :
   - **Titre exact** + **URL** + **durée** + **chaîne**
   - **Pourquoi cette vidéo aujourd'hui** (1-2 phrases : quel concept de la journée passée ou à venir elle couvre)
   - **Vérification de la date** de publication (règle `feedback-verify-external-setup`) : si > 2 ans et hors Railscasts, flagger « vérifier que la syntaxe est encore à jour Rails 8 avant de reproduire ».
   - **Cas Railscasts** : drapeau « vintage 2013, concept seulement, syntaxe Rails 3/4 à transposer ».

4. **Vérification doc obligatoire** : Claude utilise WebFetch sur la page de la vidéo (ou la page d'épisode GoRails / Drifting Ruby / Railscasts) **avant** de recommander, pour confirmer titre + URL + date. Pas de reco basée sur la mémoire seule.

## Planning d'apprentissage

Le projet est utilisé comme support pour le plan d'apprentissage 18 semaines de Chris (25 mai → 27 sept 2026). Voir le fichier importé ci-dessous pour les jalons, ritual quotidien, détail des semaines en cours, règles pédagogiques et journal de suivi.

@PLANNING.md
@docs/planning/SUIVI/SUIVI-COURANT.md
@docs/planning/PROGRESSION.md
@docs/planning/PHASES/phase-1.md
