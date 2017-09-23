//
//  RKOTopAlert.m
//  RKOTextView
//
//  Created by Rakuyo on 2017/9/3.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTopAlert.h"

// 记录高度的结构体。
struct {
    CGFloat statusbarH;
    CGFloat navigationH;
    CGFloat alertViewH;
} topHight;

@interface RKOTopAlert()

// 提示文字。
@property (nonatomic, copy) NSString *text;

// 文字的颜色。
@property (nonatomic, strong) UIColor *textColor;

// 标记视图已经出现
@property (nonatomic, assign) BOOL alertDidAppear;

@end

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
        
        // 添加点击及滑动手势
        [instance addGestureRecognizer];
    });
    
    return instance;
}

// 设置样式并提示窗
+ (void)popAlertViewWithText:(NSString *)text textColor:(UIColor *)textColor ackgroundColor:(UIColor *)backgroundColor duration:(CGFloat)duration {
    
    // 创建单例
    RKOTopAlert *topAlert = [self sharedManager];
    
    // 设置样式
    [topAlert alertViewWithText:text textColor:textColor ackgroundColor:backgroundColor];
    
    // 出现
    [topAlert alertAppearWithDuration:duration];
}

// 设置样式。
- (void)alertViewWithText:(NSString *)text textColor:(UIColor *)textColor ackgroundColor:(UIColor *)backgroundColor {
    
    // 设置背景颜色。
    self.backgroundColor = backgroundColor;
    
    // 设置文字颜色。
    self.textColor = textColor;
    
    // 设置提示内容。
    self.text = text;
}

#pragma mark - Set && Get
- (void)setText:(NSString *)text {
    _text = text;
    
    // 设置显示文字。
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.text = text;
    alertLabel.textColor = _textColor;
    alertLabel.font = [UIFont boldSystemFontOfSize:FONTSIZE];
    alertLabel.backgroundColor = [UIColor clearColor];
    
    // 水平居中
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.frame = CGRectMake(0, topHight.statusbarH, self.frame.size.width, topHight.navigationH);
    
    // 添加视图
    [self addSubview:alertLabel];
}

#pragma mark - Animate
// 出现的动画
- (void)alertAppearWithDuration:(CGFloat)duration {
    
    // 如果已经被添加，则不再出现。
    if (self.superview) {
        return;
    }
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    [keyWindow addSubview:self];
    // 显示到最上层。
    [keyWindow bringSubviewToFront:self];
    
    __block CGRect alertFrame = self.frame;
    [UIView animateWithDuration:ALERT_APPEAR_ANIMATE_DURATION animations:^{
        // 向下移动，显示提示窗。
        alertFrame.origin.y = 0;
        self.frame = alertFrame;
    } completion:^(BOOL finished) { // 显示动画完成
        if (finished) {
            self.alertDidAppear = YES;
            
            // duration秒后横幅自动消失
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 消失。
                [self alertDisappear];
            });
        }
    }];
}

// 消失的动画。
- (void)alertDisappear {
    
    if (!self.alertDidAppear) {
        return;
    }
    
    __block CGRect alertFrame = self.frame;
    //移除横幅动画,设置完全透明并从父视图中移除
    [UIView animateWithDuration:ALERT_DISAPPEAR_ANIMATE_DURATION
                     animations:^{
                         // 向上移动消失。
                         alertFrame.origin.y = -topHight.alertViewH;
                         self.frame = alertFrame;
                     }
                     completion:^(BOOL finished) {
                         
                         if (finished) {
                             UILabel *alertLabel = self.subviews[0];
                             alertLabel.text = nil;
                             alertLabel.textColor = nil;
                             self.backgroundColor = nil;
                             // 从父视图中移除。
                             [self removeFromSuperview];
                             
                             self.alertDidAppear = NO;
                         }
                     }];
}

#pragma mark - GestureRecognizer
// 添加手势
- (void)addGestureRecognizer {
    
    // 点击立刻消失
    UITapGestureRecognizer *tapGestRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertDisappear)];
    
    // 向上滑动消失
    UISwipeGestureRecognizer *swipeGestRec = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(alertDisappear)];
    
    // 向上滑动
    swipeGestRec.direction = UISwipeGestureRecognizerDirectionUp;
    
    // 添加手势。
    [self addGestureRecognizer:tapGestRec];
    [self addGestureRecognizer:swipeGestRec];
}

@end

