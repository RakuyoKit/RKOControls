# RKOTopAlert

自定义一个顶端的`Alert`提示窗。

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.0-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 简介

自定义一个顶端的`Alert`提示窗。弹出时从顶端向下移动。


可以设置**提示文字**、**文字颜色**、**背景颜色**。

**高度**为`Status` + `NavigationBar`的高度。（不论您的`ViewController`是否添加到`NavigationController`中）

注意：该控件有以下几点**未进行测试**：
1. 编写时考虑到了自定义`NavigationBar`，但因为时间原因未进行测试。
2. 自定义`NavigationBar`，但自定义`NavigationBar`隐藏时的效果。
3. 原生`NavigationBar`隐藏时的情况。
3. 隐藏`Status`时的效果。

如果在您的项目中用到了以上几点未测试的功能，请将您的结果告诉我，帮助我完善该控件。

## 集成

```shell
 pod 'RKOTopAlert', '~> 1.0.0'
```

## 使用

在需要弹出该提示窗的地方调用下面的方法

```objc
[RKOTopAlert popAlertViewWithText:@"提醒文字" textColor:[UIColor redColor] ackgroundColor:[UIColor blackColor];
```

## 接口

该提示窗提供一个方法用于设置样式并弹出提示窗。

```objc
/**
 设置提示窗的样式

 @param text 提示窗显示文字，不能为nil。为空则设置无效。
 @param textColor 文字颜色
 @param backgroundColor 提示窗背景颜色
 @param duration 横幅持续显示的时间
 */
+ (void)popAlertViewWithText:(NSString *)text
                   textColor:(UIColor *)textColor
              ackgroundColor:(UIColor *)backgroundColor
                    duration:(CGFloat)duration;
```

