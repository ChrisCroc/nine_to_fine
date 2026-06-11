# Progression apprentissage

Source de vérité pour savoir **exactement** où Chris en est sur chaque ressource. À mettre à jour quand un chapitre / vidéo / section est terminé. Claude lit ce fichier au démarrage de session pour proposer le prochain sujet précis du matin et de l'avant-midi.

## Odin Project — Full Stack Ruby on Rails

- **Fait** (chap. 1-15 du parcours) : Introduction → Rails Basics (Routing, Controllers, Views, Project Store App, Deployment) → Active Record Basics → Migrations → Basic Validations → **Basic Associations**
- **Fait — consolidation post-bootcamp (sem 22-23, lecture profonde, "Project: X" remplacés par sandbox + Nine to Fine, règle péda 9)** :
  - 17. The Asset Pipeline ✅
  - 18. Importmaps ✅
  - 19. Turbo Drive ✅
  - 20. Form Basics ✅
  - 22. Sessions, Cookies and Authentication ✅ (lundi 1 juin)
  - 24. Active Record Queries ✅ (priorisé hors ordre sem 22)
  - 25. Active Record Associations (polymorphic, has_many through, self-join) ✅
  - 27. Active Record Callbacks ✅ (mardi 2 juin matin, voir [[callbacks]])
  - 28. Advanced Forms ✅
  - 30. APIs and Building Your Own ✅ (mercredi 3 juin matin, voir [[apis-and-building-your-own]])
  - 31. Working with External APIs ✅ (mercredi 3 juin matin, voir [[working-with-external-apis]])
  - 34. CSS Bundling ✅ (jeudi 4 juin matin, lu en paire avec 35, voir [[bundling-vs-importmap-rails-8]])
  - 35. JS Bundling ✅ (jeudi 4 juin matin, lu en paire avec 34, voir [[bundling-vs-importmap-rails-8]])
  - 36. Turbo ✅ (lundi 8 juin matin sem 24, voir [[turbo-frames-streams-and-format-negotiation]] — Frames + Streams + format negotiation + bonus Morphing Turbo 8)
  - 37. Stimulus ✅ (mardi 9 juin matin sem 24, voir [[stimulus-fundamentals]] — handbook complet + reference + 3 exos sandbox repo `ChrisCroc/sandbox-stimulus`)
  - 38. Mailers ✅ (mercredi 10 juin matin sem 24, voir [[mailers-fundamentals]] — pattern moderne `Mailer.with(params).action.deliver_later` + sérialisation GlobalID Active Job, distinction `*_action` vs `*_deliver` + 2 familles de callbacks, `.touch(:column)` AR direct SQL skip validations, Mailer Preview vs Letter Opener duo, lien direct [[callbacks]] pour `after_commit` mandatory sur `deliver_later` + 3 questions style entretien dans [[../../../Entretiens/Rails/mailers]])
  - 40. Advanced Topics ✅ (jeudi 11 juin matin sem 24, 6 sections couvertes en lecture profonde — 5 notes Obsidian solides + 1 first-pass) : **Section 1 Advanced Routing** [[advanced-routing-fundamentals]] (singular resources / nested routes / member-collection / redirects + wildcards, 4 Q de session répondues, application sem 25 `routes.rb` complet posé) ; **Section 2 Controllers sans model + REST** [[controllers-without-models-and-rest-principles]] (mythe 1-controller-1-model cassé, namespace `Admin::`/`Api::V1::` + héritage `BaseController`, pattern "verbe → nom" + entrée backlog `FEATURES_FUTURES.md` `SuggestionsController`/futur model `Suggestion` Phase 4 IA) ; **Section 3 Advanced Layouts** [[advanced-layouts-and-content-for]] (`yield :name` + `content_for`/`provide`/`content_for?`, nested layouts pattern 2 préféré, body class scoping, ⭐ piège bloc `do...end` qui capture espaces, quick fixes UX/SEO N to F dans `to-do.md` Dettes techniques — titles+meta+lang+body class, locale EN appliquée après détection `I18n.locale => :en`) ; **Section 4 Metaprogramming** [[metaprogramming-ruby-and-rails-first-pass]] ⚠️ **1er passage à approfondir** (décortication ligne par ligne `GarmentFilter` avec analogie chaîne de production + 3 armes `send`/`define_method`/`method_missing` quick reference, cours dédié programmé dans `to-do.md` Priorité 1 avec 3 exos sandbox) ; **Section 5 Design Patterns + SOLID** [[solid-design-principles-and-anti-patterns]] (5 lettres décortiquées avec exemples N to F, ⭐ OCP prouvé 2× en live `GarmentFilter` PR #79 + #83, 5 anti-patterns, Q7 répondue concern `Likeable` B + OCP central, réponse 90 sec entretien clé en main) ; **Section 6 i18n** [[i18n-internationalization-fundamentals]] (config + lazy lookup `t('.title')` + interpolation/pluriels CLDR + 3 stratégies set_locale + sécurité whitelist mandatory, ⭐ **décision tranchée pas de setup pre-emptive** = YAGNI + cargo cult anti-patterns Section 5 appliqués, scope complet 7 étapes documenté `to-do.md` avec trigger explicite ; memory globale `project-nine-to-fine-locale-english` créée). **Knowledge Check (7 Q) + 3 questions style entretien 90 sec** à faire en rétro plus tard (règle péda 9).
- **Prochain (ordre Odin officiel)** :
  - 41. Websockets and ActionCable
- **Skip délibéré** (projets Odin redondants avec bootcamp + Nine to Fine) : 16 Micro-Reddit, 21 Forms, 23 Members Only!, 26 Private Events, 29 Flight Booker, 32-33 Kittens/Pexels APIs, 39 Confirmation Emails, 42 Odin Book. Leur valeur est récupérée via : (a) Nine to Fine l'aprem, (b) sous-portions isolées en exos sandbox le soir.
- **URL parcours** : https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails

## Tailwind CSS

- **Fait** : Installation + Styling with utility classes + Hover, focus and other states + Responsive design + Tailwind v4 overview + **Layout : Flexbox & Grid + Spacing & Sizing** (lundi 1 juin) + **Theme variables + Functions & Directives** (mardi 2 juin avant-midi, voir [[theme-variables-and-directives]]) + **Customization : Dark mode + Colors palette** (mercredi 3 juin avant-midi, voir [[dark-mode]] et [[colors-palette]]) + **Backgrounds + Borders + Effects + Opacity** (jeudi 4 juin avant-midi, voir [[backgrounds-borders-effects-v4]]) + **Typography : font-family, font-size, font-weight, line-height, letter-spacing, text-decoration** (lundi 8 juin avant-midi, voir [[typography-fundamentals]]) + **Transitions & Animation : transition-property, duration, timing-function, animation + accessibilité prefers-reduced-motion** (mardi 9 juin avant-midi, voir [[transitions-and-animations-fundamentals]]) + **Transforms : translate, rotate, scale, skew, transform-origin + intro 3D context (perspective, transform-3d)** (mercredi 10 juin avant-midi, voir [[transforms-fundamentals]] — composition via CSS variables Tailwind v4, GPU performance vs layout reflow, application N to F card lift / pills / press effect / modal entrance, 3 questions style entretien intégrées) + **Interactivity : 19 utilities (cursor, pointer-events, select, touch-action, scroll-behavior, scroll-snap-*, scrollbar-*, accent-color, caret-color, color-scheme, appearance, field-sizing, will-change, resize)** (jeudi 11 juin avant-midi, voir [[interactivity-fundamentals]] — ⭐ `touch-manipulation` anti delay 300ms iOS Safari, scroll-snap patterns carousel + full-page sections, `accent-color` héritable form parent, ⭐ `will-change-transform` JAMAIS partout = explosion mémoire GPU, anti-pattern `select-none` sur contenu copiable, application N to F quick wins, 3 questions style entretien intégrées)
- **Prochain (à faire dans l'ordre)** :
  1. Section **Customization avancé** (Tailwind v4 `@apply`, custom variants, custom utilities) — étape 14 dans index Tailwind
  2. Phase 1 Tailwind quasi-terminée, transition Phase 2 React (sem 26)

## React (à démarrer Phase 2, sem 26)

- **Fait** : rien
- **Prochain** : Scrimba "Learn React" (CS Career Path) + react.dev "Learn" en parallèle
- **URLs** : https://scrimba.com/learn/learnreact + https://react.dev/learn

## TypeScript (à démarrer Phase 3, sem 32)

- **Fait** : rien
- **Prochain** : Total TypeScript "Beginner's TypeScript" (gratuit, Matt Pocock)
- **URL** : https://www.totaltypescript.com/tutorials/beginners-typescript

## Next.js (Phase 4, sem 36, optionnel)

- **Fait** : rien
- **Prochain** : Learn Next.js officiel (gratuit, ~6h)
- **URL** : https://nextjs.org/learn
