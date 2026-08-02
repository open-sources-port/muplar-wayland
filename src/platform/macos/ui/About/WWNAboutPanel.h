#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWNAboutPanel : NSWindowController

+ (instancetype)sharedAboutPanel;
- (void)showAboutPanel:(id)sender;

@end

NS_ASSUME_NONNULL_END

