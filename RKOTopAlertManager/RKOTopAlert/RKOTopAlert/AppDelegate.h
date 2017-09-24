//
//  AppDelegate.h
//  RKOTopAlert
//
//  Created by Rakuyo on 2017/9/8.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKOTopAlert;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 顶部的提示视图
@property (nonatomic, strong) RKOTopAlert *topAlert;

@end

