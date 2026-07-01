#!/system/bin/sh

#!/system/bin/sh

TITLE="$1"
MESSAGE="$2"

[ -z "$TITLE" ] && TITLE="Integrity Fixer"
[ -z "$MESSAGE" ] && MESSAGE="Notification"

am broadcast \
    -a com.integrity.fixer.SHOW_NOTIFICATION \
    -n com.integrity.fixer/.NotifyReceiver \
    --es title "$TITLE" \
    --es message "$MESSAGE" >/dev/null 2>&1