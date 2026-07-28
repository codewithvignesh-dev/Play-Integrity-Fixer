#!/bin/sh

N="
";

case "$1" in
  -h|--help|help) echo "sh migrate.sh [-f] [-o] [-a] [-p|-j] [in-file] [out-file]"; exit 0;;
  -i|--install|install) INSTALL=1; shift;;
  *) echo "custom.pif.prop/.json migration script \
    $N  by osm0sis @ xda-developers $N";;
esac;

die() { [ "$INSTALL" ] || echo "$N$N! $@"; exit 1; }

until [ -z "$1" -o -f "$1" ]; do
  case "$1" in
    -f|--force|force) FORCE=1; shift;;
    -o|--override|override) OVERRIDE=1; shift;;
    -a|--advanced|advanced) ADVANCED=1; shift;;
    -j|--json|json) FORMAT=json; FORCE=1; shift;;
    -p|--prop|prop) FORMAT=prop; FORCE=1; shift;;
    *) die "Invalid argument/file not found: $1";;
  esac;
done;

grep_get_prop() {
  grep -m1 "$1=" "$2" | cut -d= -f2 | cut -d\# -f1 | sed 's/[[:space:]]*$//';
}
grep_check_prop() {
  grep -q "$1" "$2" && [ "$(grep_get_prop "$1" "$2")" ];
}
grep_get_json() {
  eval set -- "$(cat "$2" | tr -d '\r\n' | grep -m1 -o "$1"'".*' | cut -d: -f2- | sed 's|//|#|g')";
  echo "$1" | sed -e 's|"|\\\\\\"|g' -e 's|[,}]*$||';
}
grep_check_json() {
  grep -q "$1" "$2" && [ "$(grep_get_json "$1" "$2")" ];
}
grep_get_config() {
  local target="$FILE";
  [ -n "$2" ] && target="$2";
  case $target in
    *.json) grep_get_json "$1" "$target";;
    *.prop) grep_get_prop "$1" "$target";;
  esac;
}
grep_check_config() {
  local target="$FILE";
  [ -n "$2" ] && target="$2";
  case $target in
    *.json) grep_check_json "$1" "$target";;
    *.prop) grep_check_prop "$1" "$target";;
  esac;
}

if [ -f "$1" ]; then
  FILE="$1";
  DIR="$1";
else
  case "$0" in
    *.sh) DIR="$0";;
    *) DIR="$(lsof -p $$ 2>/dev/null | grep -o '/.*migrate.sh$')";;
  esac;
fi;
DIR=$(dirname "$(readlink -f "$DIR")");

if [ -z "$FILE" ]; then
  for EXT in json prop; do
    [ -f "$DIR/custom.pif.$EXT" ] && FILE="$DIR/custom.pif.$EXT";
  done;
fi;
[ -f "$FILE" ] || die "No config file found";

if [ -z "$FORMAT" ]; then
  case "$FILE" in
    *.json) FORMAT=json;;
    *.prop) FORMAT=prop;;
  esac;
fi;

OUT="$2";
[ -z "$OUT" ] && OUT="$DIR/custom.pif.$FORMAT";

grep_check_config api_level && [ ! "$FORCE" ] && die "No migration required";

[ "$INSTALL" ] || uiprint "Parsing fields ..."

FPFIELDS="BRAND PRODUCT DEVICE RELEASE ID INCREMENTAL TYPE TAGS";
ALLFIELDS="MANUFACTURER MODEL FINGERPRINT $FPFIELDS SECURITY_PATCH DEVICE_INITIAL_SDK_INT";

for FIELD in $ALLFIELDS; do
  eval $FIELD=\"$(grep_get_config $FIELD)\";
done;

if [ -n "$ID" ] && ! grep_check_config build.id; then
  uiprint "▸ Mapping ID to build property schema..."
fi;

if [ -z "$ID" ] && grep_check_config BUILD_ID; then
  uiprint "▸ Upgrading deprecated BUILD_ID mapping..."
  ID="$(grep_get_config BUILD_ID)";
fi;

if [ -n "$SECURITY_PATCH" ] && ! grep_check_config security_patch; then
  uiprint "▸ Mapping security patch metadata..."
fi;

if grep_check_config VNDK_VERSION; then
  uiprint "▸ Migrating VNDK version metadata..."
  VNDK_VERSION="$(grep_get_config VNDK_VERSION)";
fi;

if [ -n "$DEVICE_INITIAL_SDK_INT" ] && ! grep_check_config api_level; then
  uiprint "▸ Mapping initial API level metadata..."
fi;

if [ -z "$DEVICE_INITIAL_SDK_INT" ] && grep_check_config FIRST_API_LEVEL; then
  uiprint "▸ Migrating legacy API level metadata..."
  DEVICE_INITIAL_SDK_INT="$(grep_get_config FIRST_API_LEVEL)";
fi;

if [ -z "$RELEASE" -o -z "$INCREMENTAL" -o -z "$TYPE" -o -z "$TAGS" -o "$OVERRIDE" ]; then
  if [ "$OVERRIDE" ]; then
    uiprint "▸ Refreshing fingerprint-derived metadata..."
  else
    uiprint "▸ Resolving missing metadata from fingerprint..."
  fi;
  IFS='/:' read F1 F2 F3 F4 F5 F6 F7 F8 <<EOF
$(grep_get_config FINGERPRINT)
EOF
  i=1;
  for FIELD in $FPFIELDS; do
    eval [ -z \"\$$FIELD\" -o \"$OVERRIDE\" ] \&\& $FIELD=\"\$F$i\";
    i=$((i+1));
  done;
fi;

if [ -z "$SECURITY_PATCH" -o "$SECURITY_PATCH" = "null" ]; then
  uiprint "▸ Security patch unavailable; leaving value unset..."
  unset SECURITY_PATCH;
fi;

if [ -z "$DEVICE_INITIAL_SDK_INT" -o "$DEVICE_INITIAL_SDK_INT" = "null" ]; then
  uiprint "▸ API level unavailable; applying default profile..."
  DEVICE_INITIAL_SDK_INT=25;
fi;

ADVSETTINGS="spoofBuild spoofProps spoofProvider spoofSignature spoofVendingFinger spoofVendingSdk verboseLogs";

spoofBuild=1;
spoofProps=1;
spoofProvider=1;
spoofSignature=0;
spoofVendingFinger=0;
spoofVendingSdk=0;
verboseLogs=0;

keep_advanced() {
  if grep -qE "verboseLogs|VERBOSE_LOGS" "$1"; then
    uiprint "▸ Preserving existing profile settings..."
    ADVANCED=1;
    grep_check_config VERBOSE_LOGS "$1" && verboseLogs="$(grep_get_config VERBOSE_LOGS "$1")";
    for SETTING in $ADVSETTINGS; do
      eval grep_check_config $SETTING \"$1\" \&\& $SETTING=\"$(grep_get_config $SETTING "$1")\";
    done;
    if grep -qE '#\*.security_patch|//"\*.security_patch"' "$1"; then
      case $FORMAT in
        json) SECURITY_COMMENT='//';;
        prop) SECURITY_COMMENT='#';;
      esac;
    fi;
  fi;
}
if [ -f "$OUT" ]; then
  keep_advanced "$OUT";
  uiprint "▸ Backing up previous profile configuration..."
  mv -f "$OUT" "$OUT.bak";
else
  case "$FILE" in
    *.$FORMAT) ;;
    *) keep_advanced "$FILE";;
  esac;
fi;

[ "$INSTALL" ] || uiprint "▸ Writing updated custom PIF profile..."
[ "$ADVANCED" ] && uiprint "▸ Applying advanced profile settings..."

case $FORMAT in
  json) CMNT='  //'; EVALPRE='\ \ \ \ \"'; SECPRE1='    '; SECPRE2='"'; PRE='    "'; MID='": "'; POST='",';;
  prop) CMNT='#'; MID='=';;
esac;
([ "$FORMAT" = "json" ] && echo '{';
echo "$CMNT Profile Identity";
for FIELD in $ALLFIELDS; do
  eval echo "$EVALPRE$FIELD\$MID\$$FIELD\$POST";
done;
echo "$N$CMNT Runtime Properties";
echo "$PRE"'*.build.id'"$MID$ID$POST";
echo "$SECPRE1$SECURITY_COMMENT$SECPRE2"'*.security_patch'"$MID$SECURITY_PATCH$POST";
[ -z "$VNDK_VERSION" ] || echo "$PRE"'*.vndk.version'"$MID$VNDK_VERSION$POST";
echo "$PRE"'*api_level'"$MID$DEVICE_INITIAL_SDK_INT$POST";
if [ "$ADVANCED" ]; then
  echo "$N$CMNT Advanced Configuration";
  for SETTING in $ADVSETTINGS; do
    eval echo "$EVALPRE$SETTING\$MID\$$SETTING\$POST";
  done;
fi) | sed '$s/,/\n}/' > "$OUT";

# [ "$INSTALL" ] || cat "$OUT";
uiprint "▸ Profile generation completed successfully."