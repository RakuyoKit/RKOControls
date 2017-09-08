//
//  RKONetworkAlert.m
//  Summary01_Rakuyo
//
//  Created by Rakuyo on 2017/8/17.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKONetworkAlert.h"

@implementation RKONetworkAlert

// 封装方法所有方法。
+ (void)popAlert {
    [[self sharedManager] displayAlert];
}

// 单例方法。
+ (instancetype)sharedManager {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        RKONetworkAlert *noConnAlertBtn = [self buttonWithType:UIButtonTypeCustom];
        // 设置文字。
        [noConnAlertBtn setTitle:ALTERSTR forState:UIControlStateNormal];
        // 设置文字颜色
        [noConnAlertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // 灰色背景颜色
        noConnAlertBtn.backgroundColor = [UIColor grayColor];
        // 圆角
        noConnAlertBtn.layer.cornerRadius = RADIUS;
        // 初始透明度设为0
        noConnAlertBtn.alpha = 0;
        // 设置大小
        noConnAlertBtn.frame = CGRectMake(0, 0, ALERTW, ALERTH);
        
        instance = noConnAlertBtn;
    });

    return instance;
}

// 添加Alert视图，并弹出视图。
- (void)displayAlert {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    
    // 判断alert是否存在，存在的话则直接跳出。
    if (self.superview && (self.superview == keyWindow)) {
        // 进到if里则说明当前视图已经添加到父视图, 直接返回
        return;
    }
    
    self.center = keyWindow.center;
    
    // 不存在则添加进来。
    [keyWindow addSubview:self];
    
    // 显示到最上层。
    [keyWindow bringSubviewToFront:self];
    
    // 设置动画与消失。
    [UIView animateWithDuration:OVERTIME animations:^{
        // 显示按钮
        self.alpha = ALPHA;
        
    } completion:^(BOOL finished) {
        // 1.2秒后提醒自动消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //移除横幅动画,设置完全透明并从父视图中移除
            [UIView animateWithDuration:OVERTIME
                             animations:^{
                                 // 隐藏横幅。
                                 self.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 // 移除视图。
                                 [self removeFromSuperview];
                             }];
        });
    }];
}

@end
