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

## État actuel (à mettre à jour)

Voir `NOTES.md` à la racine pour le journal de bord détaillé. Au 26 mai 2026 :
- Devise installé et configuré (username + auth protection)
- PagesController : home publique
- Navbar + flashes en place
- Models data : à créer (Garment, Outfit, etc.)

## Planning d'apprentissage

Le projet est utilisé comme support pour le plan d'apprentissage 18 semaines de Chris (25 mai → 27 sept 2026). Voir le fichier importé ci-dessous pour les jalons, ritual quotidien et règles pédagogiques.

@PLANNING.md
