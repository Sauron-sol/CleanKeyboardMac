#!/bin/bash

# Enhanced installation script for CleanKeyboard DMG
# This script helps users install CleanKeyboard and handle macOS security restrictions

set -e

echo "🚀 CleanKeyboard Installation Helper"
echo "===================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "❌ Please don't run this script as root (without sudo)"
    echo "   Run it as your normal user - it will ask for password when needed"
    exit 1
fi

# Check if CleanKeyboard.app exists in Applications
if [ ! -d "/Applications/CleanKeyboard.app" ]; then
    echo "❌ CleanKeyboard.app not found in /Applications"
    echo ""
    echo "Please install CleanKeyboard first:"
    echo "1. Download CleanKeyboard.dmg from GitHub releases"
    echo "2. Open the DMG file"
    echo "3. Drag CleanKeyboard.app to Applications folder"
    echo "4. Then run this script again"
    exit 1
fi

echo "✅ Found CleanKeyboard.app in /Applications"
echo ""

# Remove quarantine attributes
echo "🔧 Removing macOS quarantine restrictions..."
if sudo xattr -rd com.apple.quarantine /Applications/CleanKeyboard.app 2>/dev/null; then
    echo "✅ Quarantine attributes removed successfully"
else
    echo "⚠️  Could not remove quarantine (app might already be clean)"
fi

# Make sure it's executable
echo "🔧 Setting executable permissions..."
sudo chmod +x /Applications/CleanKeyboard.app/Contents/MacOS/CleanKeyboard

echo ""
echo "🎉 Installation completed!"
echo ""
echo "Next steps:"
echo "1. Launch CleanKeyboard from Applications folder"
echo "2. When prompted, grant Accessibility permissions:"
echo "   • System Preferences → Security & Privacy → Privacy → Accessibility"
echo "   • Click the lock 🔒 to make changes"
echo "   • Add CleanKeyboard to the allowed list"
echo ""
echo "🧹 You're ready to safely clean your keyboard!"
