//
//  ViewController.m
//  RKOTextView
//
//  Created by Rakuyo on 2017/9/8.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "ViewController.h"
// 导入头文件
#import "RKOTextView.h"

// 遵守协议
@interface ViewController () <RKOTextViewDelegate>

// 连线
@property (weak, nonatomic) IBOutlet RKOTextView *testTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 从storyboard中初始化。
    [self setUpWithStroyBoard];
    
    // 使用代码进行初始化。
    [self setUpWithCode];
    
}

- (void)setUpWithStroyBoard {
    
    // 设置代理
    self.testTextView.textViewDelegate = self;
    
    /**
     *  这里为了演示，虽然使用的是 storyboard 的方式添加的 TextView。
     *  但下面依然使用直接对样式属性赋值的方式，没有使用 IBInspectable 的方式。
     */
    
    // 显示默认边框
    self.testTextView.needBorder = YES;
    
    // 设置占位符文字
    self.testTextView.myPlaceholder = @"storyboard创建...";
    
    // 最大行数
    self.testTextView.maxNumberOfLines = 5;
    
    // 最大字数
    self.testTextView.maxNumber = 100;
    
    // 清除按钮显示时机
    self.testTextView.clearBtnMode = RKOTextFieldViewModeWhileEditing;
    
}

- (void)setUpWithCode {
    
    // 设置大小位置。
    CGRect frame = CGRectMake(100, 300, 200, 200);
    
    // 设置样式
    RKOTextView *textViewWithCode = [RKOTextView textViewWithFrame:frame
                                                       placeholder:@"纯代码创建..."
                                                              font:[UIFont systemFontOfSize:18]
                                                         maxNumber:50
                                                  maxNumberOfLines:4 clearBtnMode:RKOTextFieldViewModeWhileEditing
                                                        needBorder:YES];
    // 添加视图
    [self.view addSubview:textViewWithCode];
}

@end
