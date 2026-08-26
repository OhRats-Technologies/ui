# OhRats Design

Minimal, data-first, and slightly brutalist: sharp edges, visible borders, warm neutrals, and monospaced technical detail.

## Color

| Token | Light | Dark |
| --- | --- | --- |
| Background | `#efede5` | `#1a1a1b` |
| Surface | `#ffffff` | `#202021` |
| Text | `#1a1a1b` | `#efede5` |
| Border | `#634936` | `#634936` |

Optional `states.css` adds semantic `--or-positive` and `--or-negative` tokens for compact status indicators. Use them for meaning-bearing state, not decoration.

## Type

- Inter for prose and headings.
- Space Mono for labels, numbers, and technical data.
- Use the shared `.or-article` / `.or-article-header` / `.or-article-content` primitive for long-form editorial and documentation articles. Do not recreate its width or typography in product-local CSS.

## Principles

- Prefer whitespace and typography over decoration.
- Use sharp corners and thin visible borders.
- Keep color restrained.
- Support light and dark themes with tokens.
