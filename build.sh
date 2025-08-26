#!/bin/bash

# Build script for CleanKeyboard
# Usage: ./build.sh

set -e

echo "🔨 Building CleanKeyboard..."

# Clean previous builds
rm -rf build/
rm -rf CleanKeyboard.dmg

# Create app bundle structure
mkdir -p build/CleanKeyboard.app/Contents/MacOS
mkdir -p build/CleanKeyboard.app/Contents/Resources

# Copy Info.plist and icon
cp Info.plist build/CleanKeyboard.app/Contents/
cp CleanKeyboard.icns build/CleanKeyboard.app/Contents/Resources/

# Compile directly with clang
clang -framework Cocoa -framework ApplicationServices -framework Carbon \
      -fobjc-arc \
      -mmacosx-version-min=10.15 \
      -o build/CleanKeyboard.app/Contents/MacOS/CleanKeyboard \
      main.m AppDelegate.m KeyboardBlocker.m

echo "✅ Compilation completed"

# Create DMG
echo "📦 Creating DMG..."

# Create temporary folder for DMG contents
mkdir -p build/dmg
cp -R build/CleanKeyboard.app build/dmg/

# Create link to Applications folder
ln -s /Applications build/dmg/Applications

# Create DMG
hdiutil create -volname "CleanKeyboard" \
               -srcfolder build/dmg \
               -ov \
               -format UDZO \
               CleanKeyboard.dmg

echo "✅ DMG created: CleanKeyboard.dmg"

# Clean up
rm -rf build/dmg

echo "🎉 Build complete! You can install the app using CleanKeyboard.dmg"
