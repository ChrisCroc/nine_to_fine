# Nine to Fine — Notes

## Features core
- Upload de vêtements en photo
- Liste de tous les vêtements
- Accès par catégorie et par style
- Créer des outfits et les classer par style
- Commenter et liker les tenues publiques
- Wishlist de vêtements via URL externe
- Suggestions IA de tenues et de pièces manquantes
- Adaptation météo pour les suggestions
- Profils publics et suivi d'autres users

## Models principaux

User has_many Garments
User has_many Outfits
User has_many Likes
User has_many Comments
User has_many WishlistItems

Garment belongs_to User
Garment has_many OutfitGarments
Garment has_many Outfits, through: OutfitGarments

Outfit belongs_to User
Outfit has_many OutfitGarments
Outfit has_many Garments, through: OutfitGarments
Outfit has_many Likes
Outfit has_many Comments

OutfitGarment belongs_to Garment
OutfitGarment belongs_to Outfit

Like belongs_to User
Like belongs_to Outfit
Comment belongs_to User
Comment belongs_to Outfit
WishlistItem belongs_to User

## État Nine to Fine — 26 mai 2026

### ✅ Fait aujourd'hui
- Conception complète : user stories (24), schéma DB, kanban GitHub, roadmap
- Devise installé et configuré (username, email, password)
- Model User avec validation username
- ApplicationController : authenticate_user! + configure_permitted_parameters
- PagesController : home publique (skip_before_action)
- Navbar : user_signed_in?, current_user.username, login/logout/signup
- Flashes : _flashes.html.erb
- Devise views générées + champ username ajouté dans sign up
- db:create + db:migrate OK
- Push GitHub : commit "feat: setup devise with username, navbar, flashes and auth protection"

### ⬜ À faire demain
- Créer les models dans cet ordre :
  1. Category
  2. Garment (dépend de Category + User)
  3. Outfit (dépend de User)
  4. OutfitGarment (dépend de Garment + Outfit)
  5. Tag
  6. Tagging
  7. Like (dépend de User + Outfit)
  8. Comment (dépend de User + Outfit)
  9. Follow (dépend de User)
  10. AiSuggestion (dépend de User + Outfit)
- Créer les controllers et vues CRUD pour Garment
- Tester le flow complet en local
