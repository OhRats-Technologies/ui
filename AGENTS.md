# OhRats UI

- Static, technology-neutral shared visual language served from `assets.ohrats.party`.
- Shared CSS variables use the `--or-*` namespace.
- Keep this repo limited to genuinely cross-product primitives: tokens, base styles, canonical header behavior, theme/menu behavior, and shared brand assets.
- Product-specific components and layouts stay in their product repos.
- `theme.js` shares theme preference across `*.ohrats.party`.
- `/current/*` is the stable consumer URL and redirects to a content-fingerprinted `/assets/*` file. The alias itself is never cached because Cloudflare's zone TTL otherwise overrides revalidation. `/assets/*` is immutable for one year; `/latest/*` is compatibility-only.
- Keep the structure small and semantic; avoid arbitrary CSS module proliferation.
