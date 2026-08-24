#!/bin/sh
set -eu

src="${1:-.}"
out="${2:-/out}"
assets="$out/assets"
redirects="$out/redirects.conf"

rm -rf "$out"
mkdir -p "$assets"
: > "$redirects"

hash_file() {
    sha256sum "$1" | cut -c1-12
}

publish() {
    source="$1"
    public_name="$2"
    ext=".${public_name##*.}"
    stem="${public_name%$ext}"
    hash="$(hash_file "$source")"
    target="$stem.$hash$ext"
    cp "$source" "$assets/$target"
    for alias in current latest; do
        cat >> "$redirects" <<EOF
location = /$alias/$public_name {
    add_header Access-Control-Allow-Origin "*" always;
    add_header Cache-Control "public, max-age=300, must-revalidate" always;
    add_header Cloudflare-CDN-Cache-Control "public, max-age=300, must-revalidate" always;
    return 307 /assets/$target;
}
EOF
    done
}

github_hash="$(hash_file "$src/images/github.svg")"
github_target="github.$github_hash.svg"

# Shared CSS is fingerprinted together with the GitHub icon, so its internal
# dependency can point directly at the immutable asset instead of paying the
# stable /current/* redirect on every page load.
awk -v target="/assets/$github_target" '{ gsub(/\/current\/github\.svg/, target); print }' \
    "$src/css/header.css" > "$out/header.css"

publish "$src/images/github.svg" github.svg
cat "$src/css/tokens.css" "$src/css/base.css" "$out/header.css" > "$out/ohrats.css"
publish "$out/ohrats.css" ohrats.css
publish "$src/css/tokens.css" tokens.css
publish "$src/css/base.css" base.css
publish "$out/header.css" header.css
publish "$src/js/theme.js" theme.js
publish "$src/js/menu.js" menu.js
publish "$src/images/logo.png" logo.png
publish "$src/images/logo.svg" logo.svg

rm "$out/ohrats.css" "$out/header.css"
