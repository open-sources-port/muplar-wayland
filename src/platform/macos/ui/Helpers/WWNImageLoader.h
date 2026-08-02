#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
typedef NSImage *WImage;

NS_ASSUME_NONNULL_BEGIN

@interface WWNImageLoader : NSObject

+ (instancetype)sharedLoader;

/**
 * Loads an image from a URL (remote or local path) and caches it.
 * @param urlString The URL string or local file path.
 * @param completion Block called on main thread with the loaded image or nil.
 */
- (void)loadImageFromURL:(NSString *)urlString
              completion:(void (^)(WImage _Nullable image))completion;

/**
 * Clears the on-disk cache.
 */
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
