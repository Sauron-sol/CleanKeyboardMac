#import "KeyboardBlocker.h"

// Callback function to intercept keyboard events
CGEventRef keyboardEventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    // Block all keyboard events (key down and key up)
    if (type == kCGEventKeyDown || type == kCGEventKeyUp) {
        // Returning NULL blocks the event
        return NULL;
    }
    
    // Let other events pass through (mouse, etc.)
    return event;
}

@implementation KeyboardBlocker

- (instancetype)init {
    self = [super init];
    if (self) {
        self.eventTap = NULL;
        self.runLoopSource = NULL;
    }
    return self;
}

- (BOOL)startBlocking {
    // Check if we already have accessibility permissions
    if (!AXIsProcessTrusted()) {
        return NO;
    }
    
    // Create event tap to intercept keyboard events
    self.eventTap = CGEventTapCreate(
        kCGSessionEventTap,                    // tap location
        kCGHeadInsertEventTap,                // place at head
        kCGEventTapOptionDefault,             // options
        CGEventMaskBit(kCGEventKeyDown) | CGEventMaskBit(kCGEventKeyUp), // events to intercept
        keyboardEventCallback,                // callback function
        (__bridge void *)self                 // user data
    );
    
    if (!self.eventTap) {

        return NO;
    }
    
    // Create run loop source
    self.runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, self.eventTap, 0);
    
    // Add to main run loop
    CFRunLoopAddSource(CFRunLoopGetCurrent(), self.runLoopSource, kCFRunLoopCommonModes);
    
    // Enable event tap
    CGEventTapEnable(self.eventTap, true);
    
    
    return YES;
}

- (void)stopBlocking {
    if (self.eventTap) {
        // Disable event tap
        CGEventTapEnable(self.eventTap, false);
        
        // Remove from run loop
        if (self.runLoopSource) {
            CFRunLoopRemoveSource(CFRunLoopGetCurrent(), self.runLoopSource, kCFRunLoopCommonModes);
            CFRelease(self.runLoopSource);
            self.runLoopSource = NULL;
        }
        
        // Release event tap
        CFRelease(self.eventTap);
        self.eventTap = NULL;
        

    }
}

- (void)dealloc {
    [self stopBlocking];
}

@end
