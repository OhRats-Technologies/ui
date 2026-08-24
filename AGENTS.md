# OhRats UI

- Static, technology-neutral shared visual language served from `assets.ohrats.party`.
- Shared CSS variables use the `--or-*` namespace.
- Keep this repo limited to genuinely cross-product primitives: tokens, base styles, canonical header behavior, theme/menu behavior, and shared brand assets.
- Cross-product UI principles live in `../handbook/design/ui.md`; when review feedback reveals a reusable rule, update the guideline/shared primitive instead of fixing only one product.
- Product-specific components and layouts stay in their product repos.
- `theme.js` shares theme preference across `*.ohrats.party`.
- Consumers use content-fingerprinted `/assets/*` URLs directly. Shared assets are immutable for one year; do not add mutable aliases, redirects, or `no-store` public asset paths.
- Keep the structure small and semantic; avoid arbitrary CSS module proliferation.
