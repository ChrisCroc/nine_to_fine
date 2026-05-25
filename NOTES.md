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
