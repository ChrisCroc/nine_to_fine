# Suivi vivant — Sem en cours + précédente

Journal de bord récent. À mettre à jour à la fin de chaque journée via la routine `/end-of-day` (à créer sem 22+).

**Politique de rolling** : ce fichier contient **la semaine en cours + la semaine précédente complète**. Début de mois (au plus tard le premier lundi du mois suivant), archivage de tout le mois précédent vers `ARCHIVE/{YYYY-MM}.md`.

**Politique de verbosité** : journal **condensé**. Les pavés techniques (pièges, concepts maîtrisés, choix de design, idiomes Rails 8, classes Tailwind) **vivent dans les notes Obsidian** (`~/Obsidian/DevJobReady/Apprentissage/`). Le Suivi les **référence par lien**, ne les duplique pas. Le backlog forward-looking (exos en attente, dettes, brainstorms reportés, chantiers coupables) vit dans `~/Obsidian/DevJobReady/to-do.md`.

**Règle de lecture au démarrage de session** :
- Mardi-vendredi : focus journée veille + sem en cours.
- Lundi (ou 1ère session de la sem) : lecture intégrale sem précédente + sem en cours qui démarre, avec récap accomplissements + blocages + ajustements de la sem précédente avant le programme du jour.

**Archives** : voir `docs/planning/SUIVI/ARCHIVE/{YYYY-MM}.md`.

---

### Sem 23 (1-7 juin 2026) — condensée

**Archive verbatim** : voir [`ARCHIVE/2026-06.md`](ARCHIVE/2026-06.md) (section sem 23, jour par jour).

**Livraisons clés**

- **CRUD Outfit + composition** (PR #53/#54/#55, lun 1er juin) : controller 7 actions + setter `garment_ids=` (jointure pure, pas `fields_for`) + `validates :garments, presence: true` + combobox Tom Select multi-select à pills via importmap + Stimulus. Notes : [[has-many-through-composition-and-presence-validation]], [[tom-select-importmap-stimulus]], [[erb-nested-anchor-and-loop-tag-pitfalls]].
- **Active Storage sur Garment** (PR #59 + tests #61, mar 2 juin) : `has_one_attached :photo` + variants WebP + validation `active_storage_validations` (`content_type` + `size` + `spoofing_protection: true`) + swap `mini_magick`→`ruby-vips`. Piège purge `""→DeleteOne` neutralisé. Notes : [[active-storage-fundamentals-and-variants]], [[active-storage-validations-and-pitfalls]], [[object-fit-and-aspect-ratio]], [[minitest-active-storage-validations]].
- **Outfit collage adaptatif** (PR #69, mer 3 juin) : partial unique `_collage` taille-agnostique + eager loading anti-N+1 (`includes(garments: [:category, { photo_attachment: :blob }])`) + mosaïque plafonnée à 4 tuiles + compteur `+N`. Notes : [[eager-loading-sort-by-vs-order-and-nested-attachments]], [[outfit-collage-adaptive-mosaic]].
- **Tags comma-separated** (PR #74, jeu 4 juin) : concern `Taggable` mutualisé Garment+Outfit + attribut virtuel `tag_names` + `after_save :sync_tags` (`find_or_create_by` + downcase) + gem `bullet` (2 N+1 préexistants corrigés). Notes : [[taggable-concern-and-tag_names-virtual-attribute]], [[minitest-taggable-concern]], [[bullet-n+1-detection-and-eager-loading-fixes]].
- **Exo sandbox `auth-from-scratch`** (lun 1er soir, `~/code/sandbox/rails/` commit `f0c3609`) : `has_secure_password` from scratch sans Devise. Note : [[auth-from-scratch-sandbox-exo]] + entretien : [[Entretiens/Rails/auth-from-scratch]].

**Odin Rails (lectures profondes matin)** : chap. 27 Callbacks (mar 2), chap. 30+31 APIs paire (mer 3), chap. 34+35 CSS+JS Bundling paire (jeu 4). Notes : [[callbacks]], [[apis-and-building-your-own]], [[working-with-external-apis]], [[bundling-vs-importmap-rails-8]].

**Tailwind (lectures profondes avant-midi)** : Theme + Functions/Directives (mar 2), Dark mode + Colors palette (mer 3), Backgrounds/Borders/Effects/Opacity (jeu 4). Notes : [[theme-variables-and-directives]], [[dark-mode]], [[colors-palette]], [[backgrounds-borders-effects-v4]].

**CI/CD méta** : PR #65 (routine reco vidéos fin de session activée), PR #66 (workflow auto-fix Dependabot bundler CHECKSUMS — testé en réel sur PR #63 jbuilder + #64 puma ; friction connue : `GITHUB_TOKEN` ne retrigger pas CI → close+reopen manuel), PR #68 (push filter CI `master`→`main`).

**Décisions de design tranchées (ne pas re-proposer)**

- **Position spatial outfit** (drag-drop canvas, hyp. B) : reporté backlog → composition simple V1.
- **Compteur `+N` mosaïque** : non-cliquable V1 (card-lien + pills de `show` couvrent déjà le besoin).
- **API JSON N to F V1** : pas d'API (Hotwire monolith, pas de SPA à servir). Option `/api/v1/` portfolio Phase 4 à trancher.
- **Dark mode V1** : non (photos vêtements = perception colorimétrique correcte requise).
- **Tom Select setup** : pin CDN sur build complete wrappé `+esm` (pas vendoring importmap qui 404).
- **Processeur images Rails 8** : `:vips` (cohérence Dockerfile libvips + `brew install vips` dev).
- **Intégration Anthropic Phase 4** : gem officielle `anthropic-sdk-ruby` + service object `app/services/ai/outfit_suggester.rb` + credentials chiffrées `credentials.yml.enc`.
- **Sélection garments par clic dans l'index** (remplace Tom Select à ~100 pièces) : reporté backlog `FEATURES_FUTURES.md`, post-emploi après index filtrable.

**Concepts maîtrisés en live (ne pas réexpliquer comme débutant)**

- `has_many through:` + setter virtuel `garment_ids=` (jointure pure, pas `accepts_nested_attributes_for` / `fields_for`).
- `validates :garments, presence: true` voit la collection en mémoire avant save (≠ DB).
- Eager loading nested attachments : `photo_attachment: :blob` (proxy), pas `:photo`.
- Concern polymorphique mutualisé (`Taggable` sur Garment+Outfit) avec `as: :taggable`.
- Garde `nil` (préserver) vs `[]` (vider) pour attribut virtuel `tag_names`.
- Minitest 6 (Rails 8.1) a retiré `Object#stub` → stub Ruby pur via `define_singleton_method`.
- `respond_to do |format|` + négociation Accept header + `as_json only:` whiteliste (pas `except:`).
- Active Storage : piège purge `""→DeleteOne` (file_field vide), garde `garment_params` retirant `:photo` blank.
- 3 vidéos GoRails visionnées en autonomie mer soir : [[preserving-file-uploads-on-edit]], [[gorails-importmaps-with-rails]], [[strict-loading-activerecord]].

**Friction / blocages capturés**

- Setup Tom Select / importmap : ~35 min trial-and-error (lun 1er) → règle mémoire `feedback-verify-external-setup`.
- Questions de vérification floues 2× (mar 2 matin) → règle mémoire `feedback-concrete-verification-questions`.
- **Ven 5 + sam 6 décrochés** (fatigue post grosse semaine prod) → 2 soirs sandbox manqués → cumul exos reportés sem 24 (samedi 13 juin rattrapage).

---

### Sem 24 (8-14 juin 2026) — condensée

**Archive verbatim** : voir [`ARCHIVE/2026-06.md`](ARCHIVE/2026-06.md) (section sem 24, jour par jour).

⭐ **Bilan global** : **Phase 1 techniquement bouclée vendredi 12 juin** (9 jours d'avance sur planning). Parcours **Odin Rails ✅** (chap. 1-41), **Phase 1 Tailwind v4 ✅** (étapes 1-14). **113 examples RSpec verts** dans la suite complète (migration totale Minitest → RSpec achevée). **Dette technique sem 22 soldée** (CRUD Garment sans tests le 29 mai → 15 examples + 4 IDOR sentinels). Phase 2 React démarre sem 26 (22 juin) inchangée — timeline emploi septembre intacte.

**Livraisons clés**

- **GarmentFilter Query Object back** (PR #79, lun 8 juin) : pipeline `inject` + dispatch dynamique `send("by_#{key}")` + 4 filtres AND combinables (color/category/tag/brand). OCP prouvé 2× en live (ajout `:brand` proactif sem 24 puis `:search` mardi, zéro modif `apply`). Note : [[query-objects-pipeline-inject-and-dynamic-dispatch]].
- **GarmentFilter tests Minitest** (PR #81, lun 8 juin) : 10 cas incl. ⭐ test propriété sécurité cross-user. Note : [[minitest-garment-filter-query-object]].
- **GarmentFilter front + tags cliquables** (PR #83, lun 8 juin) : constante `Garment::COLORS` + validation inclusion + normalisation données dev (12 valeurs polluées corrigées) + helper `pill_class` + index Turbo Frame `garments_list` + pattern `_top` pour échapper au frame. Notes : [[turbo-frames-in-production-and-content-missing-trap]], [[inclusion-validation-with-allow-blank]].
- **Recherche live ILIKE + Stimulus debounce** (PR #91, mar 9 juin) : 5e tamis `by_search` + `sanitize_sql_like` + Stimulus `search_form_controller` debounce 300ms via `static values`. ⭐ form HORS du frame pour préserver focus. Notes : [[garment-filter-search-extension-ilike-sanitize]], [[stimulus-debounce-and-turbo-frame-focus-preservation]].
- **Catégories Dress/Suit/Swimwear + color selector Tom Select** (PR #91, mar 9 juin) : seeds + constante `Garment::COLOR_HEX` (13 hex) + test invariant statique + Stimulus `color_select_controller.js` avec pastilles colorées + CSS centralisé `.ts-control`. Bridge `data-hex` → `data.hex` (Tom Select strip `data-`). Note : [[tom-select-render-customization-color-selector]].
- **Design system typo Playfair+Inter (desktop puis mobile-first)** (PR #95+98, mer 10 juin) : tokens `--font-display`/`--font-body` + 5 tailles sémantiques `--text-h1/h2/h3/body/caption` bundlées v4. ⭐ piège mobile-first flaggé en live → refonte tokens (h1 32px, h2 20px, caption 14px). Notes : [[v4-design-system-and-mobile-first-pitfall]], [[typography-fundamentals]].
- **RSpec setup + migration totale Minitest** (PR #96+102+106, mer-jeu-ven) : rspec-rails 8 + factory_bot 6.5 + 5 factories + migration 7 models specs (~68 examples) + 3 request specs controllers (30 examples) + cleanup `test/` complet + simplification CI (5 jobs → 4, 2-3 min gagnées par PR). ⭐ **Dette sécurité sem 22 soldée** : `garments_spec.rb` 15 examples + 4 IDOR cross-user sentinels (show/edit/update/destroy). Notes : [[rspec-and-factory-bot-setup]], [[minitest-to-rspec-migration-patterns]], [[factory-bot-advanced-patterns]], [[rspec-active-storage-testing]], [[rspec-taggable-concern-testing]], [[rspec-request-specs-fundamentals]], [[idor-sentinel-pattern-rspec]].
- **Anti-double-submit Stimulus + Tailwind Customization avancé v4** (PR #104, ven 12 juin) : `@custom-variant data-loading` + `@utility btn-base` + Stimulus `submit_button_controller` mutant `data-loading="true"/"false"`. Note : [[customization-advanced-v4]].
- **Investigation warning bullet POST /outfits create** (sam 13 juin matin) : safelist documenté livré. Cause = cascade `active_storage_validations` + `spoofing_protection: true` qui télécharge le blob de chaque Garment associé au save Outfit. Fix idiomatique impossible. Note enrichie : [[active-storage-validations-and-pitfalls]] § 7.

**Odin Rails (parcours TERMINÉ ✅)** : chap. 36 Turbo Frames+Streams (lun) [[turbo-frames-streams-and-format-negotiation]] · chap. 37 Stimulus + 3 exos sandbox (mar, repo `ChrisCroc/sandbox-stimulus` créé) [[stimulus-fundamentals]] · chap. 38 Mailers (mer) [[mailers-fundamentals]] · chap. 40 Advanced Topics 6 sections (jeu : [[advanced-routing-fundamentals]], [[controllers-without-models-and-rest-principles]], [[advanced-layouts-and-content-for]], [[metaprogramming-ruby-and-rails-first-pass]] ⚠️ first-pass, [[solid-design-principles-and-anti-patterns]], [[i18n-internationalization-fundamentals]]) · chap. 41 Websockets+Action Cable + Rails Guide 8.1 (ven) [[action-cable-fundamentals]].

**Tailwind v4 (Phase 1 TERMINÉE ✅)** : Typography (lun) [[typography-fundamentals]] · Transitions & Animation (mar) [[transitions-and-animations-fundamentals]] · Transforms (mer) [[transforms-fundamentals]] · Interactivity 19 utilities (jeu) [[interactivity-fundamentals]] · Customization avancé `@apply`/`@utility`/`@custom-variant` (ven) [[customization-advanced-v4]].

**Décisions de design tranchées (ne pas re-proposer)**

- **Filtres garments combinables AND** (vs un seul à la fois) : URL `?q[color]=red&q[category_id]=3` plat ANDé, objet `q` paramétrisable. Routes nested éliminées (combinatoire ingérable).
- **`GarmentFilter` PORO** (vs ActiveModel) : injecté avec scope + params, méthodes privées `by_X`, 4 filets de défense (scope `current_user.X` + `permit` controller + `slice(*FILTERS)` filter + SQL paramétrisé). Recherche par nom scopée `current_user.garments` mandatory (pas `Garment.where`).
- **`pg_search` reporté backlog** (`FEATURES_FUTURES.md`) + **sidebar filtres togglable** reportée backlog (Chris a qualifié le bandeau pills horizontal d'"horrible").
- **Multi-color par garment reporté backlog** : V1 mono-color. **Normalisation `brand` au save** reportée backlog : callback `before_save :normalize_brand` (`.strip.titleize`).
- **Form HORS du frame pour debounce** : préserver focus pendant les swaps. Alternative Turbo 8 morphing reportée.
- **`data-*` attribute over `.is-loading` classe** : sémantique état machine-lisible + a11y + convention Tailwind v4 `data-[state=open]:` natif. **Controller Stimulus sur `<form>` pas `<button>`** (turbo:submit-end bubble vers le haut). **`@utility btn-base` scope C** (forme + focus ring a11y, peinture en HTML) ouvert OCP futurs `btn-primary`/`btn-danger` via Rule of 3. **Pas de `pointer-events-none`** : Turbo pose déjà `disabled` natif + `pointer-events-none` bloque `cursor-wait`.
- **Migration totale Minitest → RSpec** (vs cohabitation) : factory_bot natif, `let`/`let!`, `type: :request`. Cleanup `test/` complet + `spec/fixtures/files` au défaut RSpec.
- **Footer abandonné** : apps mobile-first modernes n'en ont pas. Mentions légales B2C plus tard dans `pages/home.html.erb` only.
- **Pas de config Action Mailer pré-emptive** (YAGNI) : setup repoussé au 1er mailer (follow notif sem 25+).
- **Pas de setup i18n pré-emptive** (YAGNI + cargo cult + premature optimization, 3 anti-patterns SOLID Section 5) : scope 7 étapes documenté `to-do.md`, trigger explicite = "démo recruteur francophone Paris".
- **Skip tuto Odin "Basic Messaging App"** (vanilla JS pattern legacy 2018-2021, viole règle péda 9) → exo sandbox focused Solid Cable + Turbo Streams + vraie pratique sem 25 sur Likes/Comments broadcast N to F.
- **SuggestionsController dédié dès V1 + futur model `Suggestion` persisté** : ajouté `FEATURES_FUTURES.md` Phase 4 IA (pattern verbe→nom DHH).
- **Safelist bullet documenté pour POST /outfits create** : `Bullet.add_safelist type: :n_plus_one_query, class_name: "Garment", association: :photo_attachment` + `Bullet.stacktrace_includes = [ "app/" ]` permanent.
- **US18 "Make an outfit public" reportée sem 26+** (vs stub `is_public:boolean` lun 15) : brainstorm produit dédié requis sur sémantique "public" (feed/index/URL directe). Likes/Comments/Follow sem 25 testables via RSpec + console sans `is_public`.

**Concepts maîtrisés en live (ne pas réexpliquer)**

- **Turbo Frames** : `turbo_frame_tag @model` via `dom_id` + `data-turbo-frame="_top"` pour sortir + ⭐ piège "Content missing" si link interne ciblant page sans frame matchant.
- **Turbo Streams** : 8 actions + `target`/`targets` + templates `.turbo_stream.erb` + broadcast via `after_create_commit { broadcast_append_to }` + `turbo_stream_from @record`.
- **Action Cable + Solid Cable** : stack mentale Hotwire (Action Cable EN DESSOUS Turbo Streams = sucre `turbo_stream_from` génère auto `Turbo::StreamsChannel` signé). Auth via `env["warden"].user` (4 obstacles à `cookies.encrypted` direct). ⭐ Connection **permissive** + `return reject unless current_user` per-channel (vs `reject_unauthorized_connection` qui casse Turbo Streams sur pages publiques).
- **Stimulus avancé** : 5 lifecycle + `static values` typés + `XValueChanged` réactif + 3 catégories d'état (targets DOM / values HTML config / propriété JS `this.xxx` interne) + ⚠️ jamais shadow d'API DOM (`submit`/`click`/`focus`) + `disconnect()` cleanup obligatoire (timer fantôme).
- **Query Object pipeline** : `FILTERS.inject(scope) { |rel, k| next rel if blank; send("by_#{k}", rel, val) }` + dispatch dynamique safelisté + AR lazy.
- **AR sécurité + IDOR** : scope `current_user.X.find` → `RecordNotFound` → 404. Pattern IDOR sentinel : `sign_in user_a` + accès user_b → `expect(response).to have_http_status(:not_found)`. ⚠️ Rails `show_exceptions = :rescuable` en test env **mandatory** (vérifier `config/environments/test.rb`).
- **RSpec request specs** : `type: :request` + helpers HTTP + `response`/`flash` + `Devise::Test::IntegrationHelpers` + Rails 7+ redirection PATCH/DELETE en **303 See Other** (pas 302). Pattern AAA `context "with valid params"`/`"with invalid params"`. ⚠️ `do` manquant sur `context`/`describe` = bug sournois (Ruby n'erreure pas, examples se réattachent au parent → tests trop indulgents).
- **factory_bot** : `after(:build)` callback + bypass `Model.new` quand factory force un état + `let!` (eager) vs `let` (lazy) + association magique vs explicite + `expect { action }.to change(Class, :count).by(-1)`.
- **Active Storage testing** : `config.file_fixture_path` mandatory + `attach(io:, filename:, content_type:)` + `define_singleton_method(:byte_size)` hack pour stub > 10MB.
- **Tailwind v4 mécanisme central** : composition via CSS variables internes (`--tw-translate-x`, etc.) → empiler N transforms sans écrasement. ⚠️ Ordre `@import` Google Fonts **AVANT** `@import "tailwindcss"`. ⚠️ Typo dans `@apply` casse TOUTE la directive (terminal `bin/dev` le dit explicitement). `@custom-variant X (...)` + `@utility X { @apply ... }` + `@variant` ≠ `@custom-variant`. Utilities natives gagnent contre `@utility` custom en conflit (garantie v4).
- **Mailers pattern moderne** : `Mailer.with(params).action.deliver_later` + GlobalID sérialisation + 2 familles callbacks `*_action` (mail) vs `*_deliver` (message) + ⭐ `after_commit on: :create` **mandatory** (jamais `after_save` pour `deliver_later`, sinon job orphelin sur rollback transaction). Pareil pour broadcasts Action Cable.
- **SOLID 5 lettres** + 5 anti-patterns (God Object, Spaghetti, Cargo cult, Premature optimization, Magic numbers) + ⭐ **OCP central** dans concerns/extensions polymorphic (likeable scénario).
- **Metaprogramming first-pass** : 3 armes (`send` LE dispatch, `define_method` génération à la volée, `method_missing` + `respond_to_missing?` DSL) + 4 pièges sécurité (`send` user input = RCE). ⚠️ **Cours dédié sem 25 mer 17 Priorité 1** (`to-do.md`).
- **Bullet audit méthode** : (1) cartographie statique access pattern AVANT tout fix, (2) `Bullet.stacktrace_includes = [ "app/" ]` pour remonter à la cause, (3) reproduction propre 2 chemins, (4) diagnostic SQL `rails console`.

**Friction / blocages + méta-erreurs Claude (à appliquer plus strictement)**

- ⭐ **HEREDOC zsh+AZERTY de Chris ne marche JAMAIS** (flaggée 2× ven 12). Toujours commits `-m "1 ligne"` + body PR via `gh pr create --body-file /tmp/...md`. Plus jamais de `$(cat <<'EOF' ... EOF)`.
- **Bash sans commande à gauche** (`> log/bullet.log`, `: > file`) refusée par zsh de Chris. Toujours commande explicite (`truncate -s 0`, `rm`).
- **Numéros de ligne périmés après edits successifs** : utiliser ancres textuelles (`grep -n "system-test:"`) plutôt que numéros figés.
- **Préalables critiques flaggés trop discrètement** (Devise::Test::IntegrationHelpers, file_fixture_path, show_exceptions :rescuable). Encadrer ⚠️ **Avant de continuer** sur sections complexes mandatory.
- **Squelettes nus + récitation de pattern sans relecture du code affiché** (3 occurrences sem 24). Règles `feedback-explain-every-line-and-context` + globale 6 "Relis-toi avant de proposer" → **relire aussi les notes Obsidian récentes** avant de prescrire (anti-pattern `pointer-events-none` documenté hier que Claude a re-recommandé sans relire).
- **Recommandation aveugle sur warnings bullet** : vérifier l'access pattern réel (grep + lecture) AVANT tout fix, même si bullet recommande explicitement.
- **Vulgarisation insuffisante** récurrente sur Tailwind v4 + Turbo + Tom Select + Stimulus (concepts CSS-first + `@theme` + namespaces) → "avancé sous le capot" exige analogie concrète d'abord. Règle `feedback-vulgarize-advanced-rails` sem 22.
- **Trop d'info empilée d'un coup** sur lignes denses Action Cable (ven 12 "tu commences à m'embrouiller"). Sur lignes denses = **une seule idée par bloc**.
- **2h30 lecture pure mal calibré pour chapitres notationnels** (Tailwind Customization v4) : pivot pédago ven 12 juin → pour les chapitres **notationnels** (vs conceptuels Action Cable/Callbacks/SOLID), couper 1h lecture + 1h30 pratique immédiate. Pattern à valider sem suivantes.
- **3 nouvelles memory globales sem 24** : `project-nine-to-fine-mobile-first` (design system desktop-first sans poser la question contexte), `project-nine-to-fine-locale-english` (présomption FR alors que `:en`), `feedback-no-co-authored-by` (commits sans Co-Authored-By Claude ni email Anthropic).

**Reports vers sem 25**

- **Likes broadcast Turbo Streams** (lun 15) : Like model polymorphic + UI broadcast `after_create_commit { broadcast_append_to outfit }` + `turbo_stream_from @outfit` (pattern moderne d'entrée de jeu = consolidation Turbo Streams par production réelle).
- **Comments broadcast Turbo Streams** (mar 16) : Comment model polymorphic + même pattern broadcast.
- ⭐ **Journée consolidation hybride mer 17** : matin **cours Stimulus avancé** + 3 exos sandbox `ChrisCroc/sandbox-stimulus` (Outlets / `dispatch()` pub-sub / state machine via `XValueChanged`) → note Obsidian [[stimulus-advanced-patterns]] à créer ; avant-midi **cours Metaprog Priorité 1** + 3 exos sandbox `~/code/sandbox/rails/metaprogramming/` (clone `attr_accessor` / Builder DSL `method_missing` / refactor `GarmentFilter` `define_method` Q6 reportée) → note Obsidian [[metaprogramming-deep-dive]] à créer ; aprem suite Likes broadcasts sur N to F.
- **Follow model polymorphic + profil user public** (jeu 18) : `UsersController#show` + listing garments/outfits/follows + US04 (update profile).
- **Lancement recherche emploi + skill `job-tracker`** (ven 19 + sam 20-21) : 3 candidatures Rails + LinkedIn polish + GitHub README pinned. Skill Claude Code `job-tracker` ~1-2 j atelier.
- **4e IDOR sentinel `GET /outfits/:id/edit`** : à ajouter pour cohérence avec garments (non bloquant, scoping garanti par `set_outfit` partagé).
- **5 exos sandbox cumulés** (lun/mar/mer/jeu sem 24 + ven 12) : Stimulus debounce, Mailer `after_commit` + RSpec `have_enqueued_mail`, Tailwind Transforms modal+hover, Solid Cable + Turbo Streams focused. Plan = 1 nouveau/soir sem 25 + rattrapage progressif samedi 20. Spec complète dans `to-do.md`.
- **Personal to-do Obsidian** : Huntr Le Wagon 🔴, contentieux serrurier 🔴, relire Turbo Frames/Streams 🟡, décision SPA vs MPA NtF 🟡.

---

### Sem 25 (15-21 juin 2026)

⭐ **Démarrage lundi 15 juin** — Première session sem 25. Phase 1 techniquement bouclée vendredi 12 juin (9 jours d'avance). Sem 25 = **semaine consolidation dispersée** + features sociales N to F + lancement recherche emploi + skill `job-tracker`. Phase 2 React démarre sem 26 (22 juin) inchangée.

**Conditions d'alerte sem 25** (cf. `PHASES/phase-1.md`) : si Likes broadcast Turbo Streams patine > 1.5 j → simplifier en HTML simple, upgrade reportée sem 26-27. Si mer 17 hybride trop dense cognitivement → décaler 1 cours à jeudi matin en repoussant Follow d'½ journée. Si ven 19 lancement emploi patine → décaler 3 candidatures à samedi.

**Accompli**

- **Lundi 15 juin (démarrage de session, Claude Code CLI)** — Read SUIVI obligatoire (étape 0 CLAUDE.md). Annonce programme du jour (Like model polymorphic + UI broadcast Turbo Streams + LikesController + IDOR). Routine lundi : (1) `gh issue list` → mapping 9 issues ouvertes avec plan sem 25 (US20 lun / US21 mar / US22+US04 jeu / US18 reportée sem 26+ après brainstorm produit "public" / US05 + US23-24 IA Phase 4). **Décision tranchée sur US18** : option B retenue (coder Like model + UI sem 25 sans `is_public:boolean`, testable via RSpec + console ; US18 = brainstorm produit dédié sem 26+ vs stub aujourd'hui = premature optimization). (2) **Routine condensation hebdo sem 24 exécutée** (étape 7 CLAUDE.md) : archive verbatim sem 24 ajoutée à `ARCHIVE/2026-06.md` + sem 24 condensée écrite dans SUIVI-COURANT (~40 k → ~11 k chars, marge sur cible 8 k pour préserver décisions tranchées + concepts en live + reports backlog). 6 tâches TaskCreate posées pour la journée.
