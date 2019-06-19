//
//  DYFAssistiveTouchView.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DYFAssistiveTouchView;

typedef NS_ENUM(NSInteger, DYFTouchViewPlace) {
    DYFTouchViewAtTopLeft     = 1 << 0, // At top and left.
    DYFTouchViewAtTopRight    = 1 << 1, // At top and right.
    DYFTouchViewAtMiddleLeft  = 1 << 2, // At middle and left.
    DYFTouchViewAtMiddleRight = 1 << 3, // At middle and right.
    DYFTouchViewAtBottomLeft  = 1 << 4, // At bottom and left.
    DYFTouchViewAtBottomRight = 1 << 5, // At bottom and right.
};

@protocol DYFAssistiveTouchViewDelegate <NSObject>

@optional
/**
 *  TouchView item did clicked.
 *
 *  @param touchView An `DYFAssistiveTouchView` object.
 */
- (void)touchViewItemDidClickedAtIndex:(nullable DYFAssistiveTouchView *)touchView;

@end

/**
 *  TouchView item did clicked with block.
 *
 *  @param touchView An `DYFAssistiveTouchView` object.
 */
typedef void (^DYFTouchViewItemDidClickedBlock)(DYFAssistiveTouchView *_Nullable touchView);

@interface DYFAssistiveTouchObject : NSObject
// TouchView normal image at left.
@property (nonatomic, strong, nullable) UIImage *leftNormalImage;
// TouchView normal image at right.
@property (nonatomic, strong, nullable) UIImage *rightNormalImage;
// TouchView highlighted image at left.
@property (nonatomic, strong, nullable) UIImage *leftHighlightedImage;
// TouchView highlighted image at right.
@property (nonatomic, strong, nullable) UIImage *rightHighlightedImage;
// TouchView translucent image at left.
@property (nonatomic, strong, nullable) UIImage *leftTranslucentImage;
// TouchView translucent image at right.
@property (nonatomic, strong, nullable) UIImage *rightTranslucentImage;
@end

@interface DYFAssistiveTouchUnit : NSObject
// Left touch image.
@property (nonatomic, strong, nullable) UIImage *leftTouchImage;
// Right touch image.
@property (nonatomic, strong, nullable) UIImage *rightTouchImage;
// Left item background image.
@property (nonatomic, strong, nullable) UIImage *leftItemBackgroundImage;
// Right item background image.
@property (nonatomic, strong, nullable) UIImage *rightItemBackgroundImage;
@end

@interface DYFAssistiveTouchItem: NSObject
// Normal image.
@property (nonatomic, strong, nullable) UIImage *image;
// Highlighted image.
@property (nonatomic, strong, nullable) UIImage *highlightedImage;
@end

@interface DYFAssistiveTouchView : UIView
// The delegate for touchView item which did clicked.
@property (nonatomic, weak, nullable) id<DYFAssistiveTouchViewDelegate> delegate;

// TouchView is displaying or not displaying.
@property (nonatomic, assign, readonly, getter=isShowing) BOOL showing;
// TouchView is moving or not moving.
@property (nonatomic, assign, readonly, getter=isMoving) BOOL moving;
// TouchView is unfolded or not folded.
@property (nonatomic, assign, readonly, getter=isUnfolded) BOOL unfolded;

// TouchView images.
@property (nonatomic, strong, nullable) DYFAssistiveTouchObject *touchObject;
// TouchView unit.
@property (nonatomic, strong, nullable) DYFAssistiveTouchUnit *unitObject;
// TouchView items.
@property (nonatomic, strong, nullable) NSArray<DYFAssistiveTouchItem *> *items;

// TouchView item distance, default is 10.0.
@property (nonatomic, assign) CGFloat distanceOfItem;
// TouchView should show half or not.
@property (nonatomic, assign) BOOL shouldShowHalf;
// TouchView item index.
@property (nonatomic, assign, readonly) NSInteger indexOfItem;

/**
 *  Set touchView begin location.
 *
 *  @param place Begin location enum for touchView.
 */
- (void)setTouchViewPlace:(DYFTouchViewPlace)place;

/**
 *  TouchView has displayed.
 */
- (void)show;

/**
 *  TouchView has hidden.
 */
- (void)hide;

/**
 *  Set an block for touchView item which did clicked.
 *
 *  @param block Executing after touchView item which did clicked.
 */
- (void)touchViewItemDidClickedAtIndex:(nullable DYFTouchViewItemDidClickedBlock)block;

@end
