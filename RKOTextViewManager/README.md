# RKOTextView

一个`UITextView`封装

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v1.0.0-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/rakuyoMo/RKOTools/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

## 简介

提供以下功能，几乎涵盖目前市面上的基本需求：
 1. 兼容`stroyboard/xib`以及纯代码。
 2. 根据内容自适应高度。
 3. 自定义占位符文字。
 4. 可以监听输入。
 5. 可以限制`TextView`显示的最大行数，在达到最大行数后滚动显示。
 6. 可以设置限制最大输入长度，并可以在达到最大字数时设置提醒。
 7. 在右侧提供一个清除按钮，可以设置显示时机，始终对于`TextView`垂直居中。
 8. 设置文字颜色和背景色的方法和原生`UITextView`没有区别。

未来预计实现的功能如下：
1. 限制输入的范围。

## 集成

```shell
 pod 'RKOTextView', '~> 1.0.0'
```

## 基本使用

```objc
[self.textView textViewStyleWithplaceholder:@"请输入待办内容..." maxLimitNumber:40 maxNumberOfLines:3 clearBtnMode:RKOTextFieldViewModeWhileEditing];
```

## 接口

**提供如下几个便利的构造方法，以及样式设置方法**

```objc
/**
 提供以下几个便捷方法，快速创建对象并设置其样式。
 
 @param frame 视图大小及位置
 @param placeholder 占位符文字
 @param maxLimitNumber 最大的限制字数
 @param maxNumberOfLines 最大的限制行数
 @param clearBtnMode 清除按钮的样式
 @return RKOTextView
 */
+ (RKOTextView *)textViewWithFrame:(CGRect)frame placeholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber maxNumberOfLines:(NSInteger)maxNumberOfLines clearBtnMode:(RKOTextFieldViewMode)clearBtnMode;
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber;
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber clearBtnMode:(RKOTextFieldViewMode)clearBtnMode;

- (void)textViewStyleWithplaceholder:(NSString *)placeholder maxLimitNumber:(NSInteger)maxLimitNumber maxNumberOfLines:(NSInteger)maxNumberOfLines clearBtnMode:(RKOTextFieldViewMode)clearBtnMode;
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

除此之外，我们还暴露一些属性，方便单独设置：

```objc
/** 占位符文字。 */
@property(nonatomic,copy) NSString *myPlaceholder;

/** 限定输入的字符数。
 
 注意：该属性优先于最大行数，即在达到最大字数却没有达到最大行数的情况下，无法继续输入。 */
@property (nonatomic, assign) NSInteger maxLimitNums;

/** TextView显示的最大行数。 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/** 清除按钮的显示时机 */
@property (nonatomic) RKOTextFieldViewMode clearBtnMode;
```

清除按钮的**显示时机**参照`UITextField`设计：

```objc
/** 定义ClearButton显示的时机 */
typedef NS_ENUM(NSInteger, RKOTextFieldViewMode) {
    RKOTextFieldViewModeNever = 0,
    RKOTextFieldViewModeWhileEditing,
    RKOTextFieldViewModeUnlessEditing,
    RKOTextFieldViewModeAlways
};
```

