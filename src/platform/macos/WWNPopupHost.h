//
//  WWNPopupHost.h
//  WWN
//
//  Created by WWN Agent.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
typedef NSView WWNNativeView;

NS_ASSUME_NONNULL_BEGIN

@protocol WWNPopupHost <NSObject>

@required
@property(nonatomic, readonly) WWNNativeView *contentView;
@property(nonatomic, readonly) WWNNativeView *parentView;
- (instancetype)initWithParentView:(WWNNativeView *)parentView;

- (void)showAtScreenPoint:(CGPoint)point;

- (void)dismiss;

// Update content size (Wayland configure event)
- (void)setContentSize:(CGSize)size;

// Set the window ID for content mapping
@property(nonatomic, assign) uint64_t windowId;

// Callback for when the popup is dismissed by user (e.g. click outside)
@property(nonatomic, copy, nullable) void (^onDismiss)(void);

@end

NS_ASSUME_NONNULL_END
