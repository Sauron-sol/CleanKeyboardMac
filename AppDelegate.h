#import <Cocoa/Cocoa.h>

@class KeyboardBlocker;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) NSWindow *window;
@property (strong, nonatomic) NSButton *toggleButton;
@property (strong, nonatomic) NSTextField *statusLabel;
@property (strong, nonatomic) KeyboardBlocker *keyboardBlocker;
@property (assign, nonatomic) BOOL isBlocking;

@end
