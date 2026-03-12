#!/bin/bash

# Directory setup
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
RES_DIR="$SRC_DIR/res"

# Ensure directories exist
mkdir -p "$RES_DIR"

# Arguments
INPUT_APP="$1"

if [ -z "$INPUT_APP" ]; then
    echo "Usage: $0 <App Name or Path>"
    echo "Example: $0 \"Visual Studio Code\""
    exit 1
fi

# Determine APP_PATH
# Logic:
# 1. If it starts with / or ~, assume path.
# 2. If it's just a name, try /Applications
# 3. If not found, try ~/Applications

# Expand tilde if present
if [[ "$INPUT_APP" == ~* ]]; then
    INPUT_APP="${INPUT_APP/#\~/$HOME}"
fi

if [[ "$INPUT_APP" == /* ]]; then
    APP_PATH="$INPUT_APP"
    [[ "$APP_PATH" != *.app ]] && APP_PATH="${APP_PATH}.app"
else
    # Try /Applications first
    APP_PATH="/Applications/${INPUT_APP}.app"
    if [ ! -d "$APP_PATH" ]; then
        # Try ~/Applications
        APP_PATH="$HOME/Applications/${INPUT_APP}.app"
    fi
fi

if [ ! -d "$APP_PATH" ]; then
    echo "Error: Application '$APP_PATH' not found."
    # Help debug where we looked if it was a name search
    if [[ "$INPUT_APP" != /* ]]; then
         echo "Checked: /Applications/${INPUT_APP}.app"
         echo "Checked: $HOME/Applications/${INPUT_APP}.app"
    fi
    exit 1
fi

# Helper function to normalize filename (lowercase, spaces to dashes)
normalize_name() {
    local name="$1"
    # Convert to lowercase
    local lower=$(echo "$name" | tr '[:upper:]' '[:lower:]')
    # Replace spaces with dashes
    echo "${lower// /-}"
}

# Try to extract the main icon from Info.plist first
if [ -f "$APP_PATH/Contents/Info.plist" ]; then
    # Use PlistBuddy to get the icon filename
    PLIST_ICON_NAME=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIconFile" "$APP_PATH/Contents/Info.plist" 2>/dev/null)
    
    if [ -n "$PLIST_ICON_NAME" ]; then
        # Ensure .icns extension
        [[ "$PLIST_ICON_NAME" != *.icns ]] && PLIST_ICON_NAME="${PLIST_ICON_NAME}.icns"
        
        SOURCE_ICON_PATH="$APP_PATH/Contents/Resources/$PLIST_ICON_NAME"
        
        if [ -f "$SOURCE_ICON_PATH" ]; then
            APP_BASENAME=$(basename "$APP_PATH" .app)
            NORMALIZED_NAME=$(normalize_name "$APP_BASENAME")
            DEST_FILENAME="${NORMALIZED_NAME}.icns"
            
            cp "$SOURCE_ICON_PATH" "$RES_DIR/$DEST_FILENAME"
            echo "Copied main icon: $DEST_FILENAME -> $RES_DIR/"
            exit 0
        fi
    fi
fi

# Fallback: Copy all icons if main one fails
echo "Warning: CFBundleIconFile not found or file missing. Copying all .icns files..."
RESOURCE_DIR="$APP_PATH/Contents/Resources"
shopt -s nullglob
ICONS=("$RESOURCE_DIR"/*.icns)
shopt -u nullglob

if [ ${#ICONS[@]} -eq 0 ]; then
    echo "Error: No .icns files found in $RESOURCE_DIR"
    exit 1
fi

for icon in "${ICONS[@]}"; do
    filename=$(basename "$icon")
    normalized=$(normalize_name "${filename%.icns}")
    cp "$icon" "$RES_DIR/${normalized}.icns"
    echo "Copied: ${normalized}.icns -> $RES_DIR/"
done
