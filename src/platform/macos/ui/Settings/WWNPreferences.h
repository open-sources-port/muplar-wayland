#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class WWNPreferencesSection;
@interface WWNPreferences : NSWindowController
@property(nonatomic, strong, readonly)
    NSArray<WWNPreferencesSection *> *sections;

+ (instancetype)sharedPreferences;
- (void)showPreferences:(id)sender;
- (void)selectSectionWithTitle:(NSString *)title;
- (void)openMachinesConfiguration:(id)sender;

@end

NS_ASSUME_NONNULL_END
