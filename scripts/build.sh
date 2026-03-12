#!/bin/bash

# Directory setup
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
DIST_DIR="$SRC_DIR/dist"
BUILD_DIR="$SRC_DIR/build"
RES_DIR="$SRC_DIR/res"

# Ensure directories exist
mkdir -p "$DIST_DIR"
mkdir -p "$BUILD_DIR"

# Arguments
INPUT_APP="$1"
# Determine APP_PATH and Clean Name
if [[ "$INPUT_APP" == /* ]]; then
    APP_PATH="$INPUT_APP"
else
    APP_PATH="/Applications/${INPUT_APP}.app"
fi

APP_NAME_CLEAN=$(basename "$APP_PATH" .app)
DROPLET_NAME="${2:-Open in $APP_NAME_CLEAN}"
STRATEGY="${3:-default}"

if [ -z "$INPUT_APP" ]; then
    echo "Usage: $0 <App Name or Path> [Droplet Name] [Strategy]"
    echo "Strategies: default | file-only | folder-only | file-parent"
    exit 1
fi

# Resolve template from strategy
if [ -f "$SRC_DIR/src/template-${STRATEGY}.applescript" ]; then
    TEMPLATE_FILE="$SRC_DIR/src/template-${STRATEGY}.applescript"
else
    echo "Error: Unknown strategy '$STRATEGY'. Use: default | file-only | folder-only | file-parent"
    exit 1
fi

# Icon: res/<name>.icns (try droplet name, then "Open in " stripped, then app name)
BASE_ICON_NAME=$(echo "$DROPLET_NAME" | sed -E 's/^Open in //')
RES_ICON="$RES_DIR/${DROPLET_NAME}.icns"
SMART_ICON="$RES_DIR/${BASE_ICON_NAME}.icns"
FALLBACK_ICON="$RES_DIR/${APP_NAME_CLEAN}.icns"

LC_ICON="$RES_DIR/$(echo "$BASE_ICON_NAME" | tr '[:upper:]' '[:lower:]').icns"
if [ -f "$RES_ICON" ]; then
    ICON_PATH="$RES_ICON"
elif [ -f "$SMART_ICON" ]; then
    ICON_PATH="$SMART_ICON"
elif [ -f "$FALLBACK_ICON" ]; then
    ICON_PATH="$FALLBACK_ICON"
elif [ -f "$LC_ICON" ]; then
    ICON_PATH="$LC_ICON"
else
    echo "Error: Icon not found in res/ (tried ${DROPLET_NAME}.icns, ${BASE_ICON_NAME}.icns, ${APP_NAME_CLEAN}.icns, $(basename "$LC_ICON"))"
    exit 1
fi

# Build Droplet
OUTPUT_APP="$DIST_DIR/${DROPLET_NAME}.app"
TEMP_SCRIPT="$BUILD_DIR/${DROPLET_NAME}.applescript"

# Replace placeholders
sed "s/{{APP_NAME}}/${APP_NAME_CLEAN}/g" "$TEMPLATE_FILE" > "$TEMP_SCRIPT"

# Compile
osacompile -o "$OUTPUT_APP" "$TEMP_SCRIPT"

# Set Icon
if [ -n "$ICON_PATH" ] && [ -f "$ICON_PATH" ]; then
    # Remove Assets.car - it contains the default icon and takes precedence over .icns
    rm -f "$OUTPUT_APP/Contents/Resources/Assets.car"
    
    # Copy icon to droplet.icns
    cp "$ICON_PATH" "$OUTPUT_APP/Contents/Resources/droplet.icns"
fi

echo "Built: $OUTPUT_APP"
