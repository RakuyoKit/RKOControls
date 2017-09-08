//
//  RKOTopAlert.m
//  RKOTextView
//
//  Created by Rakuyo on 2017/9/3.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTopAlert.h"

struct {
    CGFloat statusbarH;
    CGFloat navigationH;
    CGFloat alertViewH;
} topHight;

@implementation RKOTopAlert

#pragma mark - sharedManager
+ (RKOTopAlert *)sharedManager {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 判断是否加入到Navigation中
        UINavigationController *vc;
        if (![[[UIApplication sharedApplication].keyWindow rootViewController] isKindOfClass:[UINavigationController class]]) {
            vc = [[UINavigationController alloc] init];
        } else {
            vc = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];
        }
        
        // Navigation的高度
        topHight.navigationH = vc.navigationBar.frame.size.height;
        
        // 状态栏的高度
        topHight.statusbarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        topHight.alertViewH = topHight.navigationH + topHight.statusbarH;
        
        // 初始化提示窗，并设置Frame
        instance = [[self alloc] initWithFrame:CGRectMake(0, -topHight.alertViewH, vc.navigationBar.frame.size.width, topHight.alertViewH)];
    });
    
    return instance;
}

// 弹出提示窗
+ (void)popAlertViewWithText:(NSString *)text textColor:(UIColor *)textColor ackgroundColor:(UIColor *)backgroundColor duration:(CGFloat)duration{
    
    // 判断alert是否存在，及是否设置了提示文字
    if (!text || [self sharedManager].superview ) {
        return;
    }
    
    // 创建单例
    RKOTopAlert *topAlert = [self sharedManager];
    
    // 设置背景颜色。
    topAlert.backgroundColor = backgroundColor;
    
    // 设置显示文字。
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.text = text;
    alertLabel.textColor = textColor;
    alertLabel.font = [UIFont boldSystemFontOfSize:20];
    alertLabel.backgroundColor = [UIColor clearColor];
    
    // 水平居中
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.frame = CGRectMake(0, topHight.statusbarH, topAlert.frame.size.width, topHight.navigationH);
    
    // 添加视图
    [topAlert addSubview:alertLabel];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    [keyWindow addSubview:topAlert];
    // 显示到最上层。
    [keyWindow bringSubviewToFront:topAlert];
    
    __block CGRect alertFrame = topAlert.frame;
    [UIView animateWithDuration:0.4f animations:^{
        // 向下移动，显示提示窗。
        alertFrame.origin.y = 0;
        topAlert.frame = alertFrame;
    } completion:^(BOOL finished) { // 显示动画完成
        
        // duration秒后横幅自动消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //移除横幅动画,设置完全透明并从父视图中移除
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 // 向上移动消失。
                                 alertFrame.origin.y = -topHight.alertViewH;
                                 topAlert.frame = alertFrame;
                             }
                             completion:^(BOOL finished) {
                                 
                                 if (finished) {
                                     alertLabel.text = nil;
                                     alertLabel.textColor = nil;
                                     topAlert.backgroundColor = nil;
                                     // 从父视图中移除。
                                     [topAlert removeFromSuperview];
                                 }
                             }];
        });
    }];
}

@end
