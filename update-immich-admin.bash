#!/bin/bash

# --- KONFIGURATION ---
DB_CONTAINER="immich_postgres"
SERVER_CONTAINER="immich_server"
DB_NAME="immich"
DB_USER="postgres"

# Ziel-Daten
TARGET_EMAIL="admin@deine-domain.de"
TARGET_NAME="Administrator"
TARGET_PASSWORD="DeinSicheresPasswort123!"

echo "--- Starte Immich Admin Update ---"

# 1. E-Mail und Admin-Status in der DB setzen
echo "[1/2] Aktualisiere E-Mail und Name in der Datenbank..."
docker exec -i "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" <<EOF
UPDATE users
SET email = '$TARGET_EMAIL',
    name = '$TARGET_NAME',
    "isAdmin" = true
WHERE "isAdmin" = true OR email = '$TARGET_EMAIL';
EOF

# 2. Passwort über die Immich-CLI setzen
# Das Tool 'immich-admin' ist der offizielle Weg, Passwörter zu ändern.
echo "[2/2] Setze neues Passwort für den Admin-Account..."
docker exec -it "$SERVER_CONTAINER" immich-admin reset-admin-password --password "$TARGET_PASSWORD"

if [ $? -eq 0 ]; then
    echo -e "\n✅ ERFOLG: Admin-Konto wurde aktualisiert!"
    echo "Login: $TARGET_EMAIL"
    echo "Passwort: $TARGET_PASSWORD"
else
    echo -e "\n❌ FEHLER: Das Passwort konnte nicht gesetzt werden."
    exit 1
fi
