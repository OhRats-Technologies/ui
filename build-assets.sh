#!/bin/sh
set -eu

src="${1:-.}"
out="${2:-/out}"
assets="$out/assets"
v1="$out/v1"

rm -rf "$out"
mkdir -p "$assets" "$v1"

hash_file() {
    sha256sum "$1" | cut -c1-12
}

manifest="$v1/manifest.json"
printf '{\n' > "$manifest"
first=1

publish() {
    source="$1"
    public_name="$2"
    ext=".${public_name##*.}"
    stem="${public_name%$ext}"
    hash="$(hash_file "$source")"
    target="$stem.$hash$ext"
    cp "$source" "$assets/$target"
    cp "$source" "$v1/$public_name"
    if [ "$first" = 1 ]; then
        first=0
    else
        printf ',\n' >> "$manifest"
    fi
    printf '  "%s": "/assets/%s"' "$public_name" "$target" >> "$manifest"
}

github_hash="$(hash_file "$src/images/github.svg")"
github_target="github.$github_hash.svg"
copy_hash="$(hash_file "$src/images/copy.svg")"
copy_target="copy.$copy_hash.svg"
sidebar_hash="$(hash_file "$src/images/sidebar.svg")"
sidebar_target="sidebar.$sidebar_hash.svg"
font_hash="$(hash_file "$src/fonts/MesloLGSNerdFontMono-Regular.woff2")"
font_target="MesloLGSNerdFontMono-Regular.$font_hash.woff2"

awk -v target="/assets/$github_target" '{ gsub(/\/github\.svg/, target); print }' \
    "$src/css/header.css" > "$out/header.css"
awk -v target="/assets/$sidebar_target" '{ gsub(/\/sidebar\.svg/, target); print }' \
    "$src/css/shell.css" > "$out/shell.css"

publish "$src/images/github.svg" github.svg
publish "$src/images/copy.svg" copy.svg
publish "$src/images/sidebar.svg" sidebar.svg
publish "$src/fonts/MesloLGSNerdFontMono-Regular.woff2" MesloLGSNerdFontMono-Regular.woff2

awk -v target="/assets/$copy_target" '{ gsub(/\/copy\.svg/, target); print }' \
    "$src/css/copy.css" > "$out/copy.css"
publish "$out/copy.css" copy.css

awk -v target="/assets/$font_target" '{ gsub(/\/MesloLGSNerdFontMono-Regular\.woff2/, target); print }' \
    "$src/css/tokens.css" > "$out/tokens.css"

cat "$out/tokens.css" "$src/css/base.css" "$out/header.css" "$src/css/footer.css" "$src/css/article.css" > "$out/ohrats.css"
publish "$out/ohrats.css" ohrats.css
publish "$out/tokens.css" tokens.css
publish "$src/css/landing.css" landing.css
publish "$out/shell.css" shell.css
publish "$src/css/reading.css" reading.css
publish "$src/css/states.css" states.css
publish "$src/css/status.css" status.css
publish "$src/css/base.css" base.css
publish "$out/header.css" header.css
publish "$src/css/footer.css" footer.css
publish "$src/css/article.css" article.css
publish "$src/js/theme.js" theme.js
publish "$src/js/menu.js" menu.js
publish "$src/images/logo.png" logo.png
publish "$src/images/logo.svg" logo.svg

printf '\n}\n' >> "$manifest"
rm "$out/ohrats.css" "$out/header.css" "$out/shell.css" "$out/copy.css" "$out/tokens.css"
