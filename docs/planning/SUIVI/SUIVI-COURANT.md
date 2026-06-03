# Suivi vivant — Sem en cours + précédente

Journal de bord récent. À mettre à jour à la fin de chaque journée via la routine `/end-of-day` (à créer sem 22+).

**Politique de rolling** : ce fichier contient **la semaine en cours + la semaine précédente complète**. Début de mois (au plus tard le premier lundi du mois suivant), archivage de tout le mois précédent vers `ARCHIVE/{YYYY-MM}.md`.

**Politique de verbosité** : journal **condensé**. Les pavés techniques (pièges, concepts maîtrisés, choix de design, idiomes Rails 8, classes Tailwind) **vivent dans les notes Obsidian** (`~/Obsidian/DevJobReady/Apprentissage/`). Le Suivi les **référence par lien**, ne les duplique pas. Le backlog forward-looking (exos en attente, dettes, brainstorms reportés, chantiers coupables) vit dans `~/Obsidian/DevJobReady/to-do.md`.

**Règle de lecture au démarrage de session** :
- Mardi-vendredi : focus journée veille + sem en cours.
- Lundi (ou 1ère session de la sem) : lecture intégrale sem précédente + sem en cours qui démarre, avec récap accomplissements + blocages + ajustements de la sem précédente avant le programme du jour.

**Archives** : voir `docs/planning/SUIVI/ARCHIVE/{YYYY-MM}.md`.

---

### Sem 22 (25-31 mai 2026)

**Accompli**

- **Lundi 25 mai** — Conception complète (24 user stories, schéma DB, kanban GitHub, roadmap). Devise installé et configuré (username + email + password).

- **Mardi 26 mai** — User model + validation username. ApplicationController (`authenticate_user!` + `configure_permitted_parameters`). PagesController (home publique). Navbar + flashes + devise views. `db:create` + `db:migrate`. Push GitHub.

- **Mercredi 27 mai** — Setup environnement Claude global + projet.
  - PR #29 (fix CI), PR #30 (upgrade image_processing 1→2), PR #31-33 (migration NOTES.md → Suivi), PR #34 (config VS Code + snippets + tabCompletion), PR #35 (1re hero responsive + refactor layout + navbar stylée).
  - Vault Obsidian `DevJobReady` créée. Protection branche `main` activée. Mémoire `dotfiles-setup.md` créée.
  - Apprentissage Tailwind v4 (Installation + Styling utility classes).
  - Workflow git renforcé : Squash and merge par défaut, cycle complet branche → PR → merge → cleanup.

- **Jeudi 28 mai** — **6 models structurels livrés en mode coach** (~5h, PR #38). 7 commits atomiques. ~38 tests Minitest verts. Models : Category (global, `restrict_with_error`), Garment (color obligatoire), Outfit (name unique scopé user), OutfitGarment (jointure), Tag (scopé user), Tagging (**polymorphique** — concept neuf).
  - Matin Odin chap. 24 Active Record Queries. Avant-midi Tailwind Responsive design.
  - Notes Obsidian : [[has_many_through - class_name, foreign_key, source]], [[styling-with-utility-classes]], [[hover-focus-and-other-states]], [[responsive-design]].
  - Section "Mode coach" ajoutée au CLAUDE.md projet. Vault Obsidian restructurée (Rails 7 sous-dossiers, Tailwind 9 sous-dossiers). Split Ghostty shell + CLI configuré.
  - Exos sandbox du soir reportés → `to-do.md`.

- **Vendredi 29 mai (matinée)** — Matin Odin chap. 20 Form Basics + chap. 28 Advanced Forms. Avant-midi Tailwind v4 overview (blog v4.0 + docs CSS-first ; après vérification, pas de playlist Tailwind Labs v4 disponible).
  - Notes Obsidian : [[form-basics]], [[advanced-forms]], [[tailwind-v4-overview]].
  - PR #39 + #40 mergées (déplacement exos jeudi soir → samedi, 5 points à trancher).
  - **Décision stratégique Option D actée pour Phases 2-3-4** → détail dans `DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md`.
  - Méta-leçon : vérifier la date des ressources externes avant recommandation.

- **Vendredi 29 mai (après-midi)** — **CRUD Garment complet en mode coach strict, PR #42 mergée**. 7 routes RESTful + GarmentsController (7 actions) + 5 vues + flow testé end-to-end. Concepts manipulés : `params.expect`, `current_user.garments.find` (scoping IDOR), `:see_other` (303) sur destroy + update, `:unprocessable_content` (422) sur form invalide, `button_to ..., method: :delete`, `collection_select`, N+1 prevention via `.includes`.
  - Notes Obsidian : [[form-with-html-deconstruction]], [[scoping-current-user]], [[before-action-rerenders-pitfall]], [[belongs-to-error-key-trap]], [[turbo-status-codes-303-422]], [[debugging-workflow-pro]], [[rubocop-rails-omakase]].
  - **Dette technique** : 0 test controller écrit. Comblement RSpec rétroactif sem 24 (RSpec arrive jeudi 11-vendredi 12 juin). Voir `to-do.md`.
  - Gem `bullet` à installer début sem 23 (voir `to-do.md`).

- **Vendredi 29 mai (fin d'aprem)** — **Styling Tailwind v4 des 5 vues Garment**, PR #45. Token `@theme --color-champagne`. `_form` utility-first strict. new/edit en card centrée sur fond dégradé. show split 60/40 (`md:grid-cols-5`). index grille responsive cards cliquables hover scale. Navbar sticky. `params[:id]` → `params.expect(:id)`.
  - Note Obsidian : [[garment-crud-styling-classes-et-structure]].
  - Reports délibérés (`_field` partial DRY, upload Active Storage sem 23, pills cliquables sem 24) → `to-do.md`.

- **Samedi 30 mai (matin + début aprem)** — **Refonte stratégique Phases 2-3-4 + restructuration documentaire**, PR #49 mergée.
  - Architecture documentaire créée sous `docs/planning/` : PHASES/, SUIVI/ + ARCHIVE/, DECISIONS/, PROGRESSION.md, JALONS-EMPLOI.md. PLANNING.md slim 465 → 85 lignes. FEATURES_FUTURES.md racine créé.
  - Décisions actées : **portfolio = 3 artefacts** (Nine to Fine + Outil prep entretiens React/TS + skill `job-tracker`). **N to F v1 déployée mi-juillet sem 29** (Kamal/Hetzner). **Phase 4 = sprint enrichissement Minimal**. **Structure AA Phase 4**.
  - Détail complet : `DECISIONS/2026-05-30-refonte-strategique-phases-2-3-4.md`.

- **Samedi 30 mai (après-midi)** — Rattrapage Odin lecture profonde : chap. 17 Asset Pipeline + chap. 18 Importmaps + chap. 19 Turbo Drive.
  - Notes Obsidian : [[the-asset-pipeline]], [[importmaps]], [[turbo-drive-fundamentals]].
  - Confusions corrigées : Turbo Drive `replace` ≠ Frames. Syntaxe Ruby vs HTML keyword args (`alt:` vs `alt=`). Migration UJS → Turbo (`turbo_method:`).

- **Samedi 30 mai (fin d'aprem)** — Règle péda 11 codifiée dans PLANNING.md (note Obsidian après chaque lecture profonde), PR #50.

- **Samedi 30 mai (fin de journée)** — Brainstorm skill Claude Code `/end-of-day` **interrompu** (voir Blocages).

- **Dimanche 31 mai** — Dérogation Dimanche OFF #1/3 sur 6 sem glissantes (motif : exos sandbox décalés). **Aucun exo finalement fait**. Backlog inchangé → `to-do.md`.

**Blocages**

- **Brainstorm skill `/end-of-day` interrompu** (samedi 30 mai fin de journée) : confusion Claude entre slash command interactif vs routine planifiée nocturne générant un doc personnel SÉPARÉ du Suivi formel. À reprendre plus tard avec investigation préalable de l'onglet routine natif Claude Code par Chris. Voir `to-do.md` pour les 4 skills associés à brainstormer.

**Dérogation Dimanche OFF — compteur**

- #1 : dimanche 31 mai 2026 (sem 22). Motif : exos sandbox décalés (finalement non exécutés).
- Alerte si ≥ 3 dérogations en 6 sem glissantes → signal de surcharge → revoir le rythme.

---

### Sem 23 (1-7 juin 2026)

**Accompli**

- **Lundi 1er juin (matin, Claude app)** — Odin chap. 22 Sessions, Cookies and Authentication. 5 Knowledge Check répondus par écrit + chaîne login type entretien 90 sec écrite. Note Obsidian : [[sessions-cookies-authentication]].

- **Lundi 1er juin (avant-midi, Claude app)** — Tailwind docs section Layout : Flexbox & Grid + Spacing & Sizing. Notes Obsidian : [[flexbox-grid-fundamentals]], [[spacing-sizing-system]].

- **Lundi 1er juin (méta)** — Création `~/Obsidian/DevJobReady/to-do.md` (backlog vivant exos/dettes/brainstorms reportés/chantiers coupables) — lu et cité uniquement sur demande explicite. 2 règles ajoutées en mémoire feedback : `feedback-todo-file.md` (règle to-do) + `feedback-no-pause-asking.md` (ne plus demander pause/continue). Refactor SUIVI-COURANT.md sem 22 (64k → version condensée, détail technique migré vers notes Obsidian + `to-do.md` + `DECISIONS/`).

- **Lundi 1er juin (aprem, Claude Code CLI)** — **CRUD Outfit complet + composition + combobox JS, 3 PR mergées.**

  - **PR #53 — CRUD Outfit nu** (name + description). `resources :outfits`, controller 7 actions calqué sur Garment (sans category), 5 vues + `_form`. `show` en split vertical 60/40 responsive : mobile = flux naturel (card grandit, page scrolle), desktop = grille fixe `md:h-[85vh] md:grid md:grid-rows-5` + `row-span-3/2`. Décision design tranchée : `position` spatial (hyp. B) reporté → composition simple d'abord.

  - **PR #54 — composition + validation**. Setter gratuit `garment_ids=` (jointure pure → pas besoin de `fields_for`) + `validates :garments, presence: true` (voit la collection en mémoire avant save). Scope `current_user.garments` (sécurité). Affichage des pills dans l'index. Détail → [[has-many-through-composition-and-presence-validation]].
    ```ruby
    params.expect(outfit: [ :name, :description, garment_ids: [] ])
    validates :garments, presence: true
    ```

  - **PR #55 — combobox Tom Select** (branche `feature/combobox-js`). Dropdown searchable multi-select à pills via importmap + Stimulus, en remplacement des checkboxes. Setup douloureux (vendoring importmap qui 404 en cascade). Solution = pin CDN sur le build complete wrappé `+esm`. Détail + 7 pièges → [[tom-select-importmap-stimulus]].
    ```ruby
    pin "tom-select", to: "https://cdn.jsdelivr.net/npm/tom-select@2.6.1/dist/js/tom-select.complete.js/+esm"
    ```
    CSS Tom Select vendorisée proprement (inlinée dans le build Tailwind via `@import`).

  - **Pièges DOM debug** (card index) : `<a>` dans `<a>` et balise fermante dans la boucle → [[erb-nested-anchor-and-loop-tag-pitfalls]].

  - **Reports délibérés** → `to-do.md` : `position` spatial (canvas drag-drop, atelier Stimulus dédié). (Styling vue `edit` outfit : déjà soldé lundi, retiré du report — corrigé mardi 2 juin.)

- **Lundi 1er juin (soir, Claude app)** — Exo dirigé sandbox `auth-from-scratch` (`has_secure_password` from scratch sans Devise) dans `~/code/sandbox/rails/`. Commit `f0c3609`. Périmètre : `AuthExoUser` + `AuthExoSessionsController` (new/create/destroy) + form login + helper `current_user` memoized + `before_action :require_login` global + `skip_before_action only: %i[new create]`. Note exo : [[auth-from-scratch-sandbox-exo]] (concepts incorporés en cours d'exo : index DB unique perf + intégrité atomique, `URI::MailTo::EMAIL_REGEXP`, séparation model/form pour confirmation password opt-in, REST = 1 controller / 1 ressource, opérateur `||=` memoization). 2 questions style entretien archivées : [[Entretiens/Rails/auth-from-scratch]] (`find_by(id:)` vs `find()` + `skip_before_action only:` sur Sessions). **Réponses orales chronométrées 90 sec à faire mardi matin 2 juin** au démarrage de session.

- **Mardi 2 juin (matin, Claude app)** — Odin chap. **27. Active Record Callbacks** en lecture profonde + coaching Claude. Couvert : lifecycle 6 phases + ordre callbacks save chain, 3 syntaxes d'enregistrement (symbole / bloc / classe), **`self` dans les callbacks** (piège du setter + propagation de la variable locale à toute la méthode dès qu'un `=` apparaît n'importe où), conditionnels `:on` / `:if` / `:unless` (symbole vs lambda + safe navigation pour assos nil), **`throw :abort`** (mécanique Ruby `catch`/`throw`, piège historique `return false` Rails 4→5), **`after_commit` vs `after_save`** (LA question d'entretien : `deliver_later` dans `after_save` + transaction qui rollback → job orphelin → worker crash sur `RecordNotFound`), `touch` + `after_touch` + Russian doll caching + piège `after_commit on: :update` déclenché par un simple touch. Knowledge Check Odin (4 questions) répondu par écrit dans la note. Note Obsidian : [[callbacks]].

- **Mardi 2 juin (avant-midi, Claude app)** — Tailwind docs **Theme + Functions & Directives v4.3** en lecture profonde + coaching Claude. **Swap programme** : docs Customization priorisée sur la vidéo "Building responsive layouts" (vidéo non vérifiée v4 → reportée). Couvert : theme variables ≠ CSS vars classiques (génèrent des utilities **+** existent en `:root`), **namespaces** (`--color-*` → 15 préfixes utility, `--spacing-*`, `--font-*`, `--breakpoint-*`, etc.), `@theme` directive (placement top-level, syntaxe), **extend vs override** (`--xxx-*: initial` pour reset namespace, conséquence : redéfinir transparent/current/white/black), **référencer une var depuis une autre** (`var()` obligatoire — `--color-X: --color-Y` stocke la string littérale, résolution dynamique pour theming runtime), **suffixe `-hover` est juste un nom** (≠ comportement hover, variant séparé), **mécanique build → runtime** (JIT scan **statique** des sources, namespace → utility prefix mapping, résolution `var()` au runtime), **piège classes dynamiques** (`"border-#{color}"` non détecté), arbitrary values via `bg-(--var)`, accès JS via `getComputedStyle`/`setProperty`, directives connexes (`@layer`, `@custom-variant`, `@utility`, `@apply` à éviter en v4). Application Nine to Fine : variantes `champagne-hover`/`champagne-dark`, spacing sémantique `--spacing-card`, custom variant `favorited:` pour likes futurs. Note Obsidian : [[theme-variables-and-directives]].

- **Mardi 2 juin (méta)** — Règle mémoire feedback ajoutée : `feedback-concrete-verification-questions.md` (les questions de vérification doivent être CONCRÈTES avec un cas précis à analyser, jamais des questions ouvertes sur trade-offs abstraits). Triggered par 2 reprises de Chris pendant la session matin ("ta question n'est pas claire" sur "symbole vs lambda" + "qu'est-ce qu'on peut appeler"). Index `MEMORY.md` mis à jour. Méta : token GitHub fine-grained "ChrisCroc" expirant le 3 juin — **never used** → décision : laisser expirer (aucune intégration ne l'utilise, `gh auth login` OAuth + clés SSH gèrent le workflow git).

- **Mardi 2 juin (aprem, Claude Code CLI)** — **Active Storage sur Garment, PR #59** (3 commits atomiques). Tâche mercredi anticipée (composition outfit déjà faite lundi). `has_one_attached :photo` + upload + aperçu + affichage index/show + validation type/taille. Concepts & pièges traversés :
  - **Piège purge `"" → DeleteOne`** : un `file_field` vide soumet `""`, que le setter Active Storage interprète comme suppression → éditer un garment sans re-uploader purgeait la photo. Fix = garde dans `garment_params` retirant un `:photo` blank (source Rails vérifiée).
  - **Processeur d'images aligné sur vips** : défaut Rails 8 = `:vips`, Dockerfile installe `libvips`, mais gem locale était `mini_magick` (ImageMagick) → incohérence. Swap `mini_magick` → `ruby-vips` + `brew install vips`.
  - **Variants WebP** (`resize_to_limit` + `format: :webp`) : transcodage pour affichage cross-browser (Chrome/FF n'affichent pas le HEIC). Piège corrigé au commit : `format:` doit être **dans `variant(...)`**, pas passé à `image_tag` (sinon no-op).
  - **HEIC iPhone** : Safari/macOS convertit souvent le HEIC en JPEG à l'upload (d'où inflation de taille → seuil monté à 10 Mo). `image/heic`/`image/heif` gardés en défense.
  - **Validation via gem `active_storage_validations`** (option custom écrite d'abord pour comprendre, puis gem) : `content_type` + `size`, avec `spoofing_protection: true` (magic bytes via `file`/Marcel) → rejette un PDF renommé `.jpg`.
  - **Autres pièges debug** : `garment` (local de boucle) vs `@garment` (var d'instance) en `show` ; `object-cover`/`fill` (rogne) vs `object-contain`/`limit` (entier + bandes) → ratio `aspect-5/6` + fond blanc ; aperçu form gardé sur `blob&.persisted?` (« Cannot get a signed_id for a new record ») ; gem non chargée tant que serveur pas redémarré ; `spoofing_protection` = option de `content_type`, pas validateur racine.
  - **Reports backlog `to-do.md`** : ⚠️ prod (HEIF dans libvips Docker + commande `file` pour spoofing) ; compression/resize à l'upload ; Stimulus lightbox (clic, pas hover) ; `file_field` perd la sélection après erreur.
  - Notes Obsidian : [[active-storage-fundamentals-and-variants]], [[active-storage-validations-and-pitfalls]], [[object-fit-and-aspect-ratio]].

- **Mardi 2 juin (fin de journée, Claude Code CLI)** — **Tests Minitest model de la validation photo `Garment`, PR #61** (dette backlog comblée). 4 tests : image valide / sans photo (optionnel) / non-image rejeté / > 10 Mo rejeté. Fixtures réelles `valid.jpg` + `document.pdf` (générées vips/magick) car `spoofing_protection` lit les magic bytes. **Piège majeur : minitest 6 (Rails 8.1) a retiré `Object#stub`** → stub Ruby pur `define_singleton_method(:byte_size)` pour la branche taille. Suite complète : 47 runs, 0 failure. Note Obsidian : [[minitest-active-storage-validations]]. **Reste dette** : tests RSpec controller `GarmentsController` (7 actions + IDOR) → sem 24.

- **Mercredi 3 juin (matin, Claude app)** — Odin chap. **30. APIs and Building Your Own** + chap. **31. Working with External APIs** (paire pédagogique producteur/consommateur lue d'enchaînée). Chap. 30 couvert : Rails déjà API (HTML = format parmi d'autres), `respond_to do |format|` + 2 mécanismes détection format (extension URL + header Accept), `to_json` = double étape (`as_json` produit hash → `ActiveSupport::JSON.encode`), **override `as_json` avec whiteliste `only:`** (vs blackliste `except:` risquée dans le temps), `include:` pour sérialiser associations, `head :not_found` sans body, auth API par token (sessions cookies insuffisantes), `ActionController::API` + flag `--api` + middleware retiré, SOA + memo Bezos 2002. Chap. 31 couvert : API keys vs secret tokens, stockage Rails 8 natif **`credentials.yml.enc` chiffré** (recommandé) vs `dotenv-rails`, 4 niveaux auth (public / API key / secret token / OAuth user-delegated), versioning + changelog, OAuth 2.0 flow complet (`redirect_uri` whitelisté + `code` temporaire usage unique + échange contre `access_token` + `refresh_token` + `client_secret` jamais hors serveur), OmniAuth + intégration Devise, SDK officiel > HTTP brut, rate limits + backoff exponentiel. **Décision Nine to Fine actée** : pas d'API en V1 (Hotwire monolith = pas de SPA à servir), option `/api/v1/` portfolio Phase 4 à trancher. Intégration Anthropic Phase 4 via gem officielle `anthropic-sdk-ruby` + service object `app/services/ai/outfit_suggester.rb` + credentials chiffrées. Knowledge Check des 2 chap. répondu par écrit. **4 questions de vérification entretien 90 sec** (`as_json` + N+1, `format.html` oublié → 406 `UnknownFormat`, credentials Anthropic, flow OAuth Google 5 étapes) consolidées dans les notes. Notes Obsidian : [[apis-and-building-your-own]], [[working-with-external-apis]].

- **Mercredi 3 juin (avant-midi, Claude app)** — Tailwind docs **Customization : Dark mode + Colors palette** en lecture profonde. **Swap planning** : la vidéo Tailwind Labs "Building responsive layouts" reportée depuis sem 22 **n'existe pas** (vérifiée 3 juin via WebFetch, reco initiale erronée — méta-leçon `feedback-verify-external-setup` re-confirmée). Bascule sur le point 2 de PROGRESSION.md. **Dark mode couvert** : variant `dark:` cumulé (`dark:bg-gray-800`), 4 stratégies (default `prefers-color-scheme` / class-based `@custom-variant dark (&:where(.dark, .dark *))` / data-attribute / hybride 3-way `matchMedia` + `localStorage.theme`), FOUC = script inline dans `<head>` AVANT CSS, v3 → v4 = config JS → directive CSS. **Colors palette couverte** : 24 familles × 11 shades, **4 nouveaux v4 (Taupe, Mauve, Mist, Olive)**, **OKLCH** (uniformité perceptuelle + gamut P3), 14 utilities couleur, opacity modifiers `/` (stepwise + arbitrary + CSS var), customization `@theme` (ajout, override, désactivation `--color-X-*: initial`, nuke total `--color-*: initial`), **`@theme` vs `@theme inline`** (build-time vs runtime), accès `var(--color-X-Y)` + fonction `--alpha()`. Application N to F directe : étendre `--color-champagne` en 11 shades pour design pro + remplacer `opacity-50` par `bg-X/50` + bordures pro `border-gray-900/10`. Décision : **pas de dark mode V1** (les photos vêtements doivent garder leur perception colorimétrique correcte). Notes Obsidian : [[dark-mode]], [[colors-palette]].

- **Mercredi 3 juin (matin + avant-midi, méta CI/CD)** — Deux PR de workflow mergées sur main, en marge des lectures :
  - **PR #65** (`chore(workflow): add end-of-session video recommendation routine`) : nouvelle section **"Fin de session"** dans `CLAUDE.md` projet + nouveau slot **"Fin de journée — 5-10 min"** dans le tableau ritual quotidien de `PLANNING.md`. À partir de maintenant, à la fin de chaque journée Claude recommande 2 vidéos GoRails/Drifting Ruby (Railscasts uniquement pour concepts intemporels flaggés vintage 2013), backward ou forward looking, avec WebFetch de vérification obligatoire. Routine activée.
  - **PR #66** (`ci: auto-fix Dependabot bundler PR lockfiles + planning tweak`) : nouveau workflow `.github/workflows/dependabot-fix-lockfile.yml` qui détecte les PR Dependabot bundler avec `Gemfile.lock` corrompu (Bundler 4.0.8 locké en projet vs Bundler plus vieux dans Dependabot infra → strip de la section `CHECKSUMS`) et régénère le lockfile avec la bonne version + push le fix sur la branche de la PR. Workflow strictement gated (`actor == dependabot[bot]` non-spoofable + `head.ref` starts with `dependabot/bundler/`), `pull_request_target` event, permissions least-privilege (`contents: write` seulement au job level). **Méta-décision sécurité** : repo public OK, `github.actor` non-spoofable, surface d'attaque inexistante (Dependabot ne touche jamais au `Gemfile`). Workflow **testé en conditions réelles** sur PR #63 (jbuilder) et #64 (puma) — auto-fix commits poussés par `github-actions[bot]`. **Subtilité GitHub** : un push depuis `GITHUB_TOKEN` ne retrigger pas la CI principale (anti-loop) → close+reopen manuel des 2 PR pour forcer CI sur le fix commit. **PR #63 et #64 en attente de validation CI verte puis merge par Chris**. puma 8.0.2 = patch **2 CVE PROXY protocol v1** (CVE-2026-47736, -47737) — non applicable à N to F V1 (pas de PROXY protocol exposé), mais bonne hygiène avant Kamal proxy V2.

- **Mercredi 3 juin (après-midi, Claude Code CLI)** — **Design des vues Outfit : collage adaptatif, PR #69 mergée.** Tâche jeudi anticipée (Active Storage déjà soldé mardi). Branche `feat/outfits-design`.

  - **Session de conception** (skill `brainstorming` + compagnon visuel navigateur) : maquettes A (collage) vs B (hero+vignettes) → **collage retenu** (langage du domaine Polyvore/Whering, épouse les packshots `object-contain` ; B hiérarchise une pièce, stack/éventail cache la donnée). Stratégie N variable : **mosaïque plafonnée à 4 tuiles + compteur `+N`** (vs grille complète qui rend les tuiles minuscules). Ordre des tuiles : **par `category.position`** (déterministe + 1er palier vers la vision long terme du **mannequin fictif** par slots). Spec + plan versionnés sous `docs/superpowers/{specs,plans}/2026-06-03-outfits-design*`.

  - **Feature livrée** : partial unique `outfits/_collage.html.erb` **taille-agnostique** (`h-full w-full`, le parent dimensionne) consommé par `show` (grand) + `index` (petit). Préambule Ruby (tri + cap), grille via `case slots` en **classes littérales** (piège JIT), `col-span-2` conditionnel sur la tuile pour l'impair N=3, fallback initiale si pas de photo, compteur `+N`. Anti-N+1 controller : `includes(garments: [:category, { photo_attachment: :blob }])`. Polish `bg-zinc-50` sur les tuiles (anti blanc-sur-blanc). Nettoyage du placeholder `tags` mort dans l'index.

  - **Pièges traversés** (détail → notes Obsidian) : `sort_by` (mémoire, préserve l'eager load) vs `.order` (relance SQL + N+1) ; `photo_attachment: :blob` vs `:photo` (proxy) ; compteur `+N` qui doit être **enfant direct** du conteneur grid (sinon case grise + bloc qui pendouille) ; lecture du log (`IN (...)` groupé vs `= ?` répété ; mur `active_storage/representations` = bruit normal). Recette validée : matrice N=1/2/3/4/5/7 + fallback + ordre + N+1 (8 requêtes groupées, 0 N+1).

  - **Backlog `FEATURES_FUTURES.md`** : (1) sélection des garments **par clic dans l'index** (remplace Tom Select, inviable à ~100 pièces) — priorité haute, post-emploi après index filtrable ; (2) index garments **organisé en onglets** catégorie/couleur — base déjà planifiée sem 24. **Décision V1** : compteur `+N` **non-cliquable** (la card-lien + les pills de `show` couvrent déjà le besoin).

  - Notes Obsidian : [[eager-loading-sort-by-vs-order-and-nested-attachments]], [[outfit-collage-adaptive-mosaic]].

  - **Reports** : exo dirigé du soir (N+1 provoqué/tué OU logique du cap en Ruby pur) **non fait** → à caler plus tard. 2 vidéos fin de journée **non recommandées** (session clôturée par Chris avant le slot).

**Blocages**

- **Setup Tom Select / importmap = ~35 min de trial-and-error** (lundi 1er juin, build modulaire 404, UMD sans export default, vendoring qui re-télécharge, typo de casse). Leçon actée en mémoire feedback `feedback-verify-external-setup.md` : pour les setups d'outils externes fragiles, vérifier l'URL/format exact (WebFetch) **avant** de faire exécuter des commandes, et expliquer chaque ligne au fil de l'eau.

- **Questions de vérification floues** (mardi 2 juin matin) — 2 reprises consécutives de Chris ("ta question n'est pas claire"). Cause : questions ouvertes sur trade-offs abstraits au lieu de cas concrets. Règle mémoire `feedback-concrete-verification-questions.md` créée pour acter le pattern.
