# OhRats UI

Shared visual language for OhRats Technologies.

Consumers use stable `/current/*` URLs. Each deployment redirects those short-lived aliases to content-fingerprinted `/assets/*` files, so callers never manage cache versions manually. Alias redirects cache for five minutes in browsers and at Cloudflare; fingerprinted assets are immutable. `/latest/*` remains as a compatibility alias.
