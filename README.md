# OhRats UI

Shared visual language for OhRats Technologies, hosted at `https://assets.ohrats.party`.

## Rolling `/v1/` channel (recommended for products)

Served with a 5-minute TTL (`max-age=300, stale-while-revalidate=60`) so design updates propagate across every OhRats site automatically:

- `/v1/ohrats.css` — core tokens, base reset, canonical public header & footer, `.or-article`
- `/v1/landing.css` — canonical two-column product landing hero (`.or-hero`)
- `/v1/shell.css` — canonical authenticated app shell & collapsible sidebar (`.site-shell`, `.site-sidebar`, `.sidebar-toggle`, `.or-icon-sidebar`)
- `/v1/reading.css` — long-form reading & learning typography (`.or-reading`, `.or-callout`)
- `/v1/copy.css`, `/v1/states.css`, `/v1/status.css` — optional primitives
- `/v1/theme.js`, `/v1/menu.js` — shared theme toggle and mobile navigation
- `/v1/logo.svg`, `/v1/sidebar.svg`, `/v1/github.svg`, `/v1/copy.svg` — shared marks
- `/v1/manifest.json` — map from logical names to immutable `/assets/*` URLs

Immutable content-fingerprinted URLs under `/assets/*` remain published with 1-year caching for pinned consumers.
