#!/usr/bin/env bash
# Re-encrypt Mendel Exit Comps after source changes.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PASSWORD='ianandade'
SOURCE="$DIR/source/Mendel_Exit_Comps_Dashboard.html"
SALT=$(python3 -c "import json; print(json.load(open('$DIR/.staticrypt.json'))['salt'])")
mkdir -p /tmp/npm-stage /tmp/npm-cache /tmp/sc-out
[ -d /tmp/npm-stage/node_modules/staticrypt ] || npm install staticrypt --prefix /tmp/npm-stage --cache /tmp/npm-cache --silent
TEMPLATE="$(cd "$DIR/../skills/password-protected-site/templates/b10_password_template.html" 2>/dev/null && pwd)" || TEMPLATE=""
cd /tmp
if [ -n "$TEMPLATE" ] && [ -f "$TEMPLATE" ]; then
  /tmp/npm-stage/node_modules/.bin/staticrypt "$SOURCE" -p "$PASSWORD" --short --remember 14 \
    --template-title "Mendel Exit Comps · Base10" \
    --template-instructions "Enter the password to view the Mendel exit comps dashboard." \
    --template "$TEMPLATE" \
    --template-color-primary "#45AEEB" --template-color-secondary "#F4F8FB" \
    -s "$SALT" -c false -d /tmp/sc-out
else
  /tmp/npm-stage/node_modules/.bin/staticrypt "$SOURCE" -p "$PASSWORD" --short --remember 14 \
    --template-title "Mendel Exit Comps · Base10" \
    --template-instructions "Enter the password to view the Mendel exit comps dashboard." \
    -s "$SALT" -c false -d /tmp/sc-out
fi
sed -i 's|<title>Protected Page</title>|<title>Mendel Exit Comps · Base10</title>|' /tmp/sc-out/source.html
cp /tmp/sc-out/source.html "$DIR/index.html"
echo "Re-encrypted. Commit and push from $DIR."
