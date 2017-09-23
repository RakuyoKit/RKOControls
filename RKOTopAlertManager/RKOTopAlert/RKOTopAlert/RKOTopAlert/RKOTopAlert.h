//
//  RKOTopAlert.h
//  RKOTextView
//
//  Created by Rakuyo on 2017/9/3.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

// 弹出动画的持续时间。
#define ALERT_APPEAR_ANIMATE_DURATION 0.4f
// 消失动画的持续时间。
#define ALERT_DISAPPEAR_ANIMATE_DURATION 0.3f
// 提示文字的字体大小。
#define FONTSIZE 20

NS_ASSUME_NONNULL_BEGIN

@interface RKOTopAlert : UIView

#pragma mark - 分别设置每个弹窗样式。
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

#pragma mark - 统一设置App所有弹窗样式
/**
 * 单例方法，创建对象。
 
 * @return 提示窗Alert。
 */
+ (RKOTopAlert *)sharedManager;

/**
 设置样式。（其对象参数均不可为nil。）
 
 @param text 提示窗显示文字。
 @param textColor 文字颜色。
 @param backgroundColor 提示窗背景颜色。
 */
- (void)alertViewWithText:(NSString *)text
                textColor:(UIColor *)textColor
           ackgroundColor:(UIColor *)backgroundColor;

/**
 * 弹出提示窗的方法。
 
 * @param duration 横幅持续显示的时间。
 */
- (void)alertAppearWithDuration:(CGFloat)duration;

/**
 * 令顶部提示窗消失的方法。
 */
- (void)alertDisappear;

@end

NS_ASSUME_NONNULL_END

