#import "WWNMachinesCoordinator.h"
#import "../Settings/WWNPreferences.h"
#import <objc/message.h>

@interface WWNMachinesCoordinator ()
@property(nonatomic, strong) NSWindowController *macMachinesController;
@end

@implementation WWNMachinesCoordinator

+ (instancetype)sharedCoordinator {
  static WWNMachinesCoordinator *shared = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[self alloc] init];
  });
  return shared;
}

- (NSWindowController *)buildSwiftUIMachinesWindowController:(dispatch_block_t)onConnect {
  NSArray<NSString *> *candidateNames = @[
    @"WWNMachinesHostingBridge",
    @"Wawona.WWNMachinesHostingBridge",
    @"Wawona_iOS.WWNMachinesHostingBridge",
    @"Wawona_macOS.WWNMachinesHostingBridge",
  ];
  Class bridgeClass = Nil;
  for (NSString *name in candidateNames) {
    bridgeClass = NSClassFromString(name);
    if (bridgeClass) {
      break;
    }
  }
  SEL selector = NSSelectorFromString(@"buildMacMachinesWindowControllerWithOnConnect:");
  if (!bridgeClass || ![bridgeClass respondsToSelector:selector]) {
    return nil;
  }
  NSWindowController *(*buildFn)(id, SEL, dispatch_block_t) =
      (NSWindowController *(*)(id, SEL, dispatch_block_t))objc_msgSend;
  return buildFn(bridgeClass, selector, onConnect);
}

- (void)showMachinesWindowAndActivate:(BOOL)activate {
  NSWindowController *controller =
      [self buildSwiftUIMachinesWindowController:nil];
  if (controller) {
    self.macMachinesController = controller;
  }
  if (!self.macMachinesController) {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Machines UI Unavailable";
    alert.informativeText =
        @"SwiftUI machines view failed to load. Regenerate the Xcode project and rebuild.";
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
    return;
  }
  if (activate) {
    [NSApp activateIgnoringOtherApps:YES];
  }
  [self.macMachinesController showWindow:nil];
}

- (void)showMachinesWindowFromMenu:(id)sender {
  (void)sender;
  [self showMachinesWindowAndActivate:YES];
}

@end
