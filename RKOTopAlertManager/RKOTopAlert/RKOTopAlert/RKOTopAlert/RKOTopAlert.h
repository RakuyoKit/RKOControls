//
//  RKOTopAlert.h
//  RKOTextView
//
//  Created by Rakuyo on 2017/9/3.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKOTopAlert : UIView

/**
 设置提示窗的样式

 @param text 提示窗显示文字，不能为nil。为空则设置无效。
 @param textColor 文字颜色
 @param backgroundColor 提示窗背景颜色
 @param duration 横幅持续显示的时间
 */
+ (void)popAlertViewWithText:(NSString *)text
                   textColor:(UIColor *)textColor
              ackgroundColor:(UIColor *)backgroundColor
                    duration:(CGFloat)duration;

@end
