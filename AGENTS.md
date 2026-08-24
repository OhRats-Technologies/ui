# OhRats UI

- Static, technology-neutral shared visual language served from `assets.ohrats.party`.
- Shared CSS variables use the `--or-*` namespace.
- Keep this repo limited to genuinely cross-product primitives: tokens, base styles, canonical header behavior, theme/menu behavior, and shared brand assets.
- Product-specific components and layouts stay in their product repos.
- `theme.js` shares theme preference across `*.ohrats.party`.
- `/current/*` is the stable consumer URL and serves the current bytes directly with revalidation. `/assets/*` is content-fingerprinted and immutable for one year; `/latest/*` is compatibility-only. Do not use redirects or `no-store` for public static aliases.
- Keep the structure small and semantic; avoid arbitrary CSS module proliferation.
