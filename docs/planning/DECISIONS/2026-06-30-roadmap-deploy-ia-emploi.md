# Décision stratégique — Roadmap déploiement / IA / emploi (mardi 30 juin 2026)

**Contexte** : lundi 29 juin au soir, Chris a fixé des jalons « non négociables » (IA suggester + public/privé US18 + app déployée **avant mi-juillet**) qui **contredisent** le planning Phase 2 (IA en Phase 4 sept, US18 reporté sine die, déploiement sem 29). Ce doc tranche l'arbitrage entre ces jalons, le démarrage React (Phase 2, démarrée le 29 juin) et la recherche d'emploi (livrable borné fin sept, déjà glissé d'1 sem par les vacances).

**Statut** : ✅ acté mardi 30 juin 2026. À ne pas re-litiger (sauf fait nouveau).

---

## 1. Hiérarchie des priorités (par impact réel sur l'objectif emploi)

1. **Une URL live** — levier #1 pour la recherche d'emploi (un lien cliquable >> un repo GitHub). Manquant aujourd'hui → **déploiement = priorité technique #1**, pas un chantier de sem 29.
2. **Recherche d'emploi lancée** — le vrai livrable borné fin sept, déjà glissé d'1 sem. **Ne cède pas.**
3. **IA suggester** — le vrai différenciateur (vitrine annoncée au PLANNING), du Rails pur (service object + API Anthropic), ne dépend PAS de React. Priorité technique #2.
4. **US18 public/privé** — **poussé**. C'est du polish produit (n'impressionne pas un recruteur), le plus risqué côté timeline (brainstorm produit dédié requis + 3-5 j + inconnues de design). Sorti des « non négociables mi-juillet ».

## 2. Ce qui cède

- **US18** → repoussé (post-déploiement, ou post-emploi). 100 % du code Follow déjà livré survit à la décision.
- **React** → **non arrêté** : plancher quotidien **1-2h/jour**, continu mais non prioritaire (sur le créneau d'allongement de journée, jamais au détriment des priorités 1-2). Garde l'élan post-vacances + le fil Scrimba sans « reconstruire sur du flou ».

## 3. Pitch emploi — correction honnête

- **Capital réel et fort** : app Rails fonctionnelle **shippée + testée** (auth, CRUD, Active Storage, composition, social temps réel likes/comments/follow en Turbo Streams, 113 specs RSpec).
- ⚠️ **Ne PAS revendiquer React ni TypeScript sur le CV pour l'instant** : React = 1,5 j de Scrimba (piège en entretien), TypeScript = zéro fait. Survendre la largeur = le pitch de tous les juniors, le plus facile à percer. **La différenciation = profondeur Rails + app déployée live.** React/TS = « en cours d'apprentissage », cadrage junior honnête.

## 4. Déploiement — Kamal sur Hetzner (vérifié 30 juin)

- **Choix : Kamal → VPS Hetzner CX22**, fallback **Fly.io** si Kamal bloque (déjà documenté `phase-2.md`).
- **Pourquoi Kamal vs VPS hand-rolled** : Kamal est l'outil **par défaut de Rails 8** (`Dockerfile` + `config/deploy.yml` déjà générés) → signal « à jour Rails moderne » + mène plus vite à l'URL live + tu touches quand même Docker/VPS/SSL. Hand-roller nginx/systemd = time sink qui ne paie pas pour un poste Rails junior (compterait pour du DevOps/SRE). ⭐ Le vrai signal d'entretien = **comprendre ce qui se passe dessous** (Kamal orchestre des containers Docker sur le VPS, proxy gère le SSL), pas l'outil. → prévoir 30 min pour savoir expliquer chaque couche.
- **Coûts vérifiés (30 juin 2026)** : Hetzner CX22 = **4,49 €/mois** (hausse avril/juin 2026) ; domaine .com Porkbun = **~10 $/an** (DNS + SSL inclus). **Total ≈ 5,5 €/mois.** Coût = non-sujet.
- ⚠️ **Méthode déploiement** : vérifier la doc Kamal/Rails 8 à jour (WebFetch) AVANT toute commande, expliquer chaque ligne, pas de trial-and-error (règle `feedback-verify-external-setup`).

## 5. Gate technique avant déploiement — Bullet propre

Ne pas déployer une app où Bullet signale des N+1 (mauvais signal). Deux cas distincts :
- **Régression Bullet depuis Follow PR #125** (notée to-do) : cause inconnue → **vrai candidat à corriger**.
- **Warning POST /outfits create** : investigué le 13 juin, **faux positif** (cascade `active_storage_validations` + `spoofing_protection: true` qui télécharge le blob de chaque Garment au save — pas un N+1 de requête, le « fix » eager loading fait râler Bullet dans l'autre sens). → **safelist documenté + commentaire justifiant** (bonne histoire d'entretien).
- Estimation : 0,5-1 j.

## 6. Recherche d'emploi — assets d'abord, puis candidatures actives

- **Ordre interne** : préparer les assets (README propre + nettoyage doc public + LinkedIn dev-first + CV) **AVANT** de candidater activement. ⚠️ **Garde-fou anti-perfectionnisme** : prép bornée à 1-2 j, pas un trou noir de polish. 2e passe rapide pour insérer l'**URL live** une fois déployé.
- **Sous-décision différée (au moment de l'asset-prep)** : nettoyage de la doc « aux yeux du public » — le repo expose `PLANNING.md`, `docs/planning/`, le SUIVI et le `CLAUDE.md` (révèle le mode coach IA). Option = déplacer les fichiers méta hors repo public OU README porte d'entrée propre. À trancher.
- **Canaux** : programme **job-seeker Le Wagon** (accès actif — réseau alumni + entreprises partenaires + coaching) = canal prioritaire, + sourcing ciblé (boards FR/remote). Candidatures de qualité, pas spray. Claude aide sur le où + le comment.

## 7. Séquençage des ~2 semaines

| Ordre | Workstream | Estimation |
|---|---|---|
| 1 | **Bullet propre** (gate pré-déploiement) | 0,5-1 j |
| 2 | **Déploiement Kamal/Hetzner** (provision aujourd'hui — lead time = heures) | 1,5-2 j (1ère fois) |
| 3 | **Asset-prep emploi** (README + doc cleanup + LinkedIn + CV) → 2e passe URL live → **candidatures actives** | 1-2 j bornés |
| 4 | **IA suggester** (ship sur l'app déjà live) | 3-4 j |
| 5 | **US18** | poussé |
| — | **React** plancher 1-2h/jour, continu | quotidien |

Tenu **uniquement** parce que US18 sort et React est bridé. ~6-9 j de focus + React quotidien + admin emploi ≈ 2 semaines pleines. **Tendu mais plausible.** Capacité rachetée : Chris prêt à +1-2h/jour + samedi matin + dimanche aprem.

## 8. Plan réaliste du jour (mardi 30 juin)

Séquence validée = **(B)** : provisionner l'infra d'abord (lance la propagation DNS), Bullet ensuite.
1. Provisionner domaine Porkbun + Hetzner CX22 (~30 min).
2. Bullet gate (~demi-journée).
3. React — plancher 2h.
4. Démarrer déploiement Kamal (app joignable aujourd'hui ; domaine+SSL finalisant auj/demain selon propagation).
5. README brouillon si énergie ; **CV + LinkedIn → demain** (avec URL live).

⚠️ **« Tout aujourd'hui » (déploiement fini + Bullet + README/CV/LinkedIn finalisés) = irréaliste** (~4-5 j de travail). Les heures sup rachètent le budget des 2 semaines, pas les dépendances dures du jour (propagation DNS, debug 1er déploiement).

---

## Prochaines étapes (chaque feature = son propre brainstorm)

- **Déploiement** : procédural — guidage step-by-step avec doc Kamal vérifiée.
- **IA suggester** : brainstorm produit dédié (prompt design, service object, `SuggestionsController` + futur model `Suggestion` — cf. `FEATURES_FUTURES.md`).
- **US18** : brainstorm produit dédié (sémantique public/privé, gating follow, avatar, nav tag — cf. brief `FEATURES_FUTURES.md`).
