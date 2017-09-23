# RKOTopAlert

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.2-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 简介

自定义一个顶端的`Alert`提示窗。弹出时从顶端向下移动。（**在iPhone X下可用**）

可以设置**提示文字**、**文字颜色**、**背景颜色**。

**高度**为`Status` + `NavigationBar`的高度。（不论您的`ViewController`是否添加到`NavigationController`中）

- 注意：该控件有以下几点**未进行测试**：
    1. 编写时考虑到了自定义`NavigationBar`，但因为时间原因未进行测试。
    2. 自定义`NavigationBar`，但自定义`NavigationBar`隐藏时的效果。
    3. 原生`NavigationBar`隐藏时的情况。
    4. 隐藏`Status`时的效果。

如果在您的项目中用到了以上几点未测试的功能，请将您的结果告诉我，帮助我完善该控件。

## 已知问题

该控件还**未做自动布局**，故在横屏下会出现问题。

## 集成

```shell
 pod 'RKOTopAlert', '~> 1.0.2'
```

## 使用

在需要弹出该提示窗的地方调用下面的方法：

```objc
[RKOTopAlert popAlertViewWithText:@"提醒文字" textColor:[UIColor whiteColor] ackgroundColor:[UIColor redColor];
```

如果您的`App`需要统一多个提示窗的样式，那么推荐您使用下面的方法：

```objc
// 创建单例并设置样式。
RKOTopAlert *topAlert = [[self sharedManager] alertViewWithText:@"提醒文字" textColor:[UIColor whiteColor] ackgroundColor:[UIColor redColor]];
    
// 出现
[topAlert alertAppearWithDuration:0.3f];
```

## 接口

该提示窗提供一个方法用于设置样式并弹出提示窗。

```objc
/**
 * 设置提示窗的样式，并弹出提示窗。（其对象参数均不可为nil。）

 * @param text 提示窗显示文字。
 * @param textColor 文字颜色。
 * @param backgroundColor 提示窗背景颜色。
 * @param duration 横幅持续显示的时间。
 */
+ (void)popAlertViewWithText:(NSString *)text
                   textColor:(UIColor *)textColor
              ackgroundColor:(UIColor *)backgroundColor
                    duration:(CGFloat)duration;
```

此外，考虑到您可以需要统一的设置多个弹窗，我们提供如下的方法进行设置：

```objc
/**
 * 单例方法，创建对象。

 * @return 提示窗Alert。
 */
+ (RKOTopAlert *)sharedManager;

/**
 * 设置样式。（其对象参数均不可为nil。）

 * @param text 提示窗显示文字。
 * @param textColor 文字颜色。
 * @param backgroundColor 提示窗背景颜色。
 */
- (void)alertViewWithText:(NSString *)text
                textColor:(UIColor *)textColor
           ackgroundColor:(UIColor *)backgroundColor;
```

此外，我们分别提供了弹窗弹窗的**弹出**方法与**消失**方法，方便您在他处动态地控制弹窗的弹出与消失：

```objc
/**
 * 弹出提示窗的方法。

 * @param duration 横幅持续显示的时间。
 */
- (void)alertAppearWithDuration:(CGFloat)duration;

/**
 * 令顶部提示窗消失的方法。
 */
- (void)alertDisappear;
```
