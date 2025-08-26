#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

@interface KeyboardBlocker : NSObject

@property (assign, nonatomic) CFMachPortRef eventTap;
@property (assign, nonatomic) CFRunLoopSourceRef runLoopSource;

- (BOOL)startBlocking;
- (void)stopBlocking;

@end
