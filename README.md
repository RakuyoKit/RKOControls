# RKOControls
自己的一个控件库。每一个单独的控件都支持`CocoaPods`。

## 目录

1. [RKOControl](#rkocontrol)
    1. [RKONetworkAlert](#rkonetworkalert)
    2. [RKOTextView](#rkotextview) 
    3. [RKOTopAlert](#rkotopalert)
2. [RKOTools](#rkotools)
3. [BLOG](#blog)

---------------------------------------------------------------------

## RKOControl

### RKONetworkAlert

<p align="left">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.0-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

详情说明见地址：[RKONetworkAlert](https://github.com/rakuyoMo/RKOControls/tree/master/RKONetworkAlertManager)

#### 集成：

```shell
 pod 'RKONetworkAlert', '~> 1.0.0'
```

#### 使用：

```objc
+ (void)popAlert;
```

---------------------------------------------------------------------

### RKOTextView

<p align="left">
<a href=""><img src="https://img.shields.io/badge/pod-v1.1.0-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

详情说明见地址：[RKOTextView](https://github.com/rakuyoMo/RKOControls/tree/master/RKOTextViewManager)

#### 集成：

```shell
 pod 'RKOTextView', '~> 1.1.0'
```

#### 基本使用：

```objc
// 设置大小位置。
CGRect frame = CGRectMake(15, 250, 340, 100);
    
// 设置样式。
RKOTextView *textViewWithCode = [RKOTextView textViewWithFrame:frame
                                                   placeholder:@"纯代码创建..."
                                                          font:[UIFont systemFontOfSize:18]
                                               limitInputRange:YES
                                                 maxCharacters:50
                                                       maxRows:3];
    
// 需要边框，默认不显示。
textViewWithCode.needBorder = YES;
    
// 添加视图
[self.view addSubview:textViewWithCode];
```

---------------------------------------------------------------------

### RKOTopAlert

<p align="left">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.4-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

详情说明见地址：[RKOTopAlert](https://github.com/rakuyoMo/RKOControls/tree/master/RKOTopAlertManager)

#### 集成：

```shell
 pod 'RKOTopAlert', '~> 1.0.4'
```

#### 使用：

```objc
RKOTopAlert *topAlert = [RKOTopAlert alertViewWithText:@"提示文字" textColor:[UIColor whiteColor] backgroundColor:[UIColor redColor] iconImageName:nil];

[topAlert alertAppearWithDuration:2.0];
```

---------------------------------------------------------------------

## RKOTools

这里安利一下我写的另外一个工具库。原本该控件库和工具库是一个库，后来觉得冗余所以将控件库单独提出来了。

<p align="left">
<a href=""><img src="https://img.shields.io/badge/pod-v1.4.2-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%208.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

地址：[RKOTools](https://github.com/rakuyoMo/RKOTools)

### 集成：

```shell
 pod 'RKOTools', '~> 1.4.2'
```

---------------------------------------------------------------------

## BLOG

本人课余时间利用`HEXO`在GitHub上搭建的博客。未来部分工具会有对应的blog文章对应。在这里也把blog的地址贴出来吧：<br><br>
<a href="https://rakuyomo.github.io" target="_blank">喵喵喵</a>
