//
//  RKOTopAlert.m
//  RKOTextView
//
//  Created by Rakuyo on 2017/9/3.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTopAlert.h"
#import <Masonry/Masonry.h>

#define weakify_self __weak typeof(self) weakSelf = self

// 记录高度的结构体。
struct {
    CGFloat statusbarH;
    CGFloat navigationH;
    CGFloat alertViewH;
} topHight;

@interface RKOTopAlert()

@property (nonatomic, strong) UILabel *contentLable;
@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) dispatch_block_t disappearBlock;

@end

@implementation RKOTopAlert

#pragma mark - sharedManager
+ (instancetype)sharedManager {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 初始化提示窗
        instance = [[self alloc] init];
        
        // 添加点击及滑动手势
        [instance addGestureRecognizer];
    });
    
    return instance;
}

// 设置样式并提示窗
+ (instancetype)alertViewWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                  backgroundColor:(UIColor *)backgroundColor
                    iconImageName:(nullable NSString *)iconImageName
                             font:(UIFont *)font {
    
    RKOTopAlert *alert = [self sharedManager];
    
    // 如果已经被添加，则不再出现。
    if (alert.superview) return alert;
    
    // 计算高度
    [alert calculateHeight];
    
    // 设置背景颜色。
    alert.backgroundColor = backgroundColor;
    
    // 设置提示内容。
    alert.contentLable.text = text;
    alert.contentLable.font = font;
    alert.contentLable.textColor = textColor;
    
    // 是否设置了 icon / 文件名包含空格按照未设置 icon 处理
    BOOL hasSpace = ([iconImageName rangeOfString:@" "].location && [iconImageName rangeOfString:@" "].location != NSNotFound);
    BOOL hasIcon = iconImageName && (iconImageName.length > 0 || hasSpace);
    
    // 基础样式
    if (!hasIcon) { return alert; };
    
    
    // 带有 icon 的样式
    UIImage *image = [UIImage imageNamed:iconImageName];
    alert.iconView.image = image;
    
    [alert.contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alert.iconView.mas_right).offset(5);
        make.top.equalTo(alert.mas_top);
        make.bottom.equalTo(alert.mas_bottom);
        make.right.equalTo(alert.mas_right);
    }];
    
    return alert;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    RKOTopAlert *alert = [RKOTopAlert sharedManager];
    
    // 重新计算高度
    [alert calculateHeight];
    
    // 更新约束
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topHight.alertViewH);
    }];
    
    [[UIApplication sharedApplication].delegate.window layoutIfNeeded];
}

#pragma mark - Event
// 出现
- (void)alertAppearWithDuration:(CGFloat)duration {
    
    // 如果已经被添加，则不再出现。
    if (self.superview) return;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    [keyWindow addSubview:self];
    // 显示到最上层。
    [keyWindow bringSubviewToFront:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topHight.alertViewH);
        make.left.equalTo(keyWindow.mas_left);
        make.right.equalTo(keyWindow.mas_right);
        make.top.equalTo(keyWindow.mas_top).offset(-topHight.alertViewH);
    }];
    
    [keyWindow layoutIfNeeded];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keyWindow.mas_top);
    }];
    
    [UIView animateWithDuration:alertAppearAnimateDuration animations:^{
        [keyWindow layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        if (finished && duration != 0) {
            
            // 延时消失。
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), self.disappearBlock);
        }
    }];
}

// 手动消失
+ (void)alertDisappear {
    RKOTopAlert *alert = [self sharedManager];
    
    // 取消自动消失
    // dispatch_block_cancel 会把 block 清空但是不会变为 nil。所以要手动设为nil。
    dispatch_block_cancel(alert.disappearBlock);
    alert.disappearBlock = nil;
    
    // 消失动画
    [alert alertDisappearAutomatically];
}

// 自动消失
- (void)alertDisappearAutomatically {
    if (!self.superview) return;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    
    // 向上移动消失。
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keyWindow.mas_top).offset(-topHight.alertViewH);
    }];
    
    // 移除横幅动画,设置完全透明并从父视图中移除
    [UIView animateWithDuration:alertDisappearAnimateDuration animations:^{
        [keyWindow layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        if (finished) {
            // 从父视图中移除。
            if (self.iconView) {
                [self.iconView removeFromSuperview];
                self.iconView = nil;
            }
            [self.contentLable removeFromSuperview];
            self.contentLable = nil;
            
            [self removeFromSuperview];
        }
    }];
}

// 计算高度
- (void)calculateHeight {
    // 判断是否加入到Navigation中
    UINavigationController *vc;
    if (![[[UIApplication sharedApplication].keyWindow rootViewController] isKindOfClass:[UINavigationController class]]) {
        vc = [[UINavigationController alloc] init];
    } else {
        vc = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    }
    
    // 记录高度
    topHight.navigationH = vc.navigationBar.frame.size.height;
    topHight.statusbarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
    topHight.alertViewH = topHight.navigationH + topHight.statusbarH;
}

#pragma mark - GestureRecognizer
// 添加手势
- (void)addGestureRecognizer {
    
    // 点击立刻消失
    UITapGestureRecognizer *tapGestRec = [[UITapGestureRecognizer alloc] initWithTarget:self.class action:@selector(alertDisappear)];
    
    // 向上滑动消失
    UISwipeGestureRecognizer *swipeGestRec = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(alertDisappear)];
    
    // 向上滑动
    swipeGestRec.direction = UISwipeGestureRecognizerDirectionUp;
    
    // 添加手势。
    [self addGestureRecognizer:tapGestRec];
    [self addGestureRecognizer:swipeGestRec];
}

#pragma mark - Lazy Loading
- (UILabel *)contentLable {
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] init];
        _contentLable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_contentLable];
        
        [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topHight.statusbarH);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return _contentLable;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_iconView];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return _iconView;
}

- (dispatch_block_t)disappearBlock {
    if (!_disappearBlock) {
        _disappearBlock = dispatch_block_create(0, ^{
            [self alertDisappearAutomatically];
        });
    }
    return _disappearBlock;
}

@end
