//  WWNPlatformCallbacks.m
//  Implementation of platform callbacks for Rust compositor

#import "WWNPlatformCallbacks.h"
#import "WWNWindow.h"
#import "../../util/WWNLog.h"

@implementation WWNPlatformCallbacks

+ (instancetype)sharedCallbacks {
  static WWNPlatformCallbacks *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[WWNPlatformCallbacks alloc] init];
  });
  return sharedInstance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _windowRegistry = [NSMutableDictionary dictionary];
  }
  return self;
}

#pragma mark - Window Management

- (void)createNativeWindowWithId:(uint64_t)windowId
                           width:(int32_t)width
                          height:(int32_t)height
                           title:(NSString *)title
                          useSSD:(BOOL)useSSD {
  dispatch_async(dispatch_get_main_queue(), ^{
    // macOS window creation
    NSWindowStyleMask styleMask =
        useSSD ? (NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                  NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable)
               : (NSWindowStyleMaskBorderless | NSWindowStyleMaskResizable);

    NSRect contentRect = NSMakeRect(100, 100, width, height);
    NSWindow *window =
        [[WWNWindow alloc] initWithContentRect:contentRect
                                     styleMask:styleMask
                                       backing:NSBackingStoreBuffered
                                         defer:NO];

    // Create and set WWNView as content view to handle input
    WWNView *contentView =
        [[WWNView alloc] initWithFrame:NSMakeRect(0, 0, width, height)];
    [window setContentView:contentView];

    window.title = title ?: @"WWN Client";
    window.delegate = (id<NSWindowDelegate>)self; // For window lifecycle events

    [self.windowRegistry setObject:window forKey:@(windowId)];
    [window makeKeyAndOrderFront:nil];

    WWNLog("PLATFORM", @"Created native window %llu: %@", windowId, title);
  });
}

- (void)destroyNativeWindowWithId:(uint64_t)windowId {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSWindow *window = [self.windowRegistry objectForKey:@(windowId)];
    if (window) {
      [window close];
      [self.windowRegistry removeObjectForKey:@(windowId)];
      WWNLog("PLATFORM", @"Destroyed native window %llu", windowId);
    }
  });
}

- (void)setWindowTitle:(NSString *)title forWindowId:(uint64_t)windowId {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSWindow *window = [self.windowRegistry objectForKey:@(windowId)];
    if (window) {
      window.title = title;
    }
  });
}

- (void)setWindowSize:(CGSize)size forWindowId:(uint64_t)windowId {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSWindow *window = [self.windowRegistry objectForKey:@(windowId)];
    if (window) {
      NSRect frame = window.frame;
      NSRect contentRect =
          NSMakeRect(frame.origin.x, frame.origin.y, size.width, size.height);
      NSRect newFrame = [window frameRectForContentRect:contentRect];
      [window setFrame:newFrame display:YES animate:YES];
    }
  });
}

- (void)requestRenderForWindowId:(uint64_t)windowId {
  // TODO: Trigger Metal rendering for this window
  // For now, this is a stub
}

@end
