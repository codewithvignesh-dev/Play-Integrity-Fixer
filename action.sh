#!/system/bin/sh

MODDIR=${0%/*}

. "$MODDIR/config/settings.conf"

TMP="/data/local/tmp/integrityfixer"
mkdir -p "$TMP"

echo "=================================="
echo "      Play Integrity Fixer"
echo "=================================="
echo

sh "$MODDIR/scripts/updater.sh" --check

exit 0