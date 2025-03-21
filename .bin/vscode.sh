#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")/vscode" && pwd)"
VSCODE_SETTING_PATH="${HOME}/Library/Application\ Support/Code/User/settings.json"

# Link settings.json to vscode
if not [ -L "${VSCODE_SETTING_PATH}" ]; then
    echo "Linking settings.json to vscode..."
    rm "${VSCODE_SETTING_PATH}"
    ln -fsvn "${SCRIPT_DIR}/settings.json" "${VSCODE_SETTING_PATH}"
else
    echo "VSCode settings.json is not found."
fi
