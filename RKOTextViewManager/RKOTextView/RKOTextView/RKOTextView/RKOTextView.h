//
//  RKOTextView.h
//  RKOTextView
//
//  Created by Rakuyo on 2017/8/31.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RKOTextView;

/**
 自定义UITextView类，适配纯代码及xib、storyboard。
 该接口中的全部属性，如果不需要都可以不进行设置。
 
 本控件提供以下功能：
 
 1. 根据内容自适应高度。
 2. 自定义占位符文字。
 3. 可以限制TextView显示的最大行数，在达到最大行数后滚动显示。
 4. 可以设置限制最大输入长度，并在达到最大字数时从顶部向下弹出提示窗，可设置提示文字、文字颜色及背景色。（默认和Navigation同高）
 5. 在右侧提供一个清除按钮，可以设置显示时机，始终对于TextView垂直居中。
 
 还未实现的功能：
 1. 限制输入的范围
 */

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


/**
 该功能还未完全实现，请不要使用该方法。
 
 如果您需要当达到最大范围时弹出提示窗，请将弹出提示窗的代码写在该方法中
 */
- (void)textViewPopAlertWhenMaxRange:(UITextView *)textView;

@end

@interface RKOTextView : UITextView

/** 定义ClearButton显示的时机 */
typedef NS_ENUM(NSInteger, RKOTextFieldViewMode) {
    RKOTextFieldViewModeNever = 0,
    RKOTextFieldViewModeWhileEditing,
    RKOTextFieldViewModeUnlessEditing,
    RKOTextFieldViewModeAlways
};

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

/** 提供以下几个样式属性，便于在使用storyboard/xib时设置控件样式 */

/** 占位符文字。 */
@property(nonatomic,copy) NSString *myPlaceholder;

/** 限定输入的字符数。
 
 注意：该属性优先于最大行数，即在达到最大字数却没有达到最大行数的情况下，无法继续输入。 */
@property (nonatomic, assign) NSInteger maxLimitNums;

/** TextView显示的最大行数。 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/** 清除按钮的显示时机 */
@property (nonatomic) RKOTextFieldViewMode clearBtnMode;

/** 代理 */
@property (nonatomic, weak) id<RKOTextViewDelegate> textViewDelegate;


/** 警告：该属性目前尚未完全完成，不建议一般开发者使用。如果你有更好的想法，欢迎通过issus联系我。 */
#warning This property is not currently complete and is not recommended for general use. If you have a better idea, please contact me via issus.
/**
 是否限制输入范围。该属性可将输入限制在输入框的可见范围内。
 
 注意：需要提前设置设置最大行数。在这种情况下TextView的滚动将被取消。
 */
@property (nonatomic, assign) BOOL isLimitInputRange;

@end
