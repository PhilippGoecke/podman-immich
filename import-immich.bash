#!/bin/bash

# --- KONFIGURATION ---
IMMICH_URL="http://DEINE-IP:2283/api"
IMMICH_KEY="DEIN_API_KEY_HIER"
IMPORT_PATH="/pfad/zu/deinen/bildern"

# 1. Login (erstellt auth.yml in ~/.config/immich)
echo "Authentifiziere bei Immich..."
immich login "$IMMICH_URL" "$IMMICH_KEY"

# 2. Rekursiver Upload
# -r: Unterverzeichnisse einbeziehen
# --album-name: (Optional) Erstellt direkt ein Album aus dem Ordnernamen
echo "Starte Import von: $IMPORT_PATH"
immich upload --recursive "$IMPORT_PATH"
#podman run --rm -v $(pwd):/import ghcr.io/immich-app/immich-cli:latest upload -r "$IMPORT_PATH"

echo "Import abgeschlossen!"
