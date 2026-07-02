#!/system/bin/sh

MODDIR=/data/adb/modules/integrityfixer
. "$MODDIR/config/settings.conf"

TITLE="Play Integrity Fixer"

API_URL="${KEYBOX_BASE_URL:-https://keybox.codewithvignesh.live/index.php}"

TMP=/data/local/tmp/integrityfixer
mkdir -p "$TMP"

CURRENT_KEYBOX="/data/adb/tricky_store/keybox.xml"

# Calculate local SHA256
LOCAL_HASH=""
if [ -s "$CURRENT_KEYBOX" ]; then
    LOCAL_HASH=$(sha256sum "$CURRENT_KEYBOX" | awk '{print $1}')
fi

# Fetch API response
if ! curl -fsSL "$API_URL" -o "$TMP/response.json"; then
    exit 1
fi

# Extract remote SHA256
REMOTE_HASH=$(grep -o '"sha256"[[:space:]]*:[[:space:]]*"[^"]*"' "$TMP/response.json" \
    | cut -d'"' -f4)

# Extract remote version
REMOTE_VERSION=$(grep -o '"version"[[:space:]]*:[[:space:]]*[0-9]\+' "$TMP/response.json" \
    | grep -o '[0-9]\+')

# Validate required fields
[ -n "$REMOTE_HASH" ] || exit 1
[ -n "$REMOTE_VERSION" ] || exit 1

# Compare hashes
if [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then

    # Extract download URL (optional, useful later)
    DOWNLOAD_URL=$(grep -o '"download_url"[[:space:]]*:[[:space:]]*"[^"]*"' "$TMP/response.json" \
        | cut -d'"' -f4)
    
    sh "$MODDIR/scripts/notifier.sh" \
        "$TITLE" \
        "New keybox update available (v$REMOTE_VERSION). Open Magisk and tap Action."

fi

exit 0