# Contributing to CleanKeyboard

Thank you for your interest in contributing to CleanKeyboard! This document provides guidelines and information for contributors.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## How to Contribute

### Reporting Bugs

1. **Check existing issues** to see if the bug has already been reported
2. **Use the bug report template** when creating a new issue
3. **Provide detailed information** including:
   - macOS version
   - Mac model (Intel/Apple Silicon)
   - CleanKeyboard version
   - Steps to reproduce
   - Expected vs actual behavior

### Suggesting Features

1. **Check existing issues** to see if the feature has been suggested
2. **Use the feature request template** when creating a new issue
3. **Explain the use case** and how it would benefit users

### Contributing Code

#### Prerequisites

- macOS development environment
- Xcode command line tools: `xcode-select --install`
- Basic knowledge of Objective-C and macOS development

#### Development Setup

1. **Fork the repository**
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR-USERNAME/CleanKeyboardMac.git
   cd CleanKeyboardMac
   ```
3. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

#### Making Changes

1. **Build and test** your changes:
   ```bash
   ./build.sh
   ```
2. **Test the application** thoroughly:
   - Install and run the app
   - Test keyboard blocking functionality
   - Verify accessibility permissions work
   - Test on different macOS versions if possible

3. **Follow coding standards**:
   - Use consistent indentation (spaces, not tabs)
   - Comment complex logic
   - Keep functions focused and concise
   - Follow existing code style

#### Submitting Changes

1. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Add feature: brief description"
   ```
2. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```
3. **Create a Pull Request** using the provided template

## Project Structure

```
CleanKeyboardMac/
├── .github/              # GitHub templates and workflows
├── AppDelegate.h/m       # Main application logic and UI
├── KeyboardBlocker.h/m   # Keyboard event interception
├── main.m               # Application entry point
├── Info.plist           # App configuration
├── icon.png             # Source icon
├── CleanKeyboard.icns   # macOS icon bundle
├── build.sh             # Build script
├── install.sh           # Installation script
└── README.md            # Documentation
```

## Key Components

### AppDelegate
- Handles UI and user interactions
- Manages application lifecycle
- Shows notifications and permission dialogs

### KeyboardBlocker
- Implements CGEventTap for keyboard interception
- Manages accessibility permissions
- Handles event filtering

### Build System
- `build.sh`: Compiles app and creates DMG
- `install.sh`: Local installation helper
- GitHub Actions: Automated CI/CD

## Testing Guidelines

### Manual Testing
1. **Basic functionality**:
   - App launches successfully
   - UI displays correctly
   - Keyboard blocking works
   - Unlock functionality works

2. **Permission handling**:
   - First-run permission request
   - Graceful handling of denied permissions
   - Proper error messages

3. **Edge cases**:
   - App behavior when permissions are revoked
   - Multiple instances of the app
   - System sleep/wake cycles

### Automated Testing
- GitHub Actions run on all PRs
- Build verification on macOS latest
- DMG creation validation

## Release Process

1. **Version updates** are handled via Git tags
2. **GitHub Actions** automatically:
   - Build the application
   - Create DMG and ZIP artifacts
   - Generate release notes
   - Publish to GitHub Releases

## Questions?

- **General questions**: Open a [Discussion](https://github.com/Sauron-sol/CleanKeyboardMac/discussions)
- **Bug reports**: Use the [Bug Report template](https://github.com/Sauron-sol/CleanKeyboardMac/issues/new?template=bug_report.md)
- **Feature requests**: Use the [Feature Request template](https://github.com/Sauron-sol/CleanKeyboardMac/issues/new?template=feature_request.md)

Thank you for contributing to CleanKeyboard! 🎉
