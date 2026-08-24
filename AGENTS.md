# OhRats UI

- Static, technology-neutral shared visual language served from `assets.ohrats.party`.
- Shared CSS variables use the `--or-*` namespace.
- Keep this repo limited to genuinely cross-product primitives: tokens, base styles, canonical header behavior, theme/menu behavior, and shared brand assets.
- Product-specific components and layouts stay in their product repos.
- `theme.js` shares theme preference across `*.ohrats.party`.
- `/latest/*` is a stable, revalidated redirect to a content-fingerprinted `/assets/*` file. `/assets/*` is immutable and cached for one year.
- Keep the structure small and semantic; avoid arbitrary CSS module proliferation.
