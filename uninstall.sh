#!/system/bin/sh

echo "Removing Play Integrity Fixer..."

rm -rf /data/local/tmp/integrityfixer

rm -f /data/adb/modules/integrityfixer/config/last_check
rm -f /data/adb/modules/integrityfixer/config/version

echo "Uninstall completed."

exit 0