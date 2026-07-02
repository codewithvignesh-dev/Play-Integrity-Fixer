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
REMOTE_VERSION=$(grep '"version"' "$TMP/response.json" |
    cut -d':' -f2 |
    tr -d ' ,'
)

# Validate required fields
[ -n "$REMOTE_HASH" ] || exit 1
[ -n "$REMOTE_VERSION" ] || exit 1

# Compare hashes
if [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then

    if [ "$LAST_NOTIFIED_VERSION" != "$REMOTE_VERSION" ]; then

        sh "$MODDIR/scripts/notifier.sh" \
            "$TITLE" \
            "New keybox update available (v$REMOTE_VERSION). Open Magisk and tap Action."

        sed -i \
            "s/^LAST_NOTIFIED_VERSION=.*/LAST_NOTIFIED_VERSION=$REMOTE_VERSION/" \
            "$MODDIR/config/settings.conf"
    fi
fi
exit 0