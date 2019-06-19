## DYFAssistiveTouchView

 实现应用内悬浮按钮和辅助工具条，可以增加/修改功能项，通过事件索引，实现各种场景页面的跳转。

## 安装

 支持通过 CocoaPods 安装。
```pod
 pod 'DYFAssistiveTouchView', '~> 4.2.2'
```

## 技术交流群(群号:155353383) 

欢迎加入技术交流群，一起探讨技术问题。<br>
![群号:155353383](https://github.com/dgynfi/DYFAssistiveTouchView/raw/master/images/qq155353383.jpg)

## 使用说明

1. 实例化
```ObjC
- (DYFAssistiveTouchView *)touchView {
    if (!_touchView) {
        _touchView = [[DYFAssistiveTouchView alloc] init];
        _touchView.frame = CGRectMake(0, 0, 50, 50);
    }
    return _touchView;
}
```

2. 设置属性
```ObjC
// 设置按钮的各种状态的图像
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

// 设置组件对象
UIImage  *leftUint1Image = [UIImage imageNamed:@"atv_unit1_left"];
UIImage *rightUint1Image = [UIImage imageNamed:@"atv_unit1_right"];
UIImage  *leftUint2Image = [UIImage imageNamed:@"atv_unit2_left"];
UIImage *rightUint2Image = [UIImage imageNamed:@"atv_unit2_right"];

self.touchView.unitObject.leftTouchImage           = leftUint1Image;
self.touchView.unitObject.rightTouchImage          = rightUint1Image;
self.touchView.unitObject.leftItemBackgroundImage  = leftUint2Image;
self.touchView.unitObject.rightItemBackgroundImage = rightUint2Image;

// 设置item对象
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
 
 8.1. block实现
```ObjC
__weak typeof(self) weakSelf = self;
[self.touchView touchViewItemDidClickedAtIndex:^(DYFAssistiveTouchView *touchView) {
    NSInteger index = touchView.indexOfItem;
    NSLog(@"Index of item: %zi", index);
    [weakSelf presentAtIndex:index];
}];
}
```

```ObjC
- (void)presentAtIndex:(NSInteger)index {
    NSString *url = @"https://support.apple.com/zh-cn";
    if (index == 0) {
        url = @"https://github.com/dgynfi";
    } else if (index == 1) {
        url = @"https://github.com/dgynfi/OpenSource";
    } else {
        url = @"https://www.jianshu.com/u/7fc76f1179cc";
    }

    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:safariVC animated:YES completion:NULL];
}
```

8.2. 代理实现
```ObjC
Protocol: <DYFAssistiveTouchViewDelegate>

Set delegagte: self.touchView.delegate = self;

// 代理实现
- (void)touchViewItemDidClickedAtIndex:(DYFAssistiveTouchView *)touchView {
    NSInteger index = touchView.indexOfItem;
    NSLog(@"Index of item: %zi", index);
    [self presentAtIndex:index]; 
}
```
