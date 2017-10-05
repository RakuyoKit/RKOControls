# RKOTextView

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.1.0-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 简介

一个`UITextView`封装。

该组件设计之初不是为了富文本而设计的，只是为了实现一个简单的输入框。可以限制字数可以适应高度。

仓库配套一个简单的使用参考 `Demo`，以供参考。

## 功能

本组件提供以下功能，涵盖目前市面上大部分的基本需求：
 1. 兼容 `stroyboard`、`xib` 以及纯代码。
 2. 根据内容自适应高度。
 3. 自定义占位符文字。字体及大小等同于输入文字。
 4. 可以限制 `TextView` 显示的最大行数，在达到最大行数后滚动显示，或不可输入。
 5. 可以设置可输入的最大字数。
 6. 提供代理方法，可以在达到最大行数/字数时进行您的自定义操作。
 7. 其他设置与原生`UITextView`没有区别。

预计未来可能会实现的功能：
1. 一个相对于 `TextView` 垂直居中的**清除按钮**
2. 自定义高度。

- 注意：
    1. 请**确保您设置的宽度足够显示占位文字**，若宽度不足以显示占位文字，占位文字的显示效果会出现问题。
    2. 因为高度是根据内容自适应的，所以组件**暂时不支持自定义高度**（位置以及宽度不受限制），初始高度为默认单行的高度。
    3. 很遗憾我们在`1.0.4`版本中，暂时**移除了清除按钮**。在位置的设定上出了点问题，所以只能暂时先移除了。
    4. **预计未来可能会实现的功能**中的2个功能，如果反馈需要这两个功能的人比较多的话，后期会考虑添加上，现阶段暂时是不会添加的了。

## 集成

```shell
 pod 'RKOTextView', '~> 1.1.0'
```

## 基本使用

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

## 接口

若您的项目使用**纯代码**方式构建，建议使用下面的方法进行初始化并设置样式。

```objc
/**
 * 快速创建对象并设置其样式。（若您使用纯代码方式，推荐使用该方法。）
 *
 * @param frame 视图大小及位置（若您需要自适应视图的高度，请在高度处填 0 ）
 * @param placeholder 占位符文字
 * @param font 字体（ nil 则为系统默认字体及大小）
 * @param limitInputRange 是否限制输入范围 （优先级最高）
 * @param maxCharacters 可输入的最大字数 （优先级其次）
 * @param maxRows 可输入的最大行数 （优先级最低）
 * @return RKOTextView
 */
+ (RKOTextView *)textViewWithFrame:(CGRect)frame
                       placeholder:(nullable NSString *)placeholder
                              font:(nullable UIFont *)font
                   limitInputRange:(BOOL)limitInputRange
                     maxCharacters:(NSUInteger)maxCharacters
                           maxRows:(NSUInteger)maxRows;
```

- **注意**：组件的初始高度为默认单行的高度，即 `frame` 的高度参数是无效的（位置以及宽度不受限制）

若您的项目使用`StoryBoard`或者`Xib`方式构建`View`，那么我建议您在**属性面板**中使用我们提供的如下属性，直接设置样式：

```objc
/** 占位符文字。 */
@property (nonatomic, copy, nullable) IBInspectable NSString * placeholder;

/** 开启该属性后，在达到最大行数时将无法进行输入。（优先级于最大字符数，但要同时设置最大行数） */
@property (nonatomic, assign) IBInspectable BOOL limitInputRange;

/** 可输入的最大字符数（优先于最大行数）。 */
@property (nonatomic, assign) IBInspectable NSUInteger maxCharacters;

/** TextView 显示的最大行数。 */
@property (nonatomic, assign) IBInspectable NSUInteger maxRows;

/** 是否显示本控件提供的边框 */
@property (nonatomic, assign) IBInspectable BOOL needBorder;
```

如果您需要在达到 **最大字数** 或 **最大行数** 后进行操作的话，可以实现下面两个 `RKOTextViewDelegate` 协议方法：

```objc
/** 当达到 最大行数 时的代理方法。 */
- (void)textViewDidAchieveMaxRows:(UITextView *)textView;

/** 当达到 最大字数 时的代理方法。 */
- (void)textViewDidAchieveMaxCharacters:(UITextView *)textView;
```