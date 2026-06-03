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

## Priorité moyenne

### Index garments organisé (onglets catégorie / couleur)

- **Contexte d'origine** : mercredi 3 juin 2026, même session design Outfit. Besoin de retrouver vite une pièce dans un grand index.
- **Description** : index rangé avec **onglets/filtres** par catégorie, couleur, etc. NB : la **base** (filtres `link_to` un-à-la-fois + recherche par nom) est **déjà planifiée sem 24** ; la combinaison multi-filtres est déjà tracée plus bas ("Combinaison de filtres"). Le surplus *future* = présentation en onglets + sert de **socle** à la sélection par clic (entrée ci-dessus).
- **Stack** : couvert par sem 24 + entrée "Combinaison de filtres" ; enrichissement onglets sans gem.
- **Estimation** : base sem 24 ; enrichissement onglets ~1 j.
- **Slot suggéré** : base sem 24, enrichissement post-emploi.

### Autocomplete Stimulus sur input tags

- **Contexte d'origine** : sortie samedi 30 mai 2026 (brainstorming Q1). V1 utilise input texte "comma-separated" (UX éprouvée Gmail/GitHub/StackOverflow). Autocomplete = polish ultérieur.
- **Description** : suggestions de tags existants pendant la saisie, avec filtrage live et création-on-the-fly si tag inconnu.
- **Stack** : Stimulus controller `tags_input_controller.js` + endpoint JSON `tags#autocomplete?q=...` + scope Rails sur tags du user.
- **Estimation** : 1.5-2 j.
- **Slot suggéré** : post-emploi ou Phase 4 si scope ambitieux escaladé.

### Combinaison de filtres (couleur ET tag ET category)

- **Contexte d'origine** : sortie Q1. V1 = 1 filtre à la fois via `link_to`.
- **Description** : combiner plusieurs filtres simultanément (ex : "tous mes tops bleus tagués weekend").
- **Stack** : refactor du scoping côté model (chaînage de scopes) + UI checkboxes ou pills désélectionnables. Pas de gem nécessaire.
- **Estimation** : 1-2 j.
- **Slot suggéré** : post-emploi.

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
