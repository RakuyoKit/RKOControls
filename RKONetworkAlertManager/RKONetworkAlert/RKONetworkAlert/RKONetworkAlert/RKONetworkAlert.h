//
//  RKONetworkAlert.h
//  Summary01_Rakuyo
//
//  Created by Rakuyo on 2017/8/17.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

// Alert尺寸对应的宏。

#define ALTERSTR    @"无网络连接"    // 显示的文字
#define ALPHA       0.95           // 透明度
#define ALERTW      150            // 宽度
#define ALERTH      60             // 高度
#define RADIUS      5              // 圆角
#define DURATION    2              // 持续时间
#define OVERTIME    0.5f           // 过度时间

@interface RKONetworkAlert : UIButton

/**
 弹出提示弹窗。
 */
+ (void)popAlert;

@end
