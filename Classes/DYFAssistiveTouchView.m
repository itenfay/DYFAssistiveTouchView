//
//  DYFAssistiveTouchView.m
//
//  Created by dyf on 14/10/31.
//  Copyright (c) 2014 dyf.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <QuartzCore/QuartzCore.h>
#import "DYFAssistiveTouchView.h"

#pragma mark - macros

#define ScreenW          [UIScreen mainScreen].bounds.size.width
#define ScreenH          [UIScreen mainScreen].bounds.size.height
#define IsPortrait(ori)  UIInterfaceOrientationIsPortrait(ori)
#define SharedApp	     [UIApplication sharedApplication]

#pragma mark - category

@interface UIView (ATVEasyFrame)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end

@implementation UIView (ATVEasyFrame)
@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
@dynamic size;
@dynamic centerX;
@dynamic centerY;

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame= frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame= frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame= frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame= frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame= frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)centerY {
    return self.center.y;
}
@end

@implementation DYFAssistiveTouchObject

@end

@implementation DYFAssistiveTouchUnit

@end

@implementation DYFAssistiveTouchItem

@end

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@interface DYFAssistiveTouchView () <CAAnimationDelegate>
#else
@interface DYFAssistiveTouchView ()
#endif
@property (nonatomic, assign) BOOL shouldIndentHalf;
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic,  copy ) DYFTouchViewItemDidClickedBlock itemDidClickedBlock;
@end

@implementation DYFAssistiveTouchView

- (void)dealloc {
    [self unregisterOrientationObserver];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self addGesture];
        [self registerOrientationObserver];
    }
    return self;
}

- (void)setup {
    [self setUserInteractionEnabled:YES];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self setShowing:NO];
    [self setMoving:NO];
    [self setUnfolded:NO];
    [self setDistanceOfItem:10.0f];
    
    [self layoutAfterDelay];
    
    _touchObject = [[DYFAssistiveTouchObject alloc] init];
    _unitObject  = [[DYFAssistiveTouchUnit alloc] init];
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:tap];
}

- (void)unregisterOrientationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)registerOrientationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationDidChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (UIInterfaceOrientation)uiOrientation {
    return SharedApp.statusBarOrientation;
}

- (BOOL)iOS8OrNewer {
    return ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0);
}

- (UIView *)mainView {
    UIViewController *vc = SharedApp.windows[0].rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc.view;
}

- (void)makeHidden:(BOOL)hidden {
    [self setHidden:hidden];
}

- (void)layoutAfterDelay {
    [self performSelector:@selector(layoutViews) withObject:nil afterDelay:1.0];
}

- (void)layoutViews {
    [self setupImageView];
    [self addToSuperview];
    [self setAlpha:0.0];
}

- (void)addToSuperview {
    UIView *view = [self mainView];
    [view addSubview:self];
}

- (void)sendToFront {
    if (self.superview) {
        [self.superview bringSubviewToFront:self];
    }
}

- (void)setupImageView {
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.x = 0;
    _imageView.y = 0;
    _imageView.size = self.size;
    [self addSubview:_imageView];
}

- (void)show {
    [self setAlpha:0.0];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        [self setShowing:YES];
        [self setTouchViewNormalState];
        [self setTouchViewNormalImage];
        [self makeTouchViewTranslucentAfterDelay];
    }];
    
    [self makeHidden:NO];
}

- (void)hide {
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self setShowing:NO];
        [self makeHidden:YES];
        if (self.isUnfolded) {
            [self setUnfolded:NO];
        }
        [self removeToolBar];
    }];
    
    [self cancelMakeTouchViewTranslucentRequest];
}

- (void)setTouchViewPlace:(DYFTouchViewPlace)place {
    switch (place) {
        case DYFTouchViewAtTopLeft:
            [self setTouchViewLocationWithPlace:DYFTouchViewAtTopLeft];
            break;
            
        case DYFTouchViewAtTopRight:
            [self setTouchViewLocationWithPlace:DYFTouchViewAtTopRight];
            break;
            
        default:
        case DYFTouchViewAtMiddleLeft:
            [self setTouchViewLocationWithPlace:DYFTouchViewAtMiddleLeft];
            break;
            
        case DYFTouchViewAtMiddleRight:
            [self setTouchViewLocationWithPlace:DYFTouchViewAtMiddleRight];
            break;
            
        case DYFTouchViewAtBottomLeft:
            [self setTouchViewLocationWithPlace:DYFTouchViewAtBottomLeft];
            break;
            
        case DYFTouchViewAtBottomRight:
            [self setTouchViewLocationWithPlace:DYFTouchViewAtBottomRight];
            break;
    }
}

- (void)setTouchViewLocationWithPlace:(DYFTouchViewPlace)place {
    CGFloat width = 0;
    CGFloat height = 0;
    
    if (IsPortrait([self uiOrientation]) || [self iOS8OrNewer]) {
        width = ScreenW;
        height = ScreenH;
    } else {
        width = ScreenH;
        height = ScreenW;
    }
    
    if (place == DYFTouchViewAtTopLeft) {
        self.x = 0;
        self.y = 0;
    } else if (place == DYFTouchViewAtTopRight) {
        self.x = width - self.width;
        self.y = 0;
    } else if (place == DYFTouchViewAtMiddleLeft) {
        self.x = 0;
        self.centerY = height/2;
    } else if (place == DYFTouchViewAtMiddleRight) {
        self.x = width - self.width;
        self.centerY = height/2;
    } else if (place == DYFTouchViewAtBottomLeft) {
        self.x = 0;
        self.y = height;
    } else {
        self.x = width - self.width;
        self.y = height;
    }
}

- (void)touchViewItemDidClickedAtIndex:(DYFTouchViewItemDidClickedBlock)block {
    self.itemDidClickedBlock = block;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)gesture {
    [self handleUIResponds];
}

- (void)setTouchViewNormalImage {
    if ([self touchViewAtRight]) {
        _imageView.image = _touchObject.rightNormalImage;
    } else {
        _imageView.image = _touchObject.leftNormalImage;
    }
}

- (void)setTouchViewHighlightedImage {
    if ([self touchViewAtRight]) {
        if (_touchObject.rightHighlightedImage) {
            _imageView.highlightedImage = _touchObject.rightHighlightedImage;
        }
    } else {
        if (_touchObject.leftHighlightedImage) {
            _imageView.highlightedImage = _touchObject.leftHighlightedImage;
        }
    }
}

- (void)setTouchViewTranslucentImage {
    if ([self touchViewAtRight]) {
        if (_touchObject.rightTranslucentImage) {
            _imageView.image = _touchObject.rightTranslucentImage;
        }
    } else {
        if (_touchObject.leftTranslucentImage) {
            _imageView.image = _touchObject.leftTranslucentImage;
        }
    }
}

- (void)setTouchViewNormalState {
    _imageView.highlighted = NO;
}

- (void)setTouchViewHighlightedState {
    _imageView.highlighted = YES;
}

- (void)handleUIResponds {
    if (self.isUnfolded) {
        [self foldToolBar];
    } else {
        [self unfoldToolBar];
    }
}

- (void)makeTouchViewTranslucentAfterDelay {
    if (!self.isUnfolded && !self.isMoving) {
        [self performSelector:@selector(makeTouchViewTranslucent) withObject:nil afterDelay:8.0];
    }
}

- (void)cancelMakeTouchViewTranslucentRequest {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(makeTouchViewTranslucent) object:nil];
}

- (void)makeTouchViewTranslucent {
    [self setTouchViewTranslucentImage];
    [self sendToFront];
    if (self.shouldShowHalf) {
        [UIView animateWithDuration:0.5 animations:^{
            [self updateTouchViewLayout:YES];
        }];
    }
}

- (void)unfoldToolBar {
    if (![self isMoving]) {
        [self makeHidden:YES];
        [self setUnfolded:YES];
        [self setupToolBar];
        [self showToolBarWithAnimation];
    }
}

- (void)foldToolBar {
    [self setUnfolded:NO];
    [self makeToolBarHidden:YES];
    [self hideToolBarWithAnimation];
}

- (void)setupToolBar {
    UIView *view = [self mainView];
    
    _toolBar = [[UIView alloc] init];
    _toolBar.backgroundColor = [UIColor clearColor];
    _toolBar.userInteractionEnabled = YES;
    _toolBar.height = self.height;
    
    [view addSubview:_toolBar];
    
    [self addToolBarUnits];
}

- (void)makeToolBarHidden:(BOOL)hidden {
    [_toolBar setHidden:YES];
}

- (UIImage *)tbTouchImage {
    if ([self touchViewAtRight]) {
        return _unitObject.rightTouchImage;
    }
    return _unitObject.leftTouchImage;
}

- (UIImage *)tbItemBackgroundImage {
    if ([self touchViewAtRight]) {
        UIImage *rightItemBackgroundImage = _unitObject.rightItemBackgroundImage;
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 30, 0, 10);
        rightItemBackgroundImage = [rightItemBackgroundImage resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
        return rightItemBackgroundImage;
    } else {
        UIImage *leftItemBackgroundImage = _unitObject.leftItemBackgroundImage;
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
        leftItemBackgroundImage = [leftItemBackgroundImage resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
        return leftItemBackgroundImage;
    }
}

- (void)addToolBarUnits {
    CGFloat length = (self.items.count + 1)*self.distanceOfItem + 20;
    
    for (int idx = 0; idx < self.items.count; idx++) {
        DYFAssistiveTouchItem *item = [self.items objectAtIndex:idx];
        length += item.image.size.width;
    }
    
    UIImage *touchImage = [self tbTouchImage];
    [_toolBar setWidth:touchImage.size.width + length];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.showsTouchWhenHighlighted = YES;
    button.adjustsImageWhenHighlighted = NO;
    if ([self touchViewAtRight]) {
        button.x = length;
    } else {
        button.x = 0;
    }
    button.y = 0;
    button.width = touchImage.size.width;
    button.height = touchImage.size.height;
    if (touchImage) {
        [button setImage:touchImage forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(touchButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:button];
    
    UIImage *itemBackgroundImage = [self tbItemBackgroundImage];
    UIImageView *itemBackgroundImageView = [[UIImageView alloc] init];
    itemBackgroundImageView.userInteractionEnabled = YES;
    itemBackgroundImageView.image = itemBackgroundImage;
    if ([self touchViewAtRight]) {
        itemBackgroundImageView.x = 0;
    } else {
        itemBackgroundImageView.x = touchImage.size.width;
    }
    itemBackgroundImageView.y = (touchImage.size.height - itemBackgroundImage.size.height)/2;
    itemBackgroundImageView.width = length;
    itemBackgroundImageView.height = itemBackgroundImage.size.height;
    [_toolBar addSubview:itemBackgroundImageView];
    
    [self addToolBarItems:itemBackgroundImageView];
}

- (void)addToolBarItems:(UIImageView *)itemBackgroundImageView {
    CGFloat width = itemBackgroundImageView.width;
    CGFloat height = itemBackgroundImageView.height;
    
    for (int i = 0; i < self.items.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        DYFAssistiveTouchItem *item = [self.items objectAtIndex:i];
        CGSize itemSize = item.image.size;
        if ([self touchViewAtRight]) {
            button.x = width - (i + 1)*(itemSize.width + self.distanceOfItem);
        } else {
            button.x = self.distanceOfItem + i*(self.distanceOfItem + itemSize.width);
        }
        button.y = (height- itemSize.height)/2;
        button.width = itemSize.width;
        button.height = itemSize.height;
        if (item.image) {
            [button setImage:item.image forState:UIControlStateNormal];
        }
        if (item.highlightedImage) {
            [button setImage:item.highlightedImage forState:UIControlStateHighlighted];
        }
        [button setTag:i + 100];
        [button addTarget:self action:@selector(toolBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [itemBackgroundImageView addSubview:button];
    }
    
    [self updateToolBarOrigin];
}

- (void)updateToolBarOrigin {
    if ([self touchViewAtRight]) {
        if (self.shouldShowHalf && self.shouldIndentHalf) {
            _toolBar.x = self.x - _toolBar.width + self.width/2;
        } else {
            _toolBar.x = self.x - _toolBar.width + self.width;
        }
        _toolBar.y = self.y;
    } else {
        if (self.shouldShowHalf && self.shouldIndentHalf) {
            _toolBar.x = self.x + self.width/2;
        } else {
            _toolBar.x = self.x;
        }
        _toolBar.y = self.y;
    }
}

- (void)showToolBarWithAnimation {
    if ([self touchViewAtRight]) {
        [self setToolBarAnimationWithType:kCATransitionPush subtype:kCATransitionFromRight];
    } else {
        [self setToolBarAnimationWithType:kCATransitionPush subtype:kCATransitionFromLeft];
    }
}

- (void)hideToolBarWithAnimation {
    if ([self touchViewAtRight]) {
        [self setToolBarAnimationWithType:kCATransitionPush subtype:kCATransitionFromLeft];
    } else {
        [self setToolBarAnimationWithType:kCATransitionPush subtype:kCATransitionFromRight];
    }
}

- (BOOL)touchViewAtRight {
    BOOL isAtRight = NO;
    if (IsPortrait([self uiOrientation]) || [self iOS8OrNewer]) {
        if (self.centerX < ScreenW/2) {
            isAtRight = NO;
        } else {
            isAtRight = YES;
        }
    } else {
        if (self.centerX < ScreenH/2) {
            isAtRight = NO;
        } else {
            isAtRight = YES;
        }
    }
    return isAtRight;
}

#pragma mark - 按钮触发事件

- (void)touchButtonDidClicked:(UIButton *)sender {
    [self handleUIResponds];
}

- (void)toolBarItemAction:(UIButton *)sender {
    [self handleUIResponds];
    _indexOfItem = sender.tag - 100;
    if ([self.delegate respondsToSelector:@selector(touchViewItemDidClickedAtIndex:)]) {
        [self.delegate touchViewItemDidClickedAtIndex:self];
    }
    if (self.itemDidClickedBlock) {
        self.itemDidClickedBlock(self);
    }
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self cancelMakeTouchViewTranslucentRequest];
    UITouch *touch = [touches anyObject];
    _beginPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isUnfolded) return;
    
    [self setMoving:YES];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    CGFloat dx = location.x - _beginPoint.x;
    CGFloat dy = location.y - _beginPoint.y;
    
    self.centerX = self.centerX + dx;
    self.centerY = self.centerY + dy;
    
    [self setTouchViewHighlightedState];
    [self setTouchViewHighlightedImage];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTouchViewNormalState];
    [self setTouchViewNormalImage];
    [self makeTouchViewLocateScreenEdgeWithAnimation];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTouchViewNormalState];
    [self setTouchViewNormalImage];
    [self makeTouchViewLocateScreenEdgeWithAnimation];
}

- (void)updateTouchViewLayout:(BOOL)setNeedsIndentHalf {
    [self setShouldIndentHalf:setNeedsIndentHalf];
    
    CGFloat dw = 0;
    CGFloat dh = 0;
    if (IsPortrait([self uiOrientation]) || [self iOS8OrNewer]) {
        dw = ScreenW;
        dh = ScreenH;
    } else {
        dw = ScreenH;
        dh = ScreenW;
    }
    
    CGFloat left = self.width/2;
    CGFloat top = self.height/2;
    
    if (self.centerX > dw/2) {
        self.centerX = (self.shouldShowHalf && self.shouldIndentHalf)? dw: (dw - left);
        if (self.centerY > dh - top) {
            self.centerY = dh - top;
        }
        if (self.centerY < top) {
            self.centerY = top;
        }
    } else {
        self.centerX = (self.shouldShowHalf && self.shouldIndentHalf)? 0: left;
        if (self.centerY > dh - top) {
            self.centerY = dh - top;
        }
        if (self.centerY < top) {
            self.centerY = top;
        }
    }
}

- (void)makeTouchViewLocateScreenEdgeWithAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        [self updateTouchViewLayout:NO];
    } completion:^(BOOL finished) {
        [self setMoving:NO];
        [self makeTouchViewTranslucentAfterDelay];
    }];
}

- (void)removeToolBar {
    if (self.toolBar) {
        [self.toolBar removeFromSuperview];
        self.toolBar = nil;
    }
}

- (void)statusBarOrientationDidChange:(NSNotification *)noti {
    [self updateLayout];
    [self cancelMakeTouchViewTranslucentRequest];
}

- (void)updateLayout {
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    if (self.isUnfolded) {
        [self removeToolBar];
        [self setUnfolded:NO];
    }
    [self makeHidden:NO];
    [self setTouchViewNormalState];
    [self setTouchViewNormalImage];
    [self makeTouchViewLocateScreenEdgeWithAnimation];
}

- (void)setShowing:(BOOL)showing {
    _showing = showing;
}

- (void)setMoving:(BOOL)moving {
    _moving = moving;
}

- (void)setUnfolded:(BOOL)unfolded {
    _unfolded = unfolded;
}

- (void)setToolBarAnimationWithType:(NSString *)type subtype:(NSString *)subtype {
    if (self.toolBar) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = type;
        animation.subtype = subtype;
        animation.delegate = self;
        [self.toolBar.layer addAnimation:animation forKey:@"atvanimation"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        if (self.toolBar) {
            [self.toolBar.layer removeAnimationForKey:@"atvanimation"];
        }
        
        if (![self isUnfolded]) {
            [self removeToolBar];
            [self setTouchViewNormalState];
            [self setTouchViewNormalImage];
            [self makeHidden:NO];
            
            [self setAlpha:0.0];
            [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setAlpha:1.0];
            } completion:^(BOOL finished) {
                [self makeTouchViewTranslucentAfterDelay];
            }];
        }
    }
}

@end
