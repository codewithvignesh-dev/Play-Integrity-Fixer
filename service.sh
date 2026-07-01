#!/system/bin/sh

MODDIR=${0%/*}

. "$MODDIR/config/settings.conf"

sleep 120

while true; do
    sh "$MODDIR/scripts/updater.sh" --check
    
    sleep "$CHECK_INTERVAL"
done
exit 0