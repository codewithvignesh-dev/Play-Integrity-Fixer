#!/system/bin/sh

SKIPMOUNT=false
POSTFSDATA=true
LATESTARTSERVICE=true
SKIPUNZIP=1

ui_print "- Installing module..."

unzip -o "$ZIPFILE" 'scripts/*' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'config/*' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'action.sh' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'service.sh' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'post-fs-data.sh' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'uninstall.sh' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'autopif4.sh' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'killpi.sh' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'migrate.sh' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'module.prop' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'example.pif.prop' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'app/*' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'data/*' -d "$MODPATH" >&2

mkdir -p /data/local/tmp/integrityfixer

chmod -R 755 "$MODPATH/scripts"
chmod 755 "$MODPATH/action.sh"
chmod 755 "$MODPATH/service.sh"
chmod 755 "$MODPATH/post-fs-data.sh"
chmod 755 "$MODPATH/uninstall.sh"
chmod 755 "$MODPATH/autopif4.sh"
chmod 755 "$MODPATH/killpi.sh"
chmod 755 "$MODPATH/migrate.sh"

ui_print "- Installing Integrity Fixer Notifier..."

pm install -r "$MODPATH/app/Play-Integrity-Fixer.apk" >/dev/null 2>&1

if [ $? -eq 0 ]; then
  ui_print "- Notifier installed."
else
  ui_print "! Failed to install notifier."
fi

ui_print "- Installation completed."


set_perm_recursive "$MODPATH" 0 0 0755 0644

set_perm "$MODPATH/action.sh" 0 0 0755
set_perm "$MODPATH/service.sh" 0 0 0755
set_perm "$MODPATH/post-fs-data.sh" 0 0 0755
set_perm "$MODPATH/uninstall.sh" 0 0 0755
set_perm "$MODPATH/autopif4.sh" 0 0 0755
set_perm "$MODPATH/killpi.sh" 0 0 0755
set_perm "$MODPATH/migrate.sh" 0 0 0755

set_perm_recursive "$MODPATH/scripts" 0 0 0755 0755

