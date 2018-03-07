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
    
    // 在 Storyboard 中使用时，采用脱的形式设置样式。
//    [self setUpWithStroyBoard];
    
    // 使用代码进行创建。
    [self setUpWithCode];
}

- (void)setUpWithStroyBoard {
    
    /**
     * 在 Storyboard 中设置的样式，等效于下面的代码。
     */
    
    // 设置代理
    self.testTextView.rko_textViewDelegate = self;
    
    // 显示默认边框
    self.testTextView.needBorder = YES;
    
    // 设置占位符文字
    self.testTextView.placeholder = @"storyboard创建...";

    // 是否限制输入范围
    self.testTextView.limitInputRange = YES;
    
    // 最大行数
    self.testTextView.maxRows = 3;
    
    // 最大字符数
    self.testTextView.maxCharacters = 50;
}

- (void)setUpWithCode {
    
    // 设置大小位置。
    CGRect frame = CGRectMake(15, 250, 340, 100);
    
    // 设置样式。
    RKOTextView *textViewWithCode = [RKOTextView textViewWithFrame:frame
                                                       placeholder:@"纯代码创建..."
                                                              font:[UIFont systemFontOfSize:18]
                                                   limitInputRange:YES
                                                     maxCharacters:50
                                                           maxRows:3];
    
    // 需要边框，默认不显示。
    textViewWithCode.needBorder = YES;
    
    // 添加视图
    [self.view addSubview:textViewWithCode];
}

#pragma mark - RKOTextViewDelegate
- (void)textViewDidAchieveMaxRows:(UITextView *)textView {
    
    NSLog(@"达到最大输入范围");
}

- (void)textViewDidAchieveMaxCharacters:(UITextView *)textView {
    
    NSLog(@"达到最大字数限制");
}

@end
