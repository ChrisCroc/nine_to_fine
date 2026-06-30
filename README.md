# Nine to Fine

A wardrobe and outfit-composition app: catalogue your clothes, build outfits from them, and share them socially (likes, comments, follows). Built as a full-stack showcase project — product thinking on top of a production Rails 8 codebase.

🔗 **Live demo: [ninetofine.app](https://ninetofine.app)**

**Stack:** Ruby on Rails 8.1 · Hotwire (Turbo + Stimulus) · Tailwind CSS v4 · PostgreSQL · RSpec · Deployed with Kamal (Docker) on Hetzner

---

## About

Nine to Fine turns a personal wardrobe into a small social product. You add garments (with photos, category, colour, brand, tags), assemble them into outfits, browse and filter your collection, and interact with other users' outfits. It is intentionally built as a **server-rendered Hotwire monolith** — no SPA — to keep the architecture cohesive and the UX fast.

The project doubles as a portfolio piece bridging **product** and **engineering**: every feature is a deliberate product decision (what "public", "social", or "suggested" should mean) implemented with production-grade Rails patterns.

## Features

- **Wardrobe management** — CRUD for garments with image upload (Active Storage + libvips variants), category, colour, brand and free-form tags.
- **Outfit composition** — build outfits from existing garments (`has_many :through`) with an adaptive photo collage.
- **Filtering & search** — combinable filters (colour / category / tag / brand) and live name search, served through a dedicated Query Object and Turbo Frames.
- **Social layer** — likes, comments and follows, updated in real time via Turbo Streams broadcasts.
- **Authentication** — Devise with a custom `username`, dedicated profile pages.
- **AI outfit suggester** *(in progress)* — outfit suggestions powered by the Anthropic API, as a service layer (`app/services/ai/`).

## Technical highlights

- **Real-time UI with Turbo Streams** — likes, comments and follow buttons update live through Action Cable broadcasts (`after_create_commit { broadcast_… }`) over Solid Cable, plus Stimulus for optimistic UI.
- **Three deliberate association models** — `Like` polymorphic (OCP), `Comment` FK-direct (YAGNI), `Follow` self-referential user→user with counter caches.
- **Query Object** — `GarmentFilter` builds a lazy, combinable filter pipeline (`inject` + safelisted dynamic dispatch), open for extension without modifying the core (`brand` and `search` filters added with zero changes to the apply loop).
- **Test suite** — ~165 RSpec examples (models + request specs) with factory_bot, including cross-user **IDOR sentinels** on every owner-scoped action.
- **Security-conscious** — strong scoping (`current_user.X.find`), `params.expect`, SQL-safe `ILIKE` searches.
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
| Testing | RSpec, factory_bot |
| Deployment | Kamal, Docker, Hetzner, GitHub Container Registry |

## Local setup

```bash
# Prerequisites: Ruby 3.3.x, PostgreSQL, libvips
bin/setup            # installs gems, prepares the database
bin/dev              # starts the app (Rails + Tailwind watcher) on http://localhost:3000
```

Run the test suite:

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
