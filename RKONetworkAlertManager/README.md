# RKONetworkAlert

无网络时提醒的一个`Alert`小控件。

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.0-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 集成

```shell
 pod 'RKONetworkAlert', '~> 1.0.0'
```

## 使用

仅需下面一个方法，便可弹出`Alert`弹窗：

```objc
/**
 弹出提示弹窗。
 */
+ (void)popAlert;
```

方法内部采用`UIButton`实现，并使用**单例模式**设计。

## 接口

接口部分非常简单，提供7个**宏定义**，用以修改`Alert`的尺寸以及持续时间。

```objc
// Alert尺寸对应的宏。

#define ALTERSTR    @"无网络连接"    // 显示的文字
#define ALPHA       0.95           // 透明度
#define ALERTW      150            // 宽度
#define ALERTH      60             // 高度
#define RADIUS      5              // 圆角
#define DURATION    2              // 持续时间
#define OVERTIME    0.5f           // 过度时间
```
