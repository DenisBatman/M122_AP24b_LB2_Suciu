#!/bin/bash
# ======================================
# Config Loader Script (Bash version)
# ======================================
# Loads config from:
# 1. .env file (simple key=value format)
# 2. config.json file (parsed using jq)
# Includes simple error handling

echo "=== STARTING CONFIG LOADER ==="

# Function that runs if any command fails
handle_error() {
    echo "ERROR: Something went wrong. Exiting script."
    exit 1
}

# Use trap to catch errors like try/catch
trap 'handle_error' ERR

# === Method 1: Load from .env file ===
echo ""
echo "1. Loading config from .env file..."

if [ -f ".env" ]; then
    source .env
    echo "Loaded from .env:"
    echo "HOST = $HOST"
    echo "PORT = $PORT"
    echo "USERNAME = $USERNAME"
else
    echo "ERROR: Env file not found. Skipping this part."
fi

# Extra step (not needed, but okay for beginners)
HOST_COPY=$HOST

# === Method 2: Load from config.json ===
echo ""
echo "2. Loading config from config.json..."

# Check if jq is installed
if ! command -v jq >/dev/null 2>&1; then
    echo "ERROR: 'jq' is not installed. Please run: sudo apt install jq"
    exit 1
fi

if [ -f "config.json" ]; then
    URL=$(jq -r '.url' config.json)
    TIMEOUT=$(jq -r '.timeout' config.json)
    TOKEN=$(jq -r '.token' config.json)

    echo "Loaded from config.json:"
    echo "URL = $URL"
    echo "Timeout = $TIMEOUT"
    echo "Token = $TOKEN"

    echo "Connecting to $URL with token $TOKEN..."
else
    echo "ERROR: config.json file not found. Skipping loading"
fi

echo ""
echo "=== CONFIG LOADER FINISHED ==="
