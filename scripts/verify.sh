#!/system/bin/sh

FILE="$1"
EXPECTED="$2"

if [ ! -f "$FILE" ]; then
    echo "File not found."
    exit 1
fi

ACTUAL=$(sha256sum "$FILE" | awk '{print $1}')

if [ "$ACTUAL" = "$EXPECTED" ]; then
    echo "Verification successful."
    exit 0
else
    echo "SHA-256 verification failed."
    exit 1
fi