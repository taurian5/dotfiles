#!/usr/bin/env bash
# Check Claude settings sync status
# Compares global settings with repo's local settings

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_SETTINGS="$HOME/.claude/settings.json"
REPO_SETTINGS="$SCRIPT_DIR/settings.local.json"

echo -e "\033[36mClaude Settings Checker\033[0m"
echo -e "\033[36m======================\033[0m"
echo ""

# Check if files exist
if [[ ! -f "$GLOBAL_SETTINGS" ]]; then
    echo -e "\033[31m❌ Global settings not found at: $GLOBAL_SETTINGS\033[0m"
    exit 1
fi

if [[ ! -f "$REPO_SETTINGS" ]]; then
    echo -e "\033[31m❌ Repo settings not found at: $REPO_SETTINGS\033[0m"
    exit 1
fi

echo -e "\033[90m📂 Global: $GLOBAL_SETTINGS\033[0m"
echo -e "\033[90m📂 Repo:   $REPO_SETTINGS\033[0m"
echo ""

# Compare using jq if available, otherwise use diff
if command -v jq &> /dev/null; then
    # Normalize JSON and compare
    GLOBAL_NORMALIZED=$(jq --sort-keys . "$GLOBAL_SETTINGS")
    REPO_NORMALIZED=$(jq --sort-keys . "$REPO_SETTINGS")

    if [[ "$GLOBAL_NORMALIZED" == "$REPO_NORMALIZED" ]]; then
        echo -e "\033[32m✅ Settings are in sync!\033[0m"
        exit 0
    else
        echo -e "\033[33m⚠️  Settings are OUT OF SYNC\033[0m"
        echo ""
        echo -e "\033[36mRun this command to sync:\033[0m"
        echo -e "  cp '$REPO_SETTINGS' '$GLOBAL_SETTINGS'"
        exit 1
    fi
else
    # Fallback to simple diff
    if diff -q "$GLOBAL_SETTINGS" "$REPO_SETTINGS" &> /dev/null; then
        echo -e "\033[32m✅ Settings are in sync!\033[0m"
        exit 0
    else
        echo -e "\033[33m⚠️  Settings are OUT OF SYNC\033[0m"
        echo ""
        echo -e "\033[36mRun this command to sync:\033[0m"
        echo -e "  cp '$REPO_SETTINGS' '$GLOBAL_SETTINGS'"
        exit 1
    fi
fi
