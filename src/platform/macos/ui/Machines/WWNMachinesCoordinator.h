#import <Foundation/Foundation.h>
#import <TargetConditionals.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWNMachinesCoordinator : NSObject

+ (instancetype)sharedCoordinator;

- (void)showMachinesWindowAndActivate:(BOOL)activate;
- (void)showMachinesWindowFromMenu:(id)sender;

@end

NS_ASSUME_NONNULL_END
