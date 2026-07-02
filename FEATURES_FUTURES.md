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

### Profil public riche + outfits publics + gating par follow (US18 — brief)

- **Contexte d'origine** : jeudi 18 juin 2026 (sem 25), brainstorm de la feature Follow (`docs/superpowers/specs/2026-06-18-follow-design.md`). En posant la primitive `Follow`, Chris a décrit sa vision complète du profil public. Elle dépend **entièrement** de la notion **public/privé** des outfits (US18), délibérément reportée sem 26+ le lundi 15 (« brainstorm produit dédié requis sur la sémantique public »). On a livré aujourd'hui **uniquement la primitive invariante** (Follow + profil nu : username + compteurs + bouton) pour ne produire que du code qui survit à la décision US18.
- **Vision produit à trancher au brainstorm** (exemple concret donné par Chris) : *« je cherche de l'inspi pour mes tenues de travail, je vais sur le profil de Jean que je suis (obligé de suivre pour voir son contenu), je clique sur son tag "work" et j'ai l'index de ses tenues taggées work — seulement celles qu'il a rendues publiques »*.
- **Sous-décisions à prendre (chacune porte du design)** :
  1. **Sémantique « public »** : `is_public:boolean` par-outfit ? Visibilité par défaut (privé ou public) ? Notion de feed / URL directe partageable ?
  2. **Gating par follow** : faut-il **suivre** un user pour voir son contenu ? (profil privé type Instagram privé). Si oui : le profil nu reste-t-il visible (nom + compteurs) mais le contenu masqué tant qu'on ne follow pas ? Follow **instantané** (V1 actuel) ou **par approbation** (colonne `status` pending/accepted, additive sur `Follow`) ?
  3. **Listing du contenu** : grille des outfits publics sur le profil → extraire des partials card réutilisables (`outfits/_outfit`, `garments/_garment`) depuis les index actuels (markup inline aujourd'hui) pour DRY index + profil.
  4. **Navigation par tag publique** : depuis le profil, cliquer un tag → index des outfits **publics** de CE user taggés ainsi → `OutfitFilter` Query Object (miroir de `GarmentFilter`) scopé `public + user` (recoupe l'entrée « Tags cliquables → index filtré par tag »).
  5. **Photo de profil** : avatar Active Storage sur `User` (recoupe US04 édition profil).
  6. **US04 édition profil** : `UsersController#edit/update` scopé `current_user` (sentinel IDOR) — username + futurs bio/avatar.
- **Stack** : migration `is_public` sur Outfit + scope `Outfit.public_outfits` + `OutfitFilter` + `UsersController` enrichi (show gated + edit/update) + extraction partials card + `has_one_attached :avatar` sur User + éventuelle colonne `Follow#status`.
- **Estimation** : 3-5 j (le brainstorm produit US18 d'abord, puis l'implémentation par sous-briques).
- **Slot suggéré** : sem 26+ (brainstorm produit dédié US18), avant l'implémentation. **Ne rien coder de ce bloc avant le brainstorm** (sinon rework garanti).

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

### Full-text search (`pg_search`)

- **Contexte d'origine** : sortie Q1, **confirmée mardi 9 juin 2026 (sem 24)** lors de la livraison de la barre de recherche `name` simple via `GarmentFilter#by_search` (`ILIKE` + `sanitize_sql_like` + debounce Stimulus 300ms). La V1 cherche **uniquement** dans la colonne `name`. Discussion explicite avec Chris : la recherche multi-colonnes naïve (`name OR color OR brand OR description`) est rejetée pour ambiguïté UX (taper "blue" mélangerait pièces nommées "Blue dress" et toutes les pièces de couleur bleue). Option retenue = full-text search dédié.
- **Description** : recherche full-text **multi-colonnes intelligente** sur `name + brand + description` (et plus tard `tags.name` via association). Stemming (chercher "courir" matche "course"), normalisation accents (chercher "veste" matche "véste"), ranking par pertinence. Garde la barre dédiée à `name` ET ajoute soit une 2e barre "search all" soit un toggle UX.
- **Stack** : gem `pg_search` (recommandée vs Ransack pour ce besoin). Concern `PgSearch::Model` dans `Garment` + déclaration `pg_search_scope :search_all, against: [:name, :brand, :description], using: { tsearch: { prefix: true, dictionary: "french" } }`. Migration pour ajouter un index GIN sur `tsvector` généré ou colonne dérivée. Côté UI : extension du `GarmentFilter` avec une clé `:search_all` distincte de `:search`.
- **Estimation** : 1.5-2 j (gem + index + UI + tests + tuning dictionary FR vs EN).
- **Slot suggéré** : post-emploi (oct 2026+). Pas bloquant pour la V1 mi-juillet : la barre `name` simple couvre 80% des usages d'une garde-robe perso.

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

### `SuggestionsController` dédié dès V1 + futur model `Suggestion` persisté (pattern "verbe → nom")

> ⚠️ **Partiellement révisé par le brainstorm du 2 juillet 2026** (`docs/superpowers/specs/2026-07-02-ia-outfit-suggester-design.md`, voir la section IA suggester ci-dessous). La V1 est codée **maintenant** (jalon « avant mi-juillet », décision 30 juin), en **`SuggestionsController` top-level** (`resources :suggestions` — **pas** nested sous Outfit, le mode « composer » ne part d'aucun outfit) et avec **tool use structuré** (pas de marqueur texte `SELECTED:`). Le **model `Suggestion` persisté** décrit ci-dessous reste backlog inchangé.

- **Contexte d'origine** : jeudi 11 juin 2026 (sem 24), lecture profonde Odin chap. 40 Advanced Topics, Section 2 (Controllers, Models & REST Principles). En décortiquant la suggestion IA Phase 4, application directe du pattern "verbe → nom" (un verbe qui mérite ≥ 2 actions ou qui mérite plus tard de devenir un model → controller dédié dès aujourd'hui).
- **Description** : au lieu d'ajouter une action `member do post :suggest_completions end` à `OutfitsController` (qui gonflerait le controller pour chaque évolution future), créer **dès V1 Phase 4** un `SuggestionsController` nested sous Outfit :
  ```ruby
  resources :outfits do
    resources :suggestions, only: [:create]   # V1 : stateless, juste create
  end
  ```
  V1 (Phase 4 sem 36-37) : `#create` appelle `Ai::OutfitSuggester.new(@outfit).suggest`, renvoie 3 suggestions stateless (rien persisté en DB). **Aucun model `Suggestion` à ce stade**, juste un controller qui orchestre un service.
- **Évolution future probable** (~6 mois post-déploiement, post-emploi) : `Suggestion` devient un **VRAI model persisté** pour adresser 5 besoins distincts qui apparaîtront avec l'usage réel :
  1. **Tracking historique** : "Quelles suggestions ont été générées pour cet outfit ?" (audit + UX retour utilisateur)
  2. **Feedback user** : "Garde / Rejette" sur chaque suggestion → boucle d'apprentissage (data pour fine-tuning prompt + signal IA portfolio)
  3. **Économie d'API** : cache des suggestions récentes (< 1h) au lieu de re-payer un appel Anthropic ($$$ à l'échelle)
  4. **Audit / debug** : stocker le prompt envoyé + la réponse brute JSON pour debugger les hallucinations IA et reprouver
  5. **Analytics portfolio** : "% de suggestions acceptées finissant en outfit publié" → metric IA quantifiable pour entretien junior dev IA-augmenté
- **Quand le model arrive** : `rails g model Suggestion outfit:references user:references prompt:text response:jsonb status:integer`, et le `SuggestionsController` existant **n'a qu'à étendre** ses actions (`index` historique pour un outfit, `show` détail debug, `update` pour feedback). **Zéro refactor** côté `OutfitsController` (qui n'a jamais été touché) ni côté `routes.rb`. C'est exactement ce que la section 2.6 Odin appelle "Skinny Controllers, Fat Resources".
- **Stack V1** : `SuggestionsController` + `Ai::OutfitSuggester` service object (déjà décidé dans CLAUDE.md projet) + gem officielle `anthropic-sdk-ruby` + credentials chiffrées `credentials.yml.enc`.
- **Stack post-V1** : migration `create_suggestions`, association `Outfit has_many :suggestions`, scope `Suggestion.recent`, enum `status: { pending: 0, accepted: 1, rejected: 2 }`, refactor `OutfitSuggester` pour qu'il `.create!` au lieu de retourner un hash en mémoire.
- **Estimation V1** : intégrée à l'estimation Phase 4 IA suggester (~3-4 j déjà au plan). Cette entrée ne crée **pas** de charge V1 supplémentaire, c'est juste la **bonne architecture** à appliquer dès le départ.
- **Estimation extension model** : ~1-1.5 j (migration + model + extension controller + tests).
- **Slot suggéré** : V1 contrôleur dès **Phase 4 sem 36-37** (intégré au plan existant), extension model **post-emploi (oct 2026+)** quand le tracking + feedback + cache deviennent prioritaires.

### IA Outfit Suggester — évolutions post-V1 (brainstorm 2 juillet 2026)

- **Contexte d'origine** : jeudi 2 juillet 2026 (sem 27), brainstorm produit de l'IA suggester (`docs/superpowers/specs/2026-07-02-ia-outfit-suggester-design.md`). La V1 (2 modes composer + ancre, garde-robe entière dans le prompt, 1 suggestion + régénérer, stateless, tool use, typewriter client) est en cours. Les items ci-dessous ont été délibérément sortis du scope V1.
- ⭐ **RAG connaissance mode (`pgvector`)** — *priorité haute / near-term* (voulu vite par Chris). Base de connaissances style **externe** (règles d'association de couleurs, guides de style, tendances) → embeddings + recherche vectorielle **`pgvector` sur le Postgres existant** (zéro nouvelle infra) → retrieval injecté dans le prompt. Comble le trou « tendances post-cutoff » du LLM et réduit l'hallucination. ⚠️ Le RAG **n'est pas** sur la garde-robe (petite → tient dans le contexte ; RAG dessus = cargo cult), il est sur le savoir mode. Stack : `pgvector` + ingestion d'un corpus mode + génération d'embeddings + retrieval. Estimation : ~2-3 j. Slot : near-term.
- **Multi-suggestion** (plusieurs tenues d'un coup au choix). Au lieu d'une suggestion → le form, l'IA en propose 2-3, l'user en choisit une → pré-remplissage. Impact : affichage multi-cartes dans la modale + un bouton « Créer » par carte + prompt demandant N variantes. Estimation : ~1 j. Slot : post-V1 proche.
- **Mode « Que porter aujourd'hui ? »** — suggestion globale non liée à une création d'outfit (« tenue du jour » selon occasion/météo, façon dashboard), 3e mode annoncé au brainstorm. Estimation : ~1 j. Slot : post-V1.
- **Mode shopping (pièces à acheter hors garde-robe)** — l'IA suggère des vêtements **à acquérir** pour compléter la garde-robe (vs piocher dedans). Mode fondamentalement différent : la sortie n'est plus des `garment_ids` existants mais des descriptions/pistes d'achat (jamais persistées comme outfit). Estimation : 1-2 j. Slot : post-emploi. Croise une éventuelle marketplace/wishlist.
- **API météo auto-injectée** — géoloc navigateur + service météo tiers → météo réelle injectée dans le prompt (vs l'user qui la tape en texte libre en V1). Résout « été à 13°C ≠ habillé été ». Stack : Geolocation API + API météo (clé, quota, cache) + gestion permission/erreur. Estimation : ~1 j. Slot : post-V1.
- **Vrai token streaming SSE + Redis** — consommer le flux SSE d'Anthropic (`stream: true`) et le rediffuser en temps réel via Turbo Streams. ⚠️ Nécessite **Redis** comme backend Action Cable : Solid Cable est DB-backed et martèlerait la DB à haute fréquence. Remplace le typewriter client de la V1 par du vrai streaming. Bon signal entretien (SSE + Redis + Turbo Streams) — Redis ajouté **parce que le streaming l'exige** (pas cargo cult). Estimation : 1-2 j + provisioning Redis. Slot : post-V1.
- **Mode ancre depuis le form en cours** (injection live) — en plus du déclencheur depuis l'index vêtements (V1), déclencher « Compléter avec l'IA » depuis un form outfit déjà ouvert, avec **injection en direct** des pièces suggérées dans le Tom Select courant (vs pré-remplissage d'un nouveau form). Plus lourd (manipuler l'état interne de Tom Select en JS au retour du broadcast). Estimation : ~0.5-1 j. Slot : post-V1.
- **Rate limiting API par user** — throttle des appels IA (au-delà du bouton désactivé pendant le job en V1) pour maîtriser les coûts à l'échelle. Stack : `rack-attack` ou throttle maison. Estimation : ~0.5 j. Slot : selon usage réel.
- **Model `Suggestion` persisté** : voir la section précédente (tracking / feedback / cache / audit / analytics) — inchangé.

### Sidebar filtres togglable (remplace le bandeau de pills horizontal)

- **Contexte d'origine** : mardi 9 juin 2026 (sem 24), suite à la livraison de la barre de recherche `name`. Chris a explicitement qualifié le bandeau de pills horizontal actuel (PR #83, lignes 38-86 de `index.html.erb`) d'"horrible" et veut basculer vers une **sidebar verticale togglable** type Zalando/Asos/Uniqlo. La V1 reste sur les pills (cohérent fonctionnellement, suffisant pour le démontrer en entretien), refonte UI sortie de scope V1 mi-juillet.
- **Description** : refondre l'UI de filtrage de l'index garments (et plus tard outfits) en **sidebar latérale gauche** (desktop) ou **drawer bottom-up** (mobile), togglable via un bouton "Filtres" en en-tête. Sections collapsibles dans la sidebar (Couleur / Catégorie / Marque / Tag / Recherche). Compteur de filtres actifs visible sur le bouton toggle. Mémorisation de l'état ouvert/fermé en `localStorage`. Pas de rechargement de page à l'ouverture/fermeture.
- **Stack** : Stimulus controller `filters_sidebar_controller.js` (toggle + state localStorage + sections collapsibles via targets/values) + refonte Tailwind (transitions slide-in/out, `motion-safe:` obligatoire — cf. note [[transitions-and-animations-fundamentals]]) + Turbo Frame intacte sur la grille (la sidebar reste statique entre les submits, comme l'input search dehors de la frame). Conservation de la mécanique back inchangée (`GarmentFilter` + URL `?q[...]` + hidden inputs propagés depuis la sidebar). Recouvre fortement l'entrée "Index garments organisé (onglets catégorie / couleur)" ci-dessus — à fusionner au moment de l'implémentation pour trancher entre "onglets horizontaux" et "sidebar verticale" (probablement sidebar = winner).
- **Estimation** : 2-3 j (Stimulus + UI Tailwind + responsive + accessibilité + tests système).
- **Slot suggéré** : post-emploi (oct 2026+). Bonne occasion pour consolider Stimulus avancé (multi-targets + values + localStorage) et Tailwind avancé (transitions + responsive variants).

### Édition inline des commentaires (action `update`)

- **Contexte d'origine** : mardi 16 juin 2026 (sem 25), brainstorm de la feature commentaires (`docs/superpowers/specs/2026-06-16-comments-design.md`). V1 livre **create + destroy** seulement (décision tranchée) ; Chris a noté l'édition comme évolution **certaine**.
- **Description** : éditer son propre commentaire **en place** (inline). Un form d'édition remplace l'affichage du commentaire ; action `update` scopée `current_user.comments.find` ; broadcast `replace` du commentaire édité (sur son `dom_id`). Indicateur « edited » optionnel.
- **Stack** : route `:update` nested + action `CommentsController#update` + toggle/form inline (Stimulus ou turbo_stream `replace` vers un `_edit_form`) + `after_update_commit { broadcast_replace_to }` + request spec + sentinel IDOR sur `update`.
- **Estimation** : ~0.5-1 j.
- **Slot suggéré** : post-emploi (oct 2026+), ou sem 26+ si polish social prioritaire.

## Priorité basse

### Gestion gracieuse de `RecordNotFound` (UX back-button sur ressource supprimée)

- **Contexte d'origine** : mardi 16 juin 2026 (sem 25), pendant l'implémentation des commentaires. Constaté : supprimer un outfit redirige bien vers l'index, mais cliquer "back" navigateur recharge `/outfits/:id` (supprimé) → `current_user.outfits.find` (`OutfitsController#show`) → `RecordNotFound` → 404. En dev = page d'exception verbeuse (artefact `consider_all_requests_local`) ; en prod = `public/404.html` statique (acceptable, beaucoup moins alarmant).
- **Description** : lisser l'UX du 404 sur ressource introuvable / supprimée. Deux pistes : (a) **personnaliser `public/404.html`** à la charte (statique, zéro risque, à faire en premier) ; (b) **`rescue_from ActiveRecord::RecordNotFound`** dans `ApplicationController` → redirection vers l'index avec flash ("Cette tenue n'existe plus").
- **⚠️ Trade-off central** : l'option (b) est **transverse** et **change le pattern IDOR**. `RecordNotFound` ne distingue pas "supprimée" de "pas à toi" (les deux passent par `current_user.X.find`). Un rescue global transformerait **tous** les sentinels IDOR de 404 → redirection (garments / outfits / likes / comments). Sécurité équivalente (une redirection + flash générique ne fuite pas plus qu'un 404), mais oblige à réécrire ces specs (`:not_found` → `redirect_to`). Décision à prendre consciemment, pas par accident.
- **Stack** : `public/404.html` (option a) ; ou `rescue_from` + handler `record_not_found` dans `ApplicationController` + réécriture des request specs IDOR (option b).
- **Estimation** : option (a) ~0.5h (quick win) ; option (b) ~1-1.5 j (rescue + flash + réécriture de toutes les specs IDOR + revalidation sécurité).
- **Slot suggéré** : post-emploi (oct 2026+). Option (a) faisable à tout moment ; option (b) seulement si décision tranchée de migrer le pattern IDOR de 404 vers redirect.

### Bouton Delete des commentaires en temps réel (sans reload)

- **Contexte d'origine** : mardi 16 juin 2026 (sem 25), implémentation commentaires temps réel (Task 3 du plan commentaires). Le broadcast rend `_comment` **hors requête** → pas de `current_user` → `viewer_id` nil → le bouton Delete n'apparaît qu'au **reload** (trade-off V1 « Option A » accepté).
- **Description** : afficher le bouton Delete **en live**, même sur l'insertion broadcast, sans recharger.
- **Stack (Option B)** : rendre le bouton **toujours** dans le HTML mais **masqué** par défaut + `<meta name="current-user-id" content="<%= current_user&.id %>">` dans le layout + Stimulus `comment_controller` comparant le `data-user-id` du commentaire à l'id du meta et révélant le bouton si match (décision **côté client** → pas besoin de `current_user` serveur dans le broadcast).
- **Estimation** : ~0.5 j.
- **Slot suggéré** : post-emploi, couplable avec l'édition inline ci-dessus.
