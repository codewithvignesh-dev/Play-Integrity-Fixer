#!/system/bin/sh

MODDIR=${0%/*}

. "$MODDIR/config/settings.conf"

TMP="/data/local/tmp/integrityfixer"
KEYBOX_PATH="/data/adb/tricky_store/keybox.xml"
mkdir -p "$TMP"

echo "=================================="
echo "      Play Integrity Fixer"
echo "=================================="
echo

sh "$MODDIR/scripts/updater.sh" --check

if [ -n "$DOWNLOAD_URL" ]; then
    echo "Updating process is going on background"
    sh "$MODDIR/scripts/notifier.sh" \
        "Play Integrity Fixer" \
        "Updating the latest keybox from Magisk."
    curl -fsSL "$DOWNLOAD_URL" -o "$KEYBOX_PATH"
fi

exit 0