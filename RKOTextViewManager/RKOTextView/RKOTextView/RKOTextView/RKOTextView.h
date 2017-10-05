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
@protocol RKOTextViewDelegate <NSObject, UITextViewDelegate>
@optional

/** 当达到 最大行数 时的代理方法。 */
- (void)textViewDidAchieveMaxRows:(UITextView *)textView;

/** 当达到 最大字数 时的代理方法。 */
- (void)textViewDidAchieveMaxCharacters:(UITextView *)textView;

@end

/**
 * 自定义 UITextView ，适配纯代码及 xib、storyboard。
 
 * 本控件额外提供以下功能：
 *
 * 1. 兼容 stroyboard、xib 以及纯代码。
 * 2. 根据内容自适应高度。
 * 3. 自定义占位符文字。字体及大小等同于输入文字。
 * 4. 可以限制 TextView 显示的最大行数，在达到最大行数后滚动显示，或不可输入。
 * 5. 可以设置可输入的最大字数。
 * 6. 提供代理方法，可以在达到最大行数/字数时进行您的自定义操作。
 
 * 预计未来可能会实现的功能：
 * 1. 一个相对于 TextView 垂直居中的清除按钮。
 */

@interface RKOTextView : UITextView

#pragma mark - 方法。

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

#pragma mark - 属性。

/** 代理 */
@property (nonatomic, weak) id<RKOTextViewDelegate> textViewDelegate;

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

@end

NS_ASSUME_NONNULL_END

