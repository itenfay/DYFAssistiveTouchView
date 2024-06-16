如果能帮助到你，请你给[一颗星](https://github.com/itenfay/DYFAssistiveTouchView)，谢谢！(If this can help you, please give it a [star](https://github.com/itenfay/DYFAssistiveTouchView), Thanks!)

## DYFAssistiveTouchView

实现应用内悬浮按钮和辅助工具条，可以增加/修改 Item 项，通过事件索引完成各种场景页面的跳转。

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/DYFAssistiveTouchView.svg?style=flat)](http://cocoapods.org/pods/DYFAssistiveTouchView)&nbsp;
![CocoaPods](http://img.shields.io/cocoapods/p/DYFAssistiveTouchView.svg?style=flat)&nbsp;

## Installation

Using [CocoaPods](https://cocoapods.org):

```
pod 'DYFAssistiveTouchView'
```

Or

```
 pod 'DYFAssistiveTouchView', '~> 4.3.1'
```

## Group (ID:614799921)

<div align=left>
&emsp; <img src="https://github.com/itenfay/DYFAssistiveTouchView/raw/master/images/g614799921.jpg" width="30%" />
</div>

## Priview

<div align=left>
&emsp; <img src="https://github.com/itenfay/DYFAssistiveTouchView/raw/master/images/AssistiveTouchViewPreview.gif" width="30%" />
</div>

## Usage

1. 实例化

```ObjC
// Lazy load
- (DYFAssistiveTouchView *)touchView {
    if (!_touchView) {
        _touchView = [[DYFAssistiveTouchView alloc] init];
        _touchView.frame = CGRectMake(0, 0, 50, 50);
    }
    return _touchView;
}
```

2. 设置属性

- 设置悬浮按钮的各种状态的图片

```ObjC
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
```

- 设置Unit对象

```ObjC
UIImage  *leftUint1Image = [UIImage imageNamed:@"atv_unit1_left"];
UIImage *rightUint1Image = [UIImage imageNamed:@"atv_unit1_right"];
UIImage  *leftUint2Image = [UIImage imageNamed:@"atv_unit2_left"];
UIImage *rightUint2Image = [UIImage imageNamed:@"atv_unit2_right"];

self.touchView.unitObject.leftTouchImage           = leftUint1Image;
self.touchView.unitObject.rightTouchImage          = rightUint1Image;
self.touchView.unitObject.leftItemBackgroundImage  = leftUint2Image;
self.touchView.unitObject.rightItemBackgroundImage = rightUint2Image;
```

- 设置Item对象

```ObjC
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
```

3. 是否显示

```ObjC
[self.touchView isShowing]
```

4. 显示

```ObjC
[self.touchView show];
```

5. 隐藏

```ObjC
[self.touchView hide];
```

6. 隐藏一半至屏幕

```ObjC
[self.touchView setShouldShowHalf:YES];
```

7. 设置初始显示位置

```ObjC
[self.touchView setTouchViewPlace:DYFTouchViewAtMiddleRight];
```

8. 响应事件(二选一)

```ObjC
- (void)presentAtIndex:(NSInteger)index {
    NSString *url = @"https://support.apple.com/zh-cn";

    if (index == 0) {
        url = @"https://github.com/itenfay";
    } 
    else if (index == 1) {
        url = @"https://github.com/itenfay/Awesome";
    } 
    else {
        url = @"https://www.jianshu.com/u/7fc76f1179cc";
    }

    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:safariVC animated:YES completion:NULL];
}
```

 - Block实现
 
```ObjC
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
```

- 代理实现

```ObjC
// 协议
Protocol: <DYFAssistiveTouchViewDelegate>

// 设置代理 
self.touchView.delegate = self;

// 代理实现
- (void)touchViewItemDidClickedAtIndex:(DYFAssistiveTouchView *)touchView {
    NSInteger index = touchView.indexOfItem;
    NSLog(@"Index of item: %zi", index);
    [self presentAtIndex:index]; 
}
```

## Sample

- [Code Sample Portal](https://github.com/itenfay/DYFAssistiveTouchView/blob/master/Basic%20Files/ViewController.m)
