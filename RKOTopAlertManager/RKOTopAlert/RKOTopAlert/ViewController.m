//
//  ViewController.m
//  RKOTopAlert
//
//  Created by Rakuyo on 2017/9/8.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "RKOTopAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)popAlert:(id)sender {
    [((AppDelegate *)[UIApplication sharedApplication].delegate).topAlert alertAppearWithDuration:2.0];
}

- (IBAction)popAlertTwo:(id)sender {
    
    RKOTopAlert *topAlert = [RKOTopAlert alertViewWithText:@"单独设置提示文字" textColor:[UIColor whiteColor] backgroundColor:[UIColor redColor] iconImageName:nil];
    
    [topAlert alertAppearWithDuration:2.0];
}

- (IBAction)popAlertWithIcon:(id)sender {
    
    RKOTopAlert *topAlert = [RKOTopAlert alertViewWithText:@"带图片的样式" textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] iconImageName:RKOControlsSrcName(@"clear_btn_RKOTextView.png")?:RKOControlsFrameworkSrcName(@"clear_btn_RKOTextView.png")];
    
    [topAlert alertAppearWithDuration:2.0];
}



@end
