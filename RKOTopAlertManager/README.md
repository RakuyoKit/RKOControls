# RKOTopAlert

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.3-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 简介

自定义一个顶端的`Alert`提示窗。弹出时从顶端向下移动。（**在iPhone X下可用**）

随仓库配套了一个简单的 **演示Demo**，方便大家使用参考。

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
 pod 'RKOTopAlert', '~> 1.0.3'
```

## 使用

使用下面的方法创建一个`Alert`视图，对`Alert`视图调用 `alertAppearWithDuration` 并设置时候，即可弹出 `Alert`视图。

```objc
RKOTopAlert *topAlert = [RKOTopAlert alertViewWithText:@"提示文字" textColor:[UIColor whiteColor] ackgroundColor:[UIColor redColor]];
    
[topAlert alertAppearWithDuration:2.0];
```

如果您的`App`需要统一多个提示窗的样式，那么推荐您在 `AppDelegate` 中进行设置：

```objc
// 在 AppDelegate.h 中设置属性
@property (nonatomic, strong) RKOTopAlert *topAlert;

// 懒加载属性，创建对象并设置样式。
- (RKOTopAlert *)topAlert {
    return [RKOTopAlert alertViewWithText:@"在AppDelegate中总体设置" textColor:[UIColor blackColor] ackgroundColor:[UIColor orangeColor]];
}

// 在按钮方法或其它方法中，获取属性调用弹出方法。
- (IBAction)popAlert:(id)sender {
    [((AppDelegate *)[UIApplication sharedApplication].delegate).topAlert alertAppearWithDuration:2.0];
}
```

## 接口

本控件提供一个工厂方法，用以创建对象并设置样式：

```objc
/**
 * 设置提示窗的样式，并弹出提示窗。（其对象参数均不可为nil。）
 
 * @param text 提示窗显示文字。
 * @param textColor 文字颜色。
 * @param backgroundColor 提示窗背景颜色。
 * @return 调用对象本身
 */
+ (instancetype)alertViewWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                   ackgroundColor:(UIColor *)backgroundColor;
```

此外，我们分别提供了弹窗弹窗的**弹出**方法与**消失**方法，方便您动态地控制弹窗的弹出与消失：

```objc
/**
 * 弹出提示窗的方法。

 * @param duration 横幅持续显示的时间。如果传0，则需要手动调用alertDisappear方法使视图消失。
 */
- (void)alertAppearWithDuration:(CGFloat)duration;

/**
 * 令顶部提示窗消失的方法。
 */
- (void)alertDisappear;
```
