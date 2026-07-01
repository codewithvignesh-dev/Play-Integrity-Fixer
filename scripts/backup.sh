#!/system/bin/sh

MODDIR=/data/adb/modules/integrityfixer

. "$MODDIR/config/settings.conf"

BACKUP_DIR="$MODDIR/backup"

mkdir -p "$BACKUP_DIR"

if [ -f "$FILE_PATH/$FILE_NAME" ]; then
    cp -f "$FILE_PATH/$FILE_NAME" \
          "$BACKUP_DIR/$FILE_NAME.bak"

    echo "Backup created."
else
    echo "No existing file to backup."
fi

exit 0