//
//  ViewController.m
//
//  Created by dyf on 14/10/31.
//  Copyright © 2014年 dyf. All rights reserved.
//

#import "ViewController.h"
#import "DYFAssistiveTouchView.h"

@interface ViewController () {
    DYFAssistiveTouchView *_touchView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setImagesForAT {
    UIImage *leftHideImage = [UIImage imageNamed:@"atv_hide_left"];
    UIImage *rightHideImage = leftHideImage;
    UIImage *leftNormalImage = [UIImage imageNamed:@"atv_normal_left"];
    UIImage *rightNormalImage = leftNormalImage;
    UIImage *leftHighlightedImage = [UIImage imageNamed:@"atv_normal_left"];
    UIImage *rightHighlightedImage = leftHighlightedImage;
    _touchView.imageObject.leftNormalImage = leftNormalImage;
    _touchView.imageObject.rightNormalImage = rightNormalImage;
    _touchView.imageObject.leftHighlightedImage = leftHighlightedImage;
    _touchView.imageObject.rightHighlightedImage = rightHighlightedImage;
    _touchView.imageObject.leftTranslucentImage = leftHideImage;
    _touchView.imageObject.rightTranslucentImage = rightHideImage;
}

- (void)setUnitsForAT {
    UIImage *leftUint1Image = [UIImage imageNamed:@"atv_unit1_left"];
    UIImage *rightUint1Image = [UIImage imageNamed:@"atv_unit1_right"];
    UIImage *leftUint2Image = [UIImage imageNamed:@"atv_unit2_left"];
    UIImage *rightUint2Image = [UIImage imageNamed:@"atv_unit2_right"];
    _touchView.unitImageObject.leftTouchImage = leftUint1Image;
    _touchView.unitImageObject.rightTouchImage = rightUint1Image;
    _touchView.unitImageObject.leftItemBackgroundImage = leftUint2Image;
    _touchView.unitImageObject.rightItemBackgroundImage = rightUint2Image;
}

- (void)setItemsForAT {
    UIImage *userImage = [UIImage imageNamed:@"atv_item_user"];
    UIImage *cafeImage = [UIImage imageNamed:@"atv_item_cafe"];
    UIImage *csImage = [UIImage imageNamed:@"atv_item_cs"];
    DYFAssistiveTouchViewItemImage *itemImage = [[DYFAssistiveTouchViewItemImage alloc] init];
    itemImage.image = userImage;
    DYFAssistiveTouchViewItemImage *itemImage1 = [[DYFAssistiveTouchViewItemImage alloc] init];
    itemImage1.image = cafeImage;
    DYFAssistiveTouchViewItemImage *itemImage2 = [[DYFAssistiveTouchViewItemImage alloc] init];
    itemImage2.image = csImage;
    _touchView.items = @[itemImage, itemImage1, itemImage2];
}

- (IBAction)createAction:(id)sender {
    if (!_touchView) {
        _touchView = [[DYFAssistiveTouchView alloc] init];
        _touchView.frame = CGRectMake(0, 0, 50, 50);
        [self setImagesForAT];
        [self setUnitsForAT];
        [self setItemsForAT];
        [_touchView setShouldShowHalf:YES];
        [_touchView setTouchViewPlace:DYFTouchViewAtMiddleRight];
        [_touchView touchViewItemDidClickedAtIndex:^(DYFAssistiveTouchView *touchView) {
            NSLog(@"[DYF] Index Of Item: %ld", (long)touchView.indexOfItem);
        }];
    }
}

- (IBAction)showAndHideAction:(id)sender {
    if ([_touchView isShowing]) {
        [_touchView hide];
    } else {
        [_touchView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
