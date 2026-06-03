# Design — Refonte visuelle des vues Outfit (collage adaptatif)

- **Date** : 2026-06-03 (sem 23, Phase 1)
- **Branche** : `feat/outfits-design`
- **Statut** : design validé, prêt pour plan d'implémentation

## Problème

Les vues Outfit affichent des placeholders photo morts :

- `app/views/outfits/show.html.erb:4-7` → `Photo (coming soon)`
- `app/views/outfits/index.html.erb:23-24` → `Photo`

Depuis l'ajout d'Active Storage sur `Garment` (photo + variants WebP, 2026-06-02), un Outfit peut être représenté visuellement par les photos de ses garments. Un Outfit n'a pas de photo propre : c'est une **composition de garments qui, eux, ont une photo**.

## Décisions actées

| Décision | Choix retenu | Alternatives écartées |
|---|---|---|
| Représentation visuelle | **Collage adaptatif** (flat-lay) | Hero+vignettes (hiérarchise une pièce) ; stack/éventail (cache la donnée, se bat contre les packshots `object-contain`) |
| Gestion du N variable | **Mosaïque plafonnée à 4 tuiles** + compteur `+N` | Grille complète (tuiles minuscules à N élevé, trous d'imparité) |
| Ordre des tuiles | **Par `category.position`** (déterministe) | Ordre de création (arbitraire, rendu non reproductible) |
| Architecture | **Partial unique réutilisable**, taille-agnostique | Dupliquer le markup dans show + index |

Raisons clés : le collage est le langage visuel du domaine (Polyvore/Whering) et épouse les packshots `object-contain` ; le plafond garde une densité pro et un coût de code borné ; l'ordre par catégorie est déterministe et constitue le **premier palier vers le mannequin fictif** (vision long terme, hors V1).

## Architecture

### Unité centrale : `app/views/outfits/_collage.html.erb`

Partial réutilisable, prend un `outfit` en local. Source unique de vérité du collage, consommé par `show` et `index`.

**Responsabilité** : rendre les photos des garments d'un outfit en mosaïque plafonnée.

**Contrat** :

- **Entrée** : `outfit` (local).
- **Tri** : garments ordonnés par `category.position` (Top=1, Bottom=2, Outerwear=3, Footwear=4, Accessories=5 — seed existant).
- **Plafond** : au plus 4 tuiles. Si N > 4 → 3 tuiles + une 4ᵉ tuile compteur `+N` (fond `zinc-900`, texte `champagne`), où N = nombre de garments restants non affichés.
- **Taille-agnostique** : le partial remplit son conteneur (`h-full w-full`) ; le parent fixe les dimensions. Aucun paramètre de taille passé.

**Layouts figés selon le nombre de garments (cap appliqué)** :

| N | Disposition |
|---|---|
| 1 | 1 cellule plein cadre |
| 2 | 2 cellules `grid-cols-2` |
| 3 | 2×2, 3ᵉ cellule en `col-span-2` (bas large) |
| 4 | 2×2 plein |
| ≥5 | 2×2 = 3 tuiles + tuile `+N` |

**Rendu d'une tuile** :

- Avec photo : `image_tag garment.photo.variant(...)`, `object-contain` sur fond blanc (cohérent avec `garments/show.html.erb:7`).
- Sans photo (fallback) : tuile blanche affichant l'initiale du garment (`garment.name.first`). Jamais de trou.

### `app/views/outfits/show.html.erb`

- Remplacer le placeholder (lignes 4-7), dans la zone `md:row-span-3` (~60%), par `render "collage", outfit: @outfit`.
- Colonne info inchangée (name, pill « Outfit », description, pills garments, actions).

### `app/views/outfits/index.html.erb`

- Remplacer le placeholder photo de la card (lignes 23-24) par le même partial : `render "collage", outfit: outfit`.
- **Nettoyer** le bloc `<h2>tags</h2>` codé en dur (lignes 30-32) → supprimé pour V1 (les vrais tags arrivent sem 24).

### Performance — N+1 sur `index`

La grille de l'index itère outfits → garments → photo + category. Sans eager loading : N+1 (et `bullet` est introduit cette semaine).

`OutfitsController#index` doit charger :

```ruby
@outfits = current_user.outfits.includes(garments: [ :category, { photo_attachment: :blob } ])
```

## Stratégie de test

- **Manuel (end-to-end)** : créer des outfits à 1, 2, 3, 4, 5, 7 garments → vérifier chaque layout + le compteur `+N` + le fallback initiale (garment sans photo).
- **Vérifier l'ordre** : un outfit mixant catégories doit rendre les tuiles dans l'ordre Top → Bottom → Outerwear → Footwear → Accessories.
- **N+1** : `bullet` ne doit rien signaler sur `outfits#index` une fois le `includes` en place.
- (RSpec controller/partial : reporté avec la dette RSpec globale, sem 24 — non bloquant ici.)

## Hors scope V1 (backlog)

- Mannequin fictif : vêtements assemblés par slots positionnés (rendu proche d'une silhouette réelle).
- Raffinement « 1 tuile par catégorie » quand N > 4 (au lieu des 4 plus basses positions).
- Variant Active Storage dédié plus petit pour les tuiles d'index (les tuiles sont petites ; le variant `show` est sur-dimensionné).
- Re-tune des `category.position` en vrai ordre vertical tête→pieds (nécessaire le jour du mannequin).
