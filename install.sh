#!/bin/bash

# Installation script for CleanKeyboard
# Usage: ./install.sh

set -e

echo "🚀 Installing CleanKeyboard..."

# Check if app exists
if [ ! -d "build/CleanKeyboard.app" ]; then
    echo "❌ Application not built. Please run ./build.sh first"
    exit 1
fi

# Copy to Applications folder
if [ -d "/Applications/CleanKeyboard.app" ]; then
    echo "🗑️  Removing previous version..."
    rm -rf "/Applications/CleanKeyboard.app"
fi

echo "📁 Copying to /Applications..."
cp -R "build/CleanKeyboard.app" "/Applications/"

echo "✅ CleanKeyboard installed successfully!"
echo "📱 You can now launch the application from Launchpad or Applications folder."
echo ""
echo "⚠️  Don't forget to grant accessibility permissions in:"
echo "   System Preferences > Security & Privacy > Privacy > Accessibility"
