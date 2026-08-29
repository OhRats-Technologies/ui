#!/bin/sh
set -eu

src="${1:-.}"
out="${2:-/out}"
assets="$out/assets"

rm -rf "$out"
mkdir -p "$assets"

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
}

github_hash="$(hash_file "$src/images/github.svg")"
github_target="github.$github_hash.svg"
copy_hash="$(hash_file "$src/images/copy.svg")"
copy_target="copy.$copy_hash.svg"
font_hash="$(hash_file "$src/fonts/MesloLGSNerdFontMono-Regular.woff2")"
font_target="MesloLGSNerdFontMono-Regular.$font_hash.woff2"

# Shared CSS is fingerprinted together with the GitHub icon, so its internal
# dependency points directly at the immutable asset.
awk -v target="/assets/$github_target" '{ gsub(/\/github\.svg/, target); print }' \
    "$src/css/header.css" > "$out/header.css"

publish "$src/images/github.svg" github.svg
publish "$src/images/copy.svg" copy.svg
publish "$src/fonts/MesloLGSNerdFontMono-Regular.woff2" MesloLGSNerdFontMono-Regular.woff2
awk -v target="/assets/$copy_target" '{ gsub(/\/copy\.svg/, target); print }' \
    "$src/css/copy.css" > "$out/copy.css"
publish "$out/copy.css" copy.css
awk -v target="/assets/$font_target" '{ gsub(/\/MesloLGSNerdFontMono-Regular\.woff2/, target); print }' \
    "$src/css/tokens.css" > "$out/tokens.css"
cat "$out/tokens.css" "$src/css/base.css" "$out/header.css" "$src/css/footer.css" "$src/css/article.css" > "$out/ohrats.css"
publish "$out/ohrats.css" ohrats.css
publish "$out/tokens.css" tokens.css
publish "$src/css/states.css" states.css
publish "$src/css/base.css" base.css
publish "$out/header.css" header.css
publish "$src/css/footer.css" footer.css
publish "$src/css/article.css" article.css
publish "$src/js/theme.js" theme.js
publish "$src/js/menu.js" menu.js
publish "$src/images/logo.png" logo.png
publish "$src/images/logo.svg" logo.svg

rm "$out/ohrats.css" "$out/header.css" "$out/copy.css" "$out/tokens.css"
