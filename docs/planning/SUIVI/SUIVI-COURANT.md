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

  - **Reports délibérés** → `to-do.md` : `position` spatial (canvas drag-drop, atelier Stimulus dédié), styling vue `edit` outfit.

**Blocages**

- **Setup Tom Select / importmap = ~35 min de trial-and-error** (build modulaire 404, UMD sans export default, vendoring qui re-télécharge, typo de casse). Leçon actée en mémoire feedback `feedback-verify-external-setup.md` : pour les setups d'outils externes fragiles, vérifier l'URL/format exact (WebFetch) **avant** de faire exécuter des commandes, et expliquer chaque ligne au fil de l'eau.
