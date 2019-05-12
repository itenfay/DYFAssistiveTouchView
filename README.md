# DYFAssistiveTouch
 实现应用内悬浮按钮和辅助工具条，可以动态增加功能项，etc.

# 安装
 支持通过 CocoaPods 安装。
```pod
 pod 'DYFAssistiveTouch', '~> 4.2.0'
```

# 使用说明
 1.实例化
```ObjC
_touchView = [[DYFAssistiveTouchView alloc] init];
_touchView.frame = CGRectMake(0, 0, 50, 50);
```

 2.设置属性
```ObjC
_touchView.imageObject.leftNormalImage = leftNormalImage;
_touchView.imageObject.rightNormalImage = rightNormalImage;
_touchView.imageObject.leftHighlightedImage = leftHighlightedImage;
_touchView.imageObject.rightHighlightedImage = rightHighlightedImage;
_touchView.imageObject.leftTranslucentImage = leftHideImage;
_touchView.imageObject.rightTranslucentImage = rightHideImage;


_touchView.unitImageObject.leftTouchImage = leftUint1Image;
_touchView.unitImageObject.rightTouchImage = rightUint1Image;
_touchView.unitImageObject.leftItemBackgroundImage = leftUint2Image;
_touchView.unitImageObject.rightItemBackgroundImage = rightUint2Image;

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
```

 3.是否显示
```ObjC
[_touchView isShowing]
```

 4.显示
```ObjC
[_touchView show];
```

 5.隐藏
```ObjC
[_touchView hide];
```

 6.隐藏一半至屏幕
```ObjC
[_touchView setShouldShowHalf:YES];
```

 7.设置初始显示位置
```ObjC
[_touchView setTouchViewPlace:DYFTouchViewAtMiddleRight];
```

 8.响应事件(二选一)

  8.1.block实现
```ObjC
[_touchView touchViewItemDidClickedAtIndex:^(DYFAssistiveTouchView *touchView) {
    NSLog(@"index: %ld", (long)touchView.indexOfItem);
}];
```
  8.2.代理实现
```ObjC
Protocol: <DYFAssistiveTouchViewDelegate>

Set delegagte: _touchView.delegate = self;

- (void)touchViewItemDidClickedAtIndex:(DYFAssistiveTouchView *)touchView {
    NSLog(@"index: %zi", touchView.indexOfItem);
}
```

 9.QQ群交流

  QQ群号：155353383

  ![QQ群号：155353383](https://github.com/dgynfi/DYFAssistiveTouch/raw/master/images/qq155353383.jpg)


