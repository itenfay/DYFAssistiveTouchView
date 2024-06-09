//
//  ViewController.m
//
//  Created by Tenfay on 14/10/31.
//  Copyright © 2014年 Tenfay. All rights reserved.
//

#import "ViewController.h"
#import "DYFAssistiveTouchView.h"
#import <SafariServices/SafariServices.h>

@interface ViewController ()
@property(nonatomic, strong) DYFAssistiveTouchView *touchView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)configureAction:(id)sender {
    if (!_touchView) {
        [self configTouchViewDotImages];
        [self configTouchViewUnits];
        [self configTouchViewItems];
        
        [self.touchView setShouldShowHalf:YES];
        [self.touchView setTouchViewPlace:DYFTouchViewAtMiddleRight];
        
        __weak typeof(self) weakSelf = self;
        [self.touchView touchViewItemDidClickedAtIndex:^(DYFAssistiveTouchView *touchView) {
            NSInteger index = touchView.indexOfItem;
            NSLog(@"Index of item: %zi", index);
            [weakSelf presentAtIndex:index];
        }];
    }
}

- (IBAction)showAndHideAction:(id)sender {
    if (_touchView) {
        if ([self.touchView isShowing]) {
            [self.touchView hide];
        } else {
            [self.touchView show];
        }
    }
}

- (void)presentAtIndex:(NSInteger)index {
    NSString *url = @"https://support.apple.com/zh-cn";
    if (index == 0) {
        url = @"https://github.com/itenfay";
    } else if (index == 1) {
        url = @"https://github.com/itenfay/Awesome";
    } else {
        url = @"https://www.jianshu.com/u/7fc76f1179cc";
    }
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:safariVC animated:YES completion:NULL];
}

- (void)configTouchViewDotImages {
    UIImage        *leftHidenImage = [UIImage imageNamed:@"atv_hide_left"];
    UIImage       *rightHidenImage = leftHidenImage;
    UIImage       *leftNormalImage = [UIImage imageNamed:@"atv_normal_left"];
    UIImage      *rightNormalImage = leftNormalImage;
    UIImage  *leftHighlightedImage = [UIImage imageNamed:@"atv_normal_left"];
    UIImage *rightHighlightedImage = leftHighlightedImage;
    
    self.touchView.touchObject.leftNormalImage       = leftNormalImage;
    self.touchView.touchObject.rightNormalImage      = rightNormalImage;
    self.touchView.touchObject.leftHighlightedImage  = leftHighlightedImage;
    self.touchView.touchObject.rightHighlightedImage = rightHighlightedImage;
    self.touchView.touchObject.leftTranslucentImage  = leftHidenImage;
    self.touchView.touchObject.rightTranslucentImage = rightHidenImage;
}

- (void)configTouchViewUnits {
    UIImage  *leftUint1Image = [UIImage imageNamed:@"atv_unit1_left"];
    UIImage *rightUint1Image = [UIImage imageNamed:@"atv_unit1_right"];
    UIImage  *leftUint2Image = [UIImage imageNamed:@"atv_unit2_left"];
    UIImage *rightUint2Image = [UIImage imageNamed:@"atv_unit2_right"];
    
    self.touchView.unitObject.leftTouchImage           = leftUint1Image;
    self.touchView.unitObject.rightTouchImage          = rightUint1Image;
    self.touchView.unitObject.leftItemBackgroundImage  = leftUint2Image;
    self.touchView.unitObject.rightItemBackgroundImage = rightUint2Image;
}

- (void)configTouchViewItems {
    UIImage *userImage = [UIImage imageNamed:@"atv_item_user"];
    UIImage *cafeImage = [UIImage imageNamed:@"atv_item_cafe"];
    UIImage   *csImage = [UIImage imageNamed:@"atv_item_cs"];
    
    DYFAssistiveTouchItem *item  = [[DYFAssistiveTouchItem alloc] init];
    item.image  = userImage;
    DYFAssistiveTouchItem *item1 = [[DYFAssistiveTouchItem alloc] init];
    item1.image = cafeImage;
    DYFAssistiveTouchItem *item2 = [[DYFAssistiveTouchItem alloc] init];
    item2.image = csImage;
    
    self.touchView.items = @[item, item1, item2];
}

#pragma mark - Lazy load

- (DYFAssistiveTouchView *)touchView {
    if (!_touchView) {
        _touchView = [[DYFAssistiveTouchView alloc] init];
        _touchView.frame = CGRectMake(0, 0, 50, 50);
    }
    return _touchView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
