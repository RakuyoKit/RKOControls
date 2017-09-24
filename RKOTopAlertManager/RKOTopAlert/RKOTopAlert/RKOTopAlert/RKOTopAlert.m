//
//  RKOTopAlert.m
//  RKOTextView
//
//  Created by Rakuyo on 2017/9/3.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTopAlert.h"

#define weakify_self __weak typeof(self) weakSelf = self

// 记录高度的结构体。
struct {
    CGFloat statusbarH;
    CGFloat navigationH;
    CGFloat alertViewH;
} topHight;

@interface RKOTopAlert()

// 提示内容的Label
@property (nonatomic, strong) UILabel *contentLable;

// 标记视图将要消失
@property (nonatomic, assign) BOOL alertWillDisappear;

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
        instance = [[self alloc] initWithFrame:CGRectMake(0, -topHight.alertViewH, [UIScreen mainScreen].bounds.size.width, topHight.alertViewH)];
        
        // 添加点击及滑动手势
        [instance addGestureRecognizer];
    });
    
    return instance;
}

// 设置样式并提示窗
+ (instancetype)alertViewWithText:(NSString *)text textColor:(UIColor *)textColor ackgroundColor:(UIColor *)backgroundColor {
    
    // 创建对象并设置样式。
    return [[self sharedManager] alertViewWithText:text textColor:textColor ackgroundColor:backgroundColor];
}

// 设置样式。
- (instancetype)alertViewWithText:(NSString *)text textColor:(UIColor *)textColor ackgroundColor:(UIColor *)backgroundColor {
    
    // 如果已经被添加，则不再出现。
    if (self.superview) {
        return self;
    }
    
    // 设置背景颜色。
    self.backgroundColor = backgroundColor;
    
    // 初始化按钮
    self.contentLable = [[UILabel alloc] initWithFrame:CGRectMake(0, topHight.statusbarH, self.frame.size.width, topHight.navigationH)];
    
    // 设置提示内容。
    self.contentLable.text = text;
    // 设置文字颜色。
    self.contentLable.textColor = textColor;
    // 设置字体字号
    self.contentLable.font = [UIFont boldSystemFontOfSize:FONTSIZE];
    // 设置背景颜色
    self.contentLable.backgroundColor = [UIColor clearColor];
    
    // 水平居中
    self.contentLable.textAlignment = NSTextAlignmentCenter;
    
    return self;
}

#pragma mark - Animate
// 出现的动画
- (void)alertAppearWithDuration:(CGFloat)duration {
    
    // 如果已经被添加，则不再出现。
    if (self.superview) {
        return;
    }
    
    // 添加视图
    [self addSubview:self.contentLable];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    [keyWindow addSubview:self];
    // 显示到最上层。
    [keyWindow bringSubviewToFront:self];
    
    __block CGRect alertFrame = self.frame;
    weakify_self;
    [UIView animateWithDuration:ALERT_APPEAR_ANIMATE_DURATION animations:^{
        // 向下移动，显示提示窗。
        alertFrame.origin.y = 0;
        weakSelf.frame = alertFrame;
    } completion:^(BOOL finished) { // 显示动画完成
        if (finished && duration != 0) {
            
            // duration秒后横幅自动消失
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 消失。
                [weakSelf alertDisappear];
                self.alertWillDisappear = NO;
            });
        }
    }];
}

// 消失的动画。
- (void)alertDisappear {
    
    if (self.alertWillDisappear) {
        self.alertWillDisappear = NO;
        return;
    }
    
    __block CGRect alertFrame = self.frame;
    weakify_self;
    //移除横幅动画,设置完全透明并从父视图中移除
    [UIView animateWithDuration:ALERT_DISAPPEAR_ANIMATE_DURATION
                     animations:^{
                         
                         weakSelf.alertWillDisappear = YES;
                         
                         // 向上移动消失。
                         alertFrame.origin.y = -topHight.alertViewH;
                         weakSelf.frame = alertFrame;
                     }
                     completion:^(BOOL finished) {
                         
                         if (finished) {
                             // 从父视图中移除。
                             [weakSelf.contentLable removeFromSuperview];
                             [weakSelf removeFromSuperview];
                             
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
