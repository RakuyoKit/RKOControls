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

/**
 * 弹出提示窗的方法。
 
 * @param duration 横幅持续显示的时间。如果传0，则需要手动调用alertDisappear方法使视图消失。
 */
- (void)alertAppearWithDuration:(CGFloat)duration;

/**
 * 令顶部提示窗消失的方法。
 */
- (void)alertDisappear;

@end

NS_ASSUME_NONNULL_END
