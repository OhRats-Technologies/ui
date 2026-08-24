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
    cat >> "$redirects" <<EOF
location = /latest/$public_name {
    add_header Access-Control-Allow-Origin "*" always;
    add_header Cache-Control "public, max-age=0, must-revalidate" always;
    add_header Cloudflare-CDN-Cache-Control "public, max-age=0, must-revalidate" always;
    return 307 /assets/$target;
}
EOF
}

cat "$src/css/tokens.css" "$src/css/base.css" "$src/css/header.css" > "$out/ohrats.css"
publish "$out/ohrats.css" ohrats.css
publish "$src/css/tokens.css" tokens.css
publish "$src/css/base.css" base.css
publish "$src/css/header.css" header.css
publish "$src/js/theme.js" theme.js
publish "$src/js/menu.js" menu.js
publish "$src/images/logo.png" logo.png
publish "$src/images/github.svg" github.svg

rm "$out/ohrats.css"
