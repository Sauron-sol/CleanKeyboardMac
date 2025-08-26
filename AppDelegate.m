#import "AppDelegate.h"
#import "KeyboardBlocker.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setupWindow];
    [self setupKeyboardBlocker];
}

- (void)setupWindow {
    // Create main window
    NSRect windowFrame = NSMakeRect(0, 0, 300, 150);
    self.window = [[NSWindow alloc] initWithContentRect:windowFrame
                                              styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    
    [self.window setTitle:@"CleanKeyboard"];
    [self.window center];
    [self.window makeKeyAndOrderFront:nil];
    
    // Create content view
    NSView *contentView = [[NSView alloc] initWithFrame:windowFrame];
    [self.window setContentView:contentView];
    
    // Status label
    self.statusLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(50, 100, 200, 30)];
    [self.statusLabel setStringValue:@"Keyboard unlocked"];
    [self.statusLabel setBezeled:NO];
    [self.statusLabel setDrawsBackground:NO];
    [self.statusLabel setEditable:NO];
    [self.statusLabel setAlignment:NSTextAlignmentCenter];
    [self.statusLabel setFont:[NSFont systemFontOfSize:16]];
    [contentView addSubview:self.statusLabel];
    
    // Toggle button
    self.toggleButton = [[NSButton alloc] initWithFrame:NSMakeRect(75, 40, 150, 40)];
    [self.toggleButton setTitle:@"🔓 Start Cleaning"];
    [self.toggleButton setTarget:self];
    [self.toggleButton setAction:@selector(toggleKeyboardBlocking:)];
    [self.toggleButton setBezelStyle:NSBezelStyleRounded];
    [contentView addSubview:self.toggleButton];
    
    // Instructions
    NSTextField *instructionLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 10, 260, 20)];
    [instructionLabel setStringValue:@"Click to lock/unlock keyboard for cleaning"];
    [instructionLabel setBezeled:NO];
    [instructionLabel setDrawsBackground:NO];
    [instructionLabel setEditable:NO];
    [instructionLabel setAlignment:NSTextAlignmentCenter];
    [instructionLabel setFont:[NSFont systemFontOfSize:12]];
    [instructionLabel setTextColor:[NSColor secondaryLabelColor]];
    [contentView addSubview:instructionLabel];
}

- (void)setupKeyboardBlocker {
    self.keyboardBlocker = [[KeyboardBlocker alloc] init];
    self.isBlocking = NO;
}

- (void)toggleKeyboardBlocking:(id)sender {
    if (self.isBlocking) {
        [self stopKeyboardBlocking];
    } else {
        [self startKeyboardBlocking];
    }
}

- (void)startKeyboardBlocking {
    if ([self.keyboardBlocker startBlocking]) {
        self.isBlocking = YES;
        [self.toggleButton setTitle:@"🔒 Stop Cleaning"];
        [self.statusLabel setStringValue:@"🔒 Keyboard locked!"];
        [self.statusLabel setTextColor:[NSColor systemRedColor]];
        
        // Show notification
        NSUserNotification *notification = [[NSUserNotification alloc] init];
        notification.title = @"CleanKeyboard";
        notification.informativeText = @"Keyboard locked! You can safely clean your keyboard.";
        notification.soundName = NSUserNotificationDefaultSoundName;
        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    } else {
        // Permission error
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = @"Accessibility Permissions Required";
        alert.informativeText = @"CleanKeyboard needs accessibility permissions to function.\n\nPlease go to:\nSystem Preferences > Security & Privacy > Privacy > Accessibility\n\nAnd add CleanKeyboard to the list of allowed applications.";
        alert.alertStyle = NSAlertStyleWarning;
        [alert addButtonWithTitle:@"Open System Preferences"];
        [alert addButtonWithTitle:@"Cancel"];
        
        NSModalResponse response = [alert runModal];
        if (response == NSAlertFirstButtonReturn) {
            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"]];
        }
    }
}

- (void)stopKeyboardBlocking {
    [self.keyboardBlocker stopBlocking];
    self.isBlocking = NO;
    [self.toggleButton setTitle:@"🔓 Start Cleaning"];
    [self.statusLabel setStringValue:@"Keyboard unlocked"];
    [self.statusLabel setTextColor:[NSColor labelColor]];
    
    // Show notification
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"CleanKeyboard";
    notification.informativeText = @"Keyboard unlocked! Cleaning completed.";
    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    if (self.isBlocking) {
        [self stopKeyboardBlocking];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end