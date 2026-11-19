# Hermes Handoff — Beauty Hive marketing (agent system)

**Purpose:** hand off end-to-end marketing of **Beauty Hive** (Brenda's beauty
business) to an agent system that Hermes builds and runs.
**Goal:** drive **bookings** + capture **leads to follow up with**.
**Channels:** Instagram, Meta/Facebook (page + ads), Google Ads, website.
**Framework:** "vibe marketing" (Greg Isenberg) — a team of specialized agents —
applied on top of the operator's existing Growth OS tooling.

> Status: DRAFT. Business specifics are still being validated against the live
> site, booking system, and ad accounts.

---

## 1. The business
- **What it is:** **Beauty Hive** — a **private nail studio in San Diego** (College Area /
  near SDSU / El Cajon Blvd). Solo nail artist (Brenda), appointment-based.
- **Services:** Gel-X extensions, acrylic sets, builder gel, manicure, pedicure,
  **custom nail art / designs**.
- **Positioning:** private, clean, relaxing, premium, custom work (not a discount salon).
- **Offer:** the old **$130 combo is retired** — the **current offer must be crafted**
  (Offer agent, §3; first-pass draft in §3a). Pull current service prices from the site.
- **Booking:** **Acuity Scheduling** on the site → Booking/Lead agent via Acuity API
  (User ID + API key) + webhooks (`appointment.scheduled`, `appointment.canceled`).
- **Repo:** `thebeautyhive/thebeautyhive` at `/Users/agent/code/ops/thebeautyhive`.
  Static HTML site (Vercel/Netlify). Keep private planning files outside `public/`,
  `api/`, and deploy config unless the operator explicitly asks for a site change.
- **Already in the repo (leverage, don't rebuild):** Facebook Pixel + custom events,
  Instagram API/widget, SEO optimization, and a **Google Business Profile keyword
  strategy** (local nail-salon keywords for San Diego / College Area).
- **Site pages:** `index`, `combo` (packages), `mothers-day` (seasonal promo), `welcome`.
- **Proven signal:** early FB/IG ads returned ~4x on the first $30 → product-channel fit.

## 2. Assets & access to wire up
- Instagram handle: `@isssbeenails` (`https://www.instagram.com/isssbeenails/`).
- Meta page + ad account: shared Meta API access works through Eskiin tooling.
  Confirmed Page: `Beauty Hive Studio`, Page ID `805562132646120`. Confirmed
  ad account: `Account 01`, ad account ID `242922443081874`
  (`act_242922443081874`), under Business Manager `AdEmpyrean`
  (`512724419175894`). Still confirm the connected Instagram professional
  account ID and spend permission before launch.
- **Google Ads:** account exists, but **no native Google Ads API integration yet** —
  see §8 for exactly what's needed.
- Website booking: **Acuity Scheduling** — wire the Booking/Lead agent to the Acuity
  API + webhooks (bookings are the primary conversion event / KPI source).
- **Lead destination / CRM** for non-booking leads to follow up: TODO (Acuity holds
  booked appts; decide where captured-but-not-booked leads land — a sheet/CRM).
- ⚠ **Consent gate:** confirm Brenda has authorized account access before wiring
  anything to live pages/ad spend. Treat like any client account.

## 3. Agent architecture (archetypes → Beauty Hive)
| Agent | Job for Beauty Hive | Build |
|---|---|---|
| **Offer** | craft the CURRENT offer (old $130 package retired): pull live services + pricing, package a compelling booking offer + price + guarantee/urgency; test the offer itself | **new — do first** |
| **Research** | mine the local beauty niche (IG/TikTok/Reddit/reviews) for hooks, trends, competitor offers, seasonal demand → a weekly angle/hook bank | new (light) |
| **Content** | daily Reels/TikTok + static hooks for the services/offers, caption + "book now" CTA; learn from engagement; grade what converts with the creative-DNA pattern | partly reuse |
| **Acquisition** | launch + mass-test Meta + Google ads → the booking page; keep winners, cut losers, pace budget | **reuse Growth OS** launch/scale + attribution tooling |
| **Booking / Lead** | DM auto-reply + FAQ + push-to-book (**Acuity** link); read Acuity webhooks for booked/cancelled; capture leads that don't book and **queue follow-ups** (the core goal) | new |
| **Reporting** | weekly: bookings, leads, **cost-per-booking**, top creative, next tests | reuse reporting patterns |

## 3a. First-pass offer (Offer agent draft — validate price with Brenda)
Goal: convert a local ad click → a first **Acuity booking**. It's a premium private
studio, so anchor on the experience + custom art, give a new-client reason to book
now, and add risk-reversal + real scarcity.

**Draft — "New Client Gel-X Experience"**
- **What:** Gel-X full set + a custom nail-art accent + a mini hand/paraffin treatment.
- **Price:** new-client rate `$__` (reg `$__`) — *placeholder; set from current menu.*
- **Urgency:** limited new-client spots each week (private one-artist studio → scarcity is genuine).
- **Risk reversal:** "Love your nails or a free fix within 7 days."
- **CTA:** Book on Acuity. **Non-bookers:** DM/waitlist → follow-up sequence with the offer + a design portfolio.

**Alternates to A/B (Offer agent):** `$20 off your first Gel-X set` · a fixed-price
**Gel-X + Pedi combo** · **refer-a-friend** (both get `$__`) to tap the SDSU/college crowd.

Local angles for Content/Acquisition agents: *"College Area's private nail studio,"*
*"Gel-X that lasts 3+ weeks,"* *"custom nail art near SDSU."*

## 4. What reuses existing tooling vs. new
- **Reuse (biggest advantage):** the Growth OS you already run — Meta ad
  launch/scale scripts, attribution, the **creative-intelligence pipeline** (frame
  extraction + AI vision + Creative DNA) for grading Beauty Hive creative.
- **New:** the Research agent, the Booking/Lead follow-up agent, and a Google Ads
  adapter (the Growth OS is Meta-first today).

## 5. Stack
- Orchestration: n8n (per the video) **or** the existing growthkit / agent harness —
  recommend leveraging what already runs headless here.
- Models: Claude / Codex via the existing setup.
- Ads: existing Meta tooling + the Google Ads account.
- Data: adapt the Growth OS reporting for a bookings KPI (cost-per-booking).

## 6. First 3 moves for Hermes
1. **Stand up the Beauty Hive project** (clone/create the repo + brand config; pull
   the site's services, offer, voice, booking URL).
2. **Wire the Booking/Lead agent first** — fastest ROI: capture & follow up on demand
   you already have (DMs, non-booking leads).
3. **Turn on the Acquisition agent** on a small budget → bookings, with the Reporting
   agent watching **cost-per-booking**.

## 7. Access status
| Channel | Status |
|---|---|
| Meta (page + ads) | Page visible via shared Eskiin Meta token: `Beauty Hive Studio` / `805562132646120`; ad account verified as `Account 01` / `act_242922443081874`; historical campaign `Mothers Day Combo` / `120245134448390563` sent ads to `https://beautyhivestudio.com/mothers-day`; still need IG professional account connection and spend permission |
| Acuity (bookings) | on the site — needs API key + webhook wiring |
| Google Ads | account exists — **API not set up** (see §8) |
| Instagram | `@isssbeenails` confirmed; Apify scrape refreshed 2026-07-30 via Eskiin's canonical Apify client |
| Non-booking lead CRM | TODO |

## 8. Google Cloud / Google Ads API — ✅ ACCESS KNOWN
Google Cloud Console access exists for this workstream. Keep the durable runtime
reference in this repo and continue using the existing Eskiin Google helpers when
they are the canonical path for Drive/Docs/Sheets operations.

Do not commit console exports, OAuth secrets, service account keys, or refresh
tokens. Store only paths/status here.

Creds file: `~/.config/beautyhive/google_ads.json` (outside git, chmod 600). Never commit; reference by path/env.

| Piece | Status |
|---|---|
| Google Cloud Console | ✅ access known |
| OAuth credentials | ✅ stored outside git |
| login_customer_id (MCC AdEmpyrean `345-407-2235` → `3454072235`) | ✅ |
| Beauty Hive customer_id (`794-128-5078` → `7941285078`) | ✅ confirmed accessible under the MCC |
| Auth / token exchange | ✅ verified on **API v21** |
| Real data queries | ❌ **BLOCKED** — developer token is **test-access only** |
| Google Workspace Docs/Drive helper | ✅ use Eskiin repo OAuth helper when needed: `src/growthkit/utils/google_drive_auth.py` with repo-local credentials outside commits |

⚠ **Reality check:** OAuth is fully wired, but an actual GAQL query on Beauty Hive
*and* Prima returns *"developer token is only approved for use with test accounts —
apply for Basic or Standard access."* So **no live reporting/management works until
Basic access is approved.** That application is the critical path — submit the tool
doc (Google Doc: created; markdown at `ouattribution/docs/google-ads-api-tool-documentation.md`).
Also applies to **EatPrima / Prima** (`651-591-4497`), config at
`EatPrima/config/google_ads/config.json` → shared creds `~/.config/adempyrean/google_ads.json`.
Install `google-ads` (python) for the Acquisition agent's Google adapter once access lands.

## 9. Open items to finish this doc
- Connected Instagram professional account ID and Meta spend permission.
- Where non-booking **follow-up leads** should live (sheet/CRM).
