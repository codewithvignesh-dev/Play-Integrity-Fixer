#!/system/bin/sh

if [ "$USER" != "root" -a "$(whoami 2>/dev/null)" != "root" ]; then
  echo "killpi: need root permissions";
  exit 1;
fi;

killall com.google.android.gms.unstable;
killall com.android.vending;
