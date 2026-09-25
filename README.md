# Nine to Fine

A wardrobe and outfit-composition app: catalogue your clothes, build outfits from them, and share them socially (likes, comments, follows). Built as a full-stack showcase project — product thinking on top of a production Rails 8 codebase.

🔗 **Live demo: [ninetofine.app](https://ninetofine.app)**

**Stack:** Ruby on Rails 8.1 · Hotwire (Turbo + Stimulus) · Tailwind CSS v4 · PostgreSQL · RSpec · Deployed with Kamal (Docker) on Hetzner

---

## About

Nine to Fine turns a personal wardrobe into a small social product. You add garments (with photos, category, colour, brand, tags), assemble them into outfits, browse and filter your collection, discover what other members share in a public feed, and ask an AI stylist to dress you from your own wardrobe. It is intentionally built as a **server-rendered Hotwire monolith** — no SPA — to keep the architecture cohesive and the UX fast.

The project doubles as a portfolio piece bridging **product** and **engineering**: every feature is a deliberate product decision (what "public", "social", or "suggested" should mean) implemented with production-grade Rails patterns.

## Features

- **Wardrobe management** — CRUD for garments with image upload (Active Storage + libvips variants), category, colour, brand and free-form tags.
- **AI auto-tagging** — choosing a photo pre-fills the garment form (name, colour, category, formality, season, pattern) from a vision call to Claude; the colour, category and taxonomy values it returns are checked against the app's own lists before they reach the form.
- **Outfit composition** — build outfits from existing garments (`has_many :through`) with an adaptive photo collage. Outfits are private by default and can be made public.
- **AI stylist** — describe an occasion and get an outfit built from your own wardrobe: it can be composed around pieces you pick, takes the live weather at your position into account when you share it (Open-Meteo), and "Regenerate" sets aside the pieces it already proposed (shoes excepted, the scarcest category in most wardrobes). The suggestion runs in a background job and is streamed back to the page.
- **Explore feed** — signed-in members browse everyone's public outfits, newest first, with a "Load more" button that appends the next batch without reloading; visitors see real outfits on the landing page before signing up.
- **Filtering & search** — combinable filters (colour / category / tag / brand) and live name search, served through a dedicated Query Object and Turbo Frames.
- **Social layer** — likes, comments and follows, updated in real time via Turbo Streams broadcasts.
- **Authentication** — Devise with a custom `username`, dedicated profile pages, and account deletion confirmed by password.

## Technical highlights

- **Real-time UI with Turbo Streams** — likes, comments and follow buttons update live through Action Cable broadcasts (`after_create_commit { broadcast_… }`) over Solid Cable, plus Stimulus for optimistic UI.
- **Three deliberate association models** — `Like` polymorphic (OCP), `Comment` FK-direct (YAGNI), `Follow` self-referential user→user with counter caches.
- **Query Object** — `GarmentFilter` builds a lazy, combinable filter pipeline (`inject` + safelisted dynamic dispatch), open for extension without modifying the core (`brand` and `search` filters added with zero changes to the apply loop).
- **LLM integration as a service layer** — `app/services/ai/` calls the Anthropic API with tool use for structured output; the garment ids and attribute values coming back from the model are re-validated server-side, each call carries its own time budget, and a provider outage (timeout, rate limit, overload) during photo analysis degrades to a 422 and a manual form instead of a 500.
- **Graceful third-party dependency** — the weather service is bounded by timeouts, cached per rounded position, and returns nothing rather than failing: the stylist keeps working when Open-Meteo does not.
- **Test suite** — ~350 RSpec examples with factory_bot: models, request, service, job, view and **system specs** (headless Chrome through Capybara + Selenium, covering Turbo and Stimulus behaviour a request spec cannot see), plus cross-user **IDOR sentinels** on every owner-scoped action. External APIs are stubbed in the tests.
- **Security-conscious** — strong scoping (`current_user.X.find`), `params.expect`, malformed filter parameters answered with a 400, SQL-safe `ILIKE` searches.
- **Production deployment** — Dockerised and shipped with **Kamal** to a Hetzner server: image on GitHub Container Registry, PostgreSQL as a Kamal accessory, automatic Let's Encrypt TLS via kamal-proxy. See [Deployment](#deployment).

## Tech stack

| Layer | Choice |
|---|---|
| Framework | Ruby on Rails 8.1 (Ruby 3.3) |
| Front-end | Hotwire (Turbo + Stimulus), Tailwind CSS v4, Propshaft, Importmap |
| Database | PostgreSQL |
| Background / cache / cable | Solid Queue, Solid Cache, Solid Cable (DB-backed) |
| Auth | Devise |
| Storage | Active Storage + libvips |
| AI | Anthropic API (Claude — tool use and vision) |
| Pagination | Pagy |
| Testing | RSpec, factory_bot, Capybara + Selenium (headless Chrome) |
| Deployment | Kamal, Docker, Hetzner, GitHub Container Registry |

## Local setup

```bash
# Prerequisites: Ruby 3.3.x, PostgreSQL, libvips
bin/setup            # installs gems, prepares the database
bin/dev              # starts the app (Rails + Tailwind watcher) on http://localhost:3000
```

Run the test suite (the system specs need Google Chrome installed):

```bash
bin/rspec
```

## Deployment

The app is deployed with [Kamal](https://kamal-deploy.org). The image is built locally, pushed to GitHub Container Registry, and run on a Hetzner server alongside a PostgreSQL accessory container. TLS is handled automatically by kamal-proxy (Let's Encrypt).

```bash
bin/kamal deploy     # build, push, and roll out a new version
```

---

*Built by [Christophe Crokaert](https://github.com/ChrisCroc).*
