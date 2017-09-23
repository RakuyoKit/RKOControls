# RKOTextView

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.1-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 简介

一个`UITextView`封装。

该组件设计之初不是为了富文本而设计的，只是为了实现一个简单的输入框。可以限制字数可以适应高度。

项目配套代码提供一个非常简单的使用说明（因时间有限，未来逐步完成），以供参考。

## 功能

本组件提供以下功能，涵盖目前市面上大部分的基本需求：
 1. 兼容`stroyboard、xib`以及纯代码。
 2. 根据内容自适应高度。
 3. 自定义占位符文字。
 4. 可以监听输入。
 5. 可以限制`TextView`显示的最大行数，在达到最大行数后滚动显示。
 6. 可以设置限制最大输入长度，并可以在达到最大字数时设置提醒。
 7. 在右侧提供一个清除按钮，可以设置显示时机，始终对于`TextView`垂直居中。
 8. 设置文字颜色和背景色的方法和原生`UITextView`没有区别。

未来预计实现的功能如下：
1. 限制输入的范围。

- 注意：
    1. 请**确保您设置的宽度足够显示占位文字**，若宽度不足以显示占位文字，占位文字的显示效果会出现问题。
    2. 组件**暂时不支持自定义高度**（位置以及宽度不受限制），初始高度为默认单行的高度。如果您需要自定义组件的高度，那么建议您不要设置组件的边框，并将组件添加到一个自定义宽高的 `View` 上，来达到您的效果。

## 集成

```shell
 pod 'RKOTextView', '~> 1.0.1'
```

## 基本使用

```objc
// 设置大小位置。
CGRect frame = CGRectMake(100, 300, 200, 200);
    
// 设置样式
RKOTextView *textViewWithCode = [RKOTextView textViewWithFrame:frame
                                                   placeholder:@"纯代码创建..."
                                                          font:[UIFont systemFontOfSize:18]
                                                     maxNumber:50
                                              maxNumberOfLines:4
                                                  clearBtnMode:RKOTextFieldViewModeWhileEditing
                                                     needBorder:YES];
// 添加视图
[self.view addSubview:textViewWithCode];
```

## 接口

若您的项目使用**纯代码**方式构建，建议使用下面的方法进行初始化并设置样式。

```objc
/**
/**
 * 快速创建对象并设置其样式。（若您使用纯代码方式，推荐使用该方法。）
 *
 * @param frame 视图宽度及位置
 * @param placeholder 占位符文字
 * @param font 字体（传nil则为系统默认字体）
 * @param maxNumber 最大的限制字数
 * @param maxNumberOfLines 最大的限制行数
 * @param clearBtnMode 清除按钮的样式
 * @param needBorder 是否显示默认边框
 * @return RKOTextView
 */
+ (RKOTextView *)textViewWithFrame:(CGRect)frame
                       placeholder:(nullable NSString *)placeholder
                              font:(nullable UIFont *)font
                    maxNumber:(NSInteger)maxNumber
                  maxNumberOfLines:(NSInteger)maxNumberOfLines
                      clearBtnMode:(RKOTextFieldViewMode)clearBtnMode
                        needBorder:(BOOL)needBorder;
```

- **注意**：组件的初始高度为默认单行的高度，即 `frame` 的高度参数是无效的（位置以及宽度不受限制）

若您的项目使用`StoryBoard`或者`Xib`方式构建`View`，那么我建议您在**属性面板**中使用我们提供的如下属性，直接设置样式：

```objc
/**
 * 使用IBInspectable关键字，方便您在Storyboard中使用该控件时，设置属性。
 *
 * 若您需要设置清除按钮，那么需要在代码中单独设置clearBtnMode属性。
 */

/** 清除按钮的显示时机 */
@property (nonatomic) RKOTextFieldViewMode clearBtnMode;

/** 是否显示默认的边框 */
@property (nonatomic, assign) IBInspectable BOOL needBorder;

/** 占位符文字。 */
@property (nonatomic, copy, nullable) IBInspectable NSString * myPlaceholder;

/** TextView显示的最大行数。 */
@property (nonatomic, assign) IBInspectable NSUInteger maxNumberOfLines;

/** 限定输入的字符数。
 
 注意：该属性优先于最大行数，即在达到最大字数却没有达到最大行数的情况下，无法继续输入。 */
@property (nonatomic, assign) IBInspectable NSInteger maxNumber;
```

其中，清除按钮的**显示时机**参照`UITextField`设计：

```objc
/** 定义ClearButton显示的时机 */
typedef NS_ENUM(NSInteger, RKOTextFieldViewMode) {
    RKOTextFieldViewModeNever = 0,
    RKOTextFieldViewModeWhileEditing,
    RKOTextFieldViewModeUnlessEditing,
    RKOTextFieldViewModeAlways
};
```

如果您需要**监听输入**，或者**在达到字数限制的时候提醒用户**，那您可以根据需要实现`RKOTextViewDelegate`协议中的**可选**方法。

```objc
@protocol RKOTextViewDelegate <NSObject>

@optional
/**
 如果您需要监听输入，请实现该方法。
 */
- (void)textViewDidChange:(UITextView *)textView;

/**
 如果您需要当达到最大字数时弹出提示窗，请将弹出提示窗的代码写在该方法中
 */
- (void)textViewPopAlertWhenMaxNumber:(UITextView *)textView;

@end
```