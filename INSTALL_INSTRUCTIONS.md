# Installation Instructions for CleanKeyboard

## Download and Installation

### Step 1: Download
1. Go to [Releases](https://github.com/Sauron-sol/CleanKeyboardMac/releases)
2. Download `CleanKeyboard.dmg`

### Step 2: Handle macOS Security Warning

When you try to open the downloaded app, macOS will show a warning saying the app is "damaged" or "from an unidentified developer". This is normal for unsigned apps.

#### Option A: Remove Quarantine (Recommended)
1. Open Terminal
2. Navigate to where you downloaded/installed CleanKeyboard
3. Run this command:
   ```bash
   sudo xattr -rd com.apple.quarantine /Applications/CleanKeyboard.app
   ```
4. Enter your password when prompted
5. The app should now open normally

#### Option B: Override Security Settings
1. Try to open CleanKeyboard - you'll get a security warning
2. Go to **System Preferences** → **Security & Privacy** → **General**
3. You should see a message about CleanKeyboard being blocked
4. Click **"Open Anyway"**
5. Confirm in the next dialog

### Step 3: Grant Accessibility Permissions

After the app opens successfully:

1. Click **"🔓 Start Cleaning"** - you'll get a permission dialog
2. Click **"Open System Preferences"**
3. In **Security & Privacy** → **Privacy** → **Accessibility**:
   - Click the lock 🔒 to make changes
   - Click the **"+"** button
   - Navigate to `/Applications/CleanKeyboard.app`
   - Add it to the list
   - Make sure it's checked ✅

### Step 4: Test the App

1. Return to CleanKeyboard
2. Click **"🔓 Start Cleaning"** again
3. Your keyboard should now be blocked!
4. Click **"🔒 Stop Cleaning"** to unlock

## Troubleshooting

### "App is damaged and can't be opened"
- Use the `xattr` command from Step 2, Option A above

### "CleanKeyboard doesn't appear in Accessibility settings"
- Make sure you used Option A or B above first
- The app must be "trusted" by macOS before it appears in accessibility settings

### "Permission denied" when running xattr command
- Make sure to use `sudo` before the command
- Enter your admin password when prompted

## Why This Happens

CleanKeyboard is not code-signed with an Apple Developer Certificate, so macOS treats it as potentially unsafe. This is normal for open-source apps. The quarantine removal is safe - you can verify the code is clean by reviewing the source code on GitHub.

## Alternative: Build from Source

If you prefer to build from source instead:

```bash
git clone https://github.com/Sauron-sol/CleanKeyboardMac.git
cd CleanKeyboardMac
./build.sh
./install.sh
```

Apps built locally don't have quarantine issues.
