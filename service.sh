#!/system/bin/sh

MODDIR=${0%/*}

. "$MODDIR/config/settings.conf"

sleep 120

while true; do
    am broadcast \
        -a com.integrity.fixer.SHOW_NOTIFICATION \
        -n com.integrity.fixer/.NotifyReceiver \
        >/dev/null 2>&1
    
    sh "$MODDIR/scripts/updater.sh" --check
    
    sleep "$CHECK_INTERVAL"
done
exit 0