
#!/system/bin/sh

MODDIR=${0%/*}

. "$MODDIR/config/settings.conf"

TMP="/data/local/tmp/integrityfixer"
KEYBOX_PATH="/data/adb/tricky_store/keybox.xml"

USER_AGENT="PlayIntegrityFixer/1.0 (Android; Magisk)"

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

    if curl -fsSL \
        --connect-timeout 10 \
        --max-time 60 \
        --retry 3 \
        --user-agent "$USER_AGENT" \
        "$DOWNLOAD_URL" \
        -o "$KEYBOX_PATH"; then

        sh "$MODDIR/scripts/notifier.sh" \
            "Play Integrity Fixer" \
            "Update Completed. Keybox downloaded successfully."
    else
        sh "$MODDIR/scripts/notifier.sh" \
            "Play Integrity Fixer" \
            "Failed to download the keybox."
    fi
fi

exit 0
