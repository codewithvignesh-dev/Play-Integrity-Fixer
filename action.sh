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

sh "$MODDIR/autopif4.sh" -m || exit 1
sh "$MODDIR/scripts/updater.sh" --check

if [ -n "$DOWNLOAD_URL" ]; then
    echo "Updating process is going on background"
    sh "$MODDIR/scripts/notifier.sh" \
        "Play Integrity Fixer" \
        "Refreshing the device keybox..."
    if curl -fsSL "$DOWNLOAD_URL" -o "$KEYBOX_PATH"; then
        sh "$MODDIR/scripts/notifier.sh" \
            "Play Integrity Fixer" \
            "Update Completed. Strong Integrity has been restored successfully."
    else
        sh "$MODDIR/scripts/notifier.sh" \
            "Play Integrity Fixer" \
            "Failed to restore the Strong Integrity."
    fi
fi

exit 0