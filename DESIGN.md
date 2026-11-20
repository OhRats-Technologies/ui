# OhRats Design

Tactile, structured, and intentionally restrained: Swiss Railway precision × Warm Sepia Blueprint clarity × Albers/Mondrian warm color-blocking × Braun / Teenage Engineering hardware craft.

## Color

| Token | Light | Dark | Role |
| --- | --- | --- | --- |
| `--or-bg` | `#efede5` | `#1a1a1b` | Warm archival bone / matte charcoal canvas |
| `--or-surface` | `#ffffff` | `#202021` | Elevated cards, code blocks, dialogs |
| `--or-ivory` | `#f4f3df` | `#f4f3df` | Warm ivory ink on dark hardware tiles |
| `--or-text` | `#1a1a1b` | `#efede5` | Primary ink |
| `--or-text-muted` | `#595550` | `#a3a393` | Secondary prose & metadata |
| `--or-border` | `#634936` | `#634936` | Espresso structural hairlines |
| `--or-accent` | `#c95b2b` | `#e27a3b` | Restrained Braun terracotta-amber signal accent |

## Modules

- **`/v1/ohrats.css`** — tokens, base reset, canonical public header & footer, `.or-article`
- **`/v1/landing.css`** — WakeBar-pattern two-column product hero (`.or-hero`)
- **`/v1/shell.css`** — canonical authenticated sidebar shell & collapse toggle (`.site-shell`, `.or-icon-sidebar`)
- **`/v1/reading.css`** — book-grade reading & learning typography (`.or-reading`, `.or-callout`)
- **`/v1/copy.css`**, **`/v1/states.css`**, **`/v1/status.css`** — copy fields, semantic status colors, error/404 pages

## Principles

- Prefer whitespace, typography, and real structure over decoration.
- Use `--or-accent` sparingly for meaning-bearing active states, status pips, and callout borders.
- Support light and dark themes cleanly with `--or-*` tokens.
- Never fork the shared header, footer, sidebar, or collapse icon in a product repo.
