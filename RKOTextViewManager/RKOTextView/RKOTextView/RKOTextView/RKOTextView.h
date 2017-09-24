//
//  RKOTextView.h
//  RKOTextView
//
//  Created by Rakuyo on 2017/8/31.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RKOTextView;

#pragma mark - 代理。
@protocol RKOTextViewDelegate <NSObject>

@optional
/**
 * 如果您需要监听输入，请实现该方法。
 */
- (void)textViewDidChange:(UITextView *)textView;

/**
 * 如果您需要当达到最大字数时弹出提示窗，请将弹出提示窗的代码写在该方法中
 */
- (void)textViewPopAlertWhenMaxNumber:(UITextView *)textView;


/**
 * 该功能还未完全实现，请不要使用该方法。
 *
 * 如果您需要当达到最大范围时弹出提示窗，请将弹出提示窗的代码写在该方法中
 */
- (void)textViewPopAlertWhenMaxRange:(UITextView *)textView;

@end

/**
 * 自定义UITextView类，适配纯代码及xib、storyboard。
 * 该接口中的全部属性，如果不需要都可以不进行设置。
 
 * 本控件提供以下功能：
 *
 * 1. 兼容stroyboard、xib以及纯代码。
 * 2. 根据内容自适应高度。
 * 3. 自定义占位符文字。
 * 4. 可以监听输入。
 * 5. 可以限制TextView显示的最大行数，在达到最大行数后滚动显示。
 * 6. 可以设置限制最大输入长度，并在达到最大字数时从顶部向下弹出提示窗，可设置提示文字、文字颜色及背景色。（默认和Navigation同高）
 * 7. 设置文字颜色和背景色的方法和原生UITextView没有区别。
 *
 * 还未实现的功能：
 * 1. 一个相对于TextView垂直居中的清除按钮
 * 2. 限制输入的范围
 *
 *  注意：
 * 1. 请确保您设置的宽度足够显示占位文字，若宽度不足以显示占位文字，占位文字的显示效果会出现问题。
 * 2. 组件暂时不支持自定义高度（位置以及宽度不受限制），初始高度为默认单行的高度。
 *    如果您需要自定义组件的高度，那么建议您不要设置组件的边框，并将组件添加到一个自定义宽高的 `View` 上，来达到您的效果。
 */

@interface RKOTextView : UITextView

#pragma mark - 方法。

/**
 * 快速创建对象并设置其样式。（若您使用纯代码方式，推荐使用该方法。）
 *
 * @param frame 视图宽度及位置
 * @param placeholder 占位符文字
 * @param font 字体（传nil则为系统默认字体）
 * @param maxNumber 最大的限制字数
 * @param maxNumberOfLines 最大的限制行数
 * @param needBorder 是否显示默认边框
 * @return RKOTextView
 */
+ (RKOTextView *)textViewWithFrame:(CGRect)frame
                       placeholder:(nullable NSString *)placeholder
                              font:(nullable UIFont *)font
                         maxNumber:(NSInteger)maxNumber
                  maxNumberOfLines:(NSInteger)maxNumberOfLines
                        needBorder:(BOOL)needBorder;

#pragma mark - 属性。
/**
 * 使用IBInspectable关键字，方便您在Storyboard中使用该控件时，设置属性。
 */

/** 是否显示默认的边框 */
@property (nonatomic, assign) IBInspectable BOOL needBorder;

/** 占位符文字。 */
@property (nonatomic, copy, nullable) IBInspectable NSString * myPlaceholder;

/** TextView显示的最大行数。 */
@property (nonatomic, assign) IBInspectable NSUInteger maxNumberOfLines;

/** 限定输入的字符数。
 
 注意：该属性优先于最大行数，即在达到最大字数却没有达到最大行数的情况下，无法继续输入。 */
@property (nonatomic, assign) IBInspectable NSInteger maxNumber;

/** 代理 */
@property (nonatomic, weak) id<RKOTextViewDelegate> textViewDelegate;






#pragma mark - 未完成的功能。

/** 警告：该属性目前尚未完全完成，不建议一般开发者使用。如果你有更好的想法，欢迎通过issus联系我。 */
#warning This property is not currently complete and is not recommended for general use. If you have a better idea, please contact me via issus.
/**
 * 是否限制输入范围。该属性可将输入限制在输入框的可见范围内。
 
 * 注意：需要提前设置设置最大行数。在这种情况下TextView的滚动将被取消。
 */
@property (nonatomic, assign) BOOL isLimitInputRange;

@end

NS_ASSUME_NONNULL_END

