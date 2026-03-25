#!/bin/sh

# This script finds AndroidIDE's bundled Gradle and uses it.
# Do NOT run 'gradle' directly from terminal - use this script or the Play button.

APP_HOME="$(cd "$(dirname "$0")" && pwd)"

# AndroidIDE stores Gradle in these locations (tries each one)
for GRADLE_BIN in \
  "$HOME/.androidide/gradle/bin/gradle" \
  "/data/data/com.itsaky.androidide/files/home/.androidide/gradle/bin/gradle" \
  "/data/user/0/com.itsaky.androidide/files/home/.androidide/gradle/bin/gradle" \
  "/data/data/com.itsaky.androidide/files/gradle/bin/gradle"
do
  if [ -x "$GRADLE_BIN" ]; then
    echo "Found AndroidIDE Gradle: $GRADLE_BIN"
    exec "$GRADLE_BIN" "$@"
  fi
done

# Fallback: try system gradle
if command -v gradle >/dev/null 2>&1; then
  GRADLE_VER=$(gradle --version 2>/dev/null | grep "Gradle " | head -1)
  echo "Warning: Using system Gradle: $GRADLE_VER"
  exec gradle "$@"
fi

echo ""
echo "ERROR: Could not find AndroidIDE's Gradle."
echo "Please open this project using the AndroidIDE Play button, not the terminal."
echo ""
echo "Or run this in terminal to find Gradle:"
echo "  find /data/data/com.itsaky.androidide -name 'gradle' -type f 2>/dev/null"
exit 1
