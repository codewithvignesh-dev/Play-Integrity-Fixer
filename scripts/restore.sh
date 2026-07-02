#!/system/bin/sh

MODDIR=/data/adb/modules/integrityfixer

. "$MODDIR/config/settings.conf"

BACKUP_DIR="$MODDIR/backup"

if [ -f "$BACKUP_DIR/$FILE_NAME.bak" ]; then

    cp -f \
        "$BACKUP_DIR/$FILE_NAME.bak" \
        "$FILE_PATH/$FILE_NAME"

    chmod 644 "$FILE_PATH/$FILE_NAME"
    chown 0:0 "$FILE_PATH/$FILE_NAME"

    echo "file restored."

else

    echo "Backup not found."

fi

exit 0