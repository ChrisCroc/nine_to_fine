# Features Futures — Nine to Fine

Backlog des features sorties du scope v1 mi-juillet, à réintégrer post-emploi (oct 2026+) ou au gré des opportunités.

Chaque feature documente : **contexte d'origine** (quand/pourquoi sortie), **description** précise, **stack** technique impliquée, **estimation**, **slot suggéré** de réintégration.

## Priorité haute

### Drag-and-drop composition outfit

- **Contexte d'origine** : sortie samedi 30 mai 2026 (refonte stratégique Phase 4, Q4b). Marquée "essentielle à terme" par Chris.
- **Description** : sur la page de composition d'un outfit, permettre de glisser-déposer des garments depuis la liste latérale vers la zone "tenue en cours de composition". Réordonner par drag dans la zone. Sauvegarde implicite à chaque drop.
- **Stack** : Stimulus controller `outfit_composer_controller.js` + bibliothèque `Sortable.js` (importmap) ou alternative native HTML5 drag-and-drop API. Persistance via PATCH AJAX vers `OutfitGarmentsController`.
- **Estimation** : 2-3 j (Stimulus + Sortable.js + UX + tests système Capybara).
- **Slot suggéré** : Phase 4 sem 38-39 si escalade Standard (cf. règle 3), sinon post-emploi (oct 2026+).

### Sélection des garments par clic dans l'index (remplace Tom Select)

- **Contexte d'origine** : mercredi 3 juin 2026, session design des vues Outfit. Tom Select (combobox) reste viable tant qu'on a peu de garments, mais devient inviable à ~100 pièces (sélection laborieuse dans un dropdown, aggravée par des noms saisis sans rigueur).
- **Description** : pour composer un outfit, l'utilisateur arrive sur l'**index des garments** et **clique les pièces** à ajouter (toggle visuel sur les cards), au lieu du dropdown Tom Select. Suppose un index filtrable (cf. entrée ci-dessous + filtres sem 24).
- **Stack** : Stimulus controller de sélection multi-items + état de sélection persistant (hidden inputs `garment_ids[]` ou session) + flow d'ajout vers `OutfitGarmentsController`. Possiblement Turbo Frames pour embarquer l'index.
- **Estimation** : 2-3 j.
- **Slot suggéré** : post-emploi (oct 2026+), **après** l'index filtrable.

### Tags cliquables → index filtré par tag

- **Statut** : ✅ **LIVRÉ partiel côté garments (lundi 8 juin 2026, PR #83)**. Pills tags dans `shared/_tags` deviennent `link_to garments_path(q: { tag_id: tag.id })` avec hover, navigation pleine page vers index garments filtré par tag (passe par `GarmentFilter` PR #79). Pill tag s'affiche active dans le bandeau de filtres au retour.
- **Reste à faire (extension)** : la vision originale prévoyait **deux sections** (Garments + Outfits côté à côté). On a livré garments uniquement. Pour ajouter les outfits filtrés par tag, il faut : (a) un `OutfitFilter` Query Object miroir de `GarmentFilter` (ou un parent commun `BaseFilter`), (b) une page dédiée `TagsController#show` qui liste les deux ou un toggle, (c) UX choix entre redirect vers garments/outfits.
- **Stack restante** : `OutfitFilter` + route `TagsController#show` ou rester sur la mécanique actuelle (les pills tag depuis show outfit vont sur l'index garments — comportement V1 qui peut suffire).
- **Estimation restante** : ~1-1.5 j.
- **Slot suggéré** : sem 25-26 (avec features sociales — like/follow s'inscriront dans la même session).

### Prévisualisation live de la photo à la sélection (new + edit)

- **Contexte d'origine** : jeudi 4 juin 2026, session tags. Marquée "à faire rapidement" par Chris. Actuellement (`garments/_form`), la vignette ne s'affiche que si une photo est déjà attachée et persistée (`photo.blob&.persisted?`) → visible en `edit` uniquement. En `new`, aucun aperçu du fichier choisi avant submit.
- **Description** : afficher une **vignette live** de l'image sélectionnée dès que l'utilisateur choisit un fichier, **aussi bien en création qu'en édition**, sans attendre l'upload. Remplace/complète la vignette serveur actuelle.
- **Stack** : Stimulus controller (`photo_preview_controller.js`) lisant le `change` du `file_field` + `URL.createObjectURL(file)` (ou `FileReader`) pour générer l'URL locale + `<img>` cible mis à jour côté client. Penser à `URL.revokeObjectURL` pour ne pas fuiter la mémoire. Recoupe le backlog "file_field perd la sélection après erreur" (to-do.md, 2 juin).
- **Estimation** : ~0.5 j (un seul Stimulus controller, pas de back).
- **Slot suggéré** : proche (sem 24-25), bon exercice Stimulus autonome.

## Priorité moyenne

### Index garments organisé (onglets catégorie / couleur)

- **Statut** : ✅ **Base LIVRÉE (lundi 8 juin 2026, PR #79 + #83)** sous forme de bandeau de pills filtres combinables AND (Color / Category / Brand / Tag) avec Turbo Frame. Recherche par nom encore à venir (mardi 9 juin matin sem 24).
- **Reste à faire (enrichissement)** : passer du bandeau de pills à une **présentation par onglets** (Category en onglet principal, sous-pills color/brand/tag), si l'index grandit au-delà de ~50 garments et que le bandeau de pills devient surchargé. Sert aussi de **socle** à la sélection par clic dans l'index pour composer un outfit (entrée ci-dessus).
- **Stack restante** : refactor UI vers `<nav>` à onglets (probablement via Stimulus controller `tabs_controller.js` pour le switch), enrichissement progressif au besoin.
- **Estimation restante** : ~1 j.
- **Slot suggéré** : post-emploi (déclencheur = nombre de garments).

### Autocomplete Stimulus sur input tags

- **Contexte d'origine** : sortie samedi 30 mai 2026 (brainstorming Q1). V1 utilise input texte "comma-separated" (UX éprouvée Gmail/GitHub/StackOverflow). Autocomplete = polish ultérieur.
- **Description** : suggestions de tags existants pendant la saisie, avec filtrage live et création-on-the-fly si tag inconnu.
- **Stack** : Stimulus controller `tags_input_controller.js` + endpoint JSON `tags#autocomplete?q=...` + scope Rails sur tags du user.
- **Estimation** : 1.5-2 j.
- **Slot suggéré** : post-emploi ou Phase 4 si scope ambitieux escaladé.

### Combinaison de filtres (couleur ET tag ET category)

- **Statut** : ✅ **LIVRÉ côté garments (lundi 8 juin 2026, PR #79 + #81 + #83)**. Pivot design pris dès le brainstorming (Zalando/Uniqlo l'imposent). Implémentation via `GarmentFilter` Query Object avec pipeline `inject` + dispatch dynamique `send("by_#{key}")` — pattern Open/Closed prouvé en live (ajout proactif du 4e filtre `brand`, zéro modif sur `apply`/`results`). 10 tests Minitest. Front pills cliquables dans bandeau Turbo Frame.
- **Reste à faire (extension outfits)** : équivalent `OutfitFilter`. Recouvre l'entrée "Tags cliquables → index filtré par tag" ci-dessus.
- **Estimation restante** : ~1 j si refactor parent `BaseFilter` au passage.
- **Slot suggéré** : sem 25-26 avec features sociales / index outfits.

### Multi-color par garment

- **Contexte d'origine** : lundi 8 juin 2026 (sem 24), session normalisation des couleurs en préparation de PR #83. En passant la colonne `color` à une liste fermée (`Garment::COLORS`, 12 couleurs), Chris a découvert un garment bi-color dans ses données dev : `"light grey & purple"`. La structure actuelle (string `color` unique) ne peut représenter qu'une seule couleur. V1 normalisé arbitrairement vers `grey` (perte d'information).
- **Description** : permettre à chaque `Garment` d'avoir **plusieurs couleurs** (couleur dominante + couleurs secondaires, ou liste plate). Le `GarmentFilter#by_color` devra passer de "equals" à "contains" (`WHERE 'red' = ANY(colors)` en Postgres ou jointure si table dédiée).
- **Stack** : 2 options.
  - **Postgres `string[]` array** sur la colonne `colors` (Rails 8 supporte nativement avec serializer auto + `.where("? = ANY(colors)", val)`) — léger, pas de table en plus. Migration : `add_column :garments, :colors, :string, array: true, default: []` + retirer `color`. Form : `collection_check_boxes` ou pills cliquables Stimulus pour sélection multiple.
  - **Table `garment_colors`** (1:N) + model dédié + association `has_many :colors, class_name: 'GarmentColor'` — plus lourd mais permet d'attacher des attributs aux couleurs (intensité, ordre, pastilles hex).
- **Estimation** : 0.5-1 j (option Postgres array recommandée pour simplicité).
- **Slot suggéré** : post-emploi (faible bénéfice utilisateur immédiat).

### Normalisation `brand` au save (callback)

- **Contexte d'origine** : lundi 8 juin 2026 (sem 24), session front pills PR #83. La pill "Brand" est déduite de `current_user.garments.distinct.pluck(:brand)`. Une liste fermée des marques mondiales étant intenable, la défense contre la pollution (saisie libre type "Uniqlo"/"uniqlo"/"UNIQLO"/"Uniqlo " avec espace en trop) doit se faire **à la saisie**, pas au filtre.
- **Description** : callback `before_save :normalize_brand` dans `Garment` qui applique `.strip.titleize` à `brand` à chaque save. Force la cohérence côté DB. Risque : `titleize` produit des résultats étranges sur certaines marques (`"a.p.c."` → `"A.P.C."` OK, mais `"levi's"` → `"Levi's"` OK aussi — à valider sur cas réels).
- **Stack** : ActiveRecord callback + tests Minitest pour vérifier l'invariant (saisir "  uniqlo  " → "Uniqlo" en DB). Optionnel : audit des données existantes (`Garment.distinct.pluck(:brand)`) pour normaliser le legacy via `Garment.find_each { |g| g.update(brand: g.brand) }` après ajout du callback.
- **Estimation** : ~1h (10 min code + tests + vérification données dev).
- **Slot suggéré** : sem 24-25, faible coût. À traiter avant que la pollution `brand` ne devienne visible dans les pills filtres.

### Ransack ou équivalent (recherche full-text)

- **Contexte d'origine** : sortie Q1. V1 = recherche par nom uniquement via scope simple.
- **Description** : recherche full-text avec gem Ransack ou pg_search sur name + brand + description.
- **Stack** : gem `ransack` ou `pg_search` + UI search bar avancée.
- **Estimation** : 2 j.
- **Slot suggéré** : post-emploi.

### Refactor partiel modèle (à identifier post-v1)

- **Contexte d'origine** : sortie Q4b. Si après v1 un modèle s'avère mal posé (typiquement Outfit ou Tagging), refactoring.
- **Description** : à préciser quand le problème se révèle. Pas de scope défini par défaut.
- **Stack** : variable.
- **Estimation** : variable.
- **Slot suggéré** : post-emploi.

### Audit perf + Solid_cache + Bullet + indexes

- **Contexte d'origine** : sortie Q4b. Scope "Standard" Phase 4 si on a le temps (règle 3 d'adaptabilité).
- **Description** : ajout gem `bullet` (groupe development) pour détection N+1, configuration `Solid_cache` pour cache fragment sur home/index, audit des indexes manquants sur les jointures fréquentes.
- **Stack** : gem `bullet` + Solid_cache (déjà dans Gemfile Rails 8) + `add_index` migrations.
- **Estimation** : 2-3 j cumulés.
- **Slot suggéré** : Phase 4 Standard escalation (fin sem 37 si conditions règle 3 remplies) ou post-emploi.

## Priorité basse

_(à compléter au fil du temps quand de nouvelles idées émergent)_
