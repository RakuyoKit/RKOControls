//
//  RKOTextView.m
//  RKOTextView
//
//  Created by Rakuyo on 2017/8/31.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOTextView.h"

// 边框宽度
#define BORDERWIDTH 1

#define PADDING 5.0f

@interface RKOTextView () <UITextViewDelegate>

// 占位文字的Label。
@property (nonatomic, strong) UILabel *placeholderLabel;

// 清除按钮的图片的Frame。
@property (nonatomic) CGSize imgSize;
// TextView的最大高度。
@property (nonatomic, assign) CGFloat maxTextH;

// 达到最大标志的标识符。
@property (nonatomic, assign) BOOL achMaxTextH;

@end

@implementation RKOTextView

#pragma mark - 初始化方法。
// 快捷方法，创建对象并设置属性。
+ (RKOTextView *)textViewWithFrame:(CGRect)frame
                       placeholder:(NSString *)placeholder
                              font:(UIFont *)font
                         maxNumber:(NSInteger)maxNumber
                  maxNumberOfLines:(NSInteger)maxNumberOfLines
                        needBorder:(BOOL)needBorder {
    
    RKOTextView *textView = [[self alloc] initWithFrame:frame];
    
    textView.myPlaceholder = placeholder;
    textView.font = font;
    textView.maxNumber = maxNumber;
    textView.maxNumberOfLines = maxNumberOfLines;
    textView.needBorder = needBorder;
    
    // 预留，请参考头文件。
    textView.isLimitInputRange = NO;
    
    // 设置样式。
    [textView setUp];
    
    return textView;
}

// 当从storyboard/xib中初始化该控件的时候
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    
    // 设置样式
    [self setUp];
    
    return self;
}

- (void)setUp {
    
    // 设置光标位置
    UIEdgeInsets selfEdgeInsets = self.textContainerInset;
    selfEdgeInsets.left = PADDING;
    selfEdgeInsets.right = PADDING;

    self.textContainerInset = selfEdgeInsets;
    
    // 禁止滚动。
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    
    // 设置代理，监听文字输入
    self.delegate = self;
}

#pragma mark - 系统方法
// 绘制TextView边框
- (void)drawRect:(CGRect)rect {
    
    if (self.needBorder) {
        // 绘制边框
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = BORDERWIDTH;
        self.layer.cornerRadius = PADDING;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 对占位符Label进行布局
    if (self.placeholderLabel) {
        [self layoutPlaceholderLabel];
    }
    
    // TextView的高度自适应
    [self fitHight:self];
}

// 监听文字改变
- (void)textViewDidChange:(UITextView *)textView {
    
    // 判断子视图是否显示，以及适配高度
    [self judgmentSubviewsDisplayed:textView];
    
    // 动态计算剩余字符数目
    if (self.maxNumber) {
        [self calculateNumberOfRemainingCharacters:textView];
    }
    
    // 限制输入范围
    if (self.isLimitInputRange && self.maxNumberOfLines) {
        [self limitInputRangeWithTextView:textView];
    }
    
    // 提供代理，供用户监听输入
    if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.textViewDelegate textViewDidChange:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // 限制输入
    if (self.maxNumber) {
        // 当复制过来的时候，这个地方返回的是NO。所以不会自适应高度.....
        return [self limitInputWithTextView:textView range:range replacementText:text];
    }
    
    return YES;
}

#pragma mark - TextView相关
#pragma mark 样式

// 判断子视图是否显示
- (void)judgmentSubviewsDisplayed:(UITextView *)textView {
    
    // 当编辑时隐藏占位符
    self.placeholderLabel.hidden = self.hasText;

    // TextView的高度自适应
    [self fitHight:textView];
}

#pragma mark 高度适配
// 根据内容自适应更改高度。
- (void)fitHight:(UITextView *)textView {
    
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    
    CGFloat textViewH = size.height;
    
    // 如果有设置最大行数，那么检查是否超过了最大高度。
    if (self.maxNumberOfLines) {
        if (textViewH > self.maxTextH) {
            textViewH = self.maxTextH;
            // 如果没有限制输入范围，那么允许滚动。
            if (!self.isLimitInputRange) {
                self.layoutManager.allowsNonContiguousLayout = NO;
                self.scrollEnabled = YES;
            }
        }
    }
    
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, textViewH);
}

// 根据最大的行数设置TextView的最大高度。
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    
    // 计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
    // 多加0.01，防止计算出来的self的高度和maxTextH取整前的高度一致。
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom) + 0.01;
}

#pragma mark 限制输入的范围
// 限制文字数目和输入范围
- (void)limitInputRangeWithTextView:(UITextView *)textView {
    
    // 判断用户是否输入到最大行数。
    if (textView.frame.size.height != self.maxTextH || ![[textView.text substringFromIndex:textView.text.length - 1]  isEqual: @"\n"]) {
        return;
    }
    
    // 等用户已经输入到最大行数的时候，再按回车的时候，取消该回车。并提醒不能输入回车。
    textView.text = [textView.text substringToIndex:textView.text.length - 1];
    
    // 显示提示窗
    if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewPopAlertWhenMaxRange:)]) {
        [self.textViewDelegate textViewPopAlertWhenMaxRange:textView];
    }
    
    //        // 限制输入范围，当输入到最后的时候，无法继续输入
    //        CGFloat inputViewH = self.textContainer.size.height + self.textContainerInset.top + self.textContainerInset.bottom;
    //
    //        if (inputViewH >= self.maxTextH) {
    //            self.text = [self.text substringToIndex:self.text.length - 1];
    //
    //#warning 在这里显示一个从上到下的提示符，然后删除下面的NSLog。
    //            NSLog(@"%@",self.text);NSLog(@"%f",inputViewH);
    //        }
}

#pragma mark 限制输入字符长度
// 计算剩余字符的数目
- (void)calculateNumberOfRemainingCharacters:(UITextView *)textView {
    UITextRange *selectedRange = [textView markedTextRange];
    // 获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    // 如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    // 中文状态下，高亮的拼音部分变成中文的时候。
    if (existTextNum > self.maxNumber) {
        // 截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:self.maxNumber];
        
        [textView setText:s];
        
        // 显示提示窗，提示字数限制
        if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewPopAlertWhenMaxNumber:)]) {
            [self.textViewDelegate textViewPopAlertWhenMaxNumber:textView];
        }
        
    }
    // 不让显示负数 口口日
    // self.lbNums.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}

// 限制输入
- (BOOL)limitInputWithTextView:(UITextView *)textView range:(NSRange)range replacementText:(NSString *)text {
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < self.maxNumber) {
            return YES;
        } else {
            // 显示提示窗，提示字数限制
            if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewPopAlertWhenMaxNumber:)]) {
                [self.textViewDelegate textViewPopAlertWhenMaxNumber:textView];
            }
            return NO;
        }
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = self.maxNumber - comcatstr.length;
    
    if (caninputlen >= 0) {
        return YES;
    } else {
        NSInteger len = text.length + caninputlen;
        // s防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0) {
            
            NSString *s = @"";
            // 判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                // 因为是ascii码直接取就可以了不会错
                s = [text substringWithRange:rg];
            } else {
                
                __block NSInteger idx = 0;
                // 截取出的字串
                __block NSString  *trimString = @"";
                // 使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          NSInteger steplen = substring.length;
                                          if (idx >= rg.length) {
                                              // 取出所需要就break，提高效率
                                              *stop = YES;
                                              // 显示提示窗，提示字数限制
                                              if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewPopAlertWhenMaxNumber:)]) {
                                                  [self.textViewDelegate textViewPopAlertWhenMaxNumber:textView];
                                              }
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          // 这里变化了，使用了字串占的长度来作为步长
                                          idx = idx + steplen;
                                      }];
                
                s = trimString;
            }
            // rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            // 既然是超出部分截取了，哪一定是最大限制了。
            // self.lbNums.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        }
        // 判断子视图是否显示，以及适配高度
        [self judgmentSubviewsDisplayed:textView];
        // 显示提示窗，提示字数限制
        if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewPopAlertWhenMaxNumber:)]) {
            [self.textViewDelegate textViewPopAlertWhenMaxNumber:textView];
        }
        return NO;
    }
}

#pragma mark - 占位符
// 初始化占位符Lable
- (void)createPlaceholderLabel {
    
    // 创建并设置占位符Label
    self.placeholderLabel = [[UILabel alloc] init];
    
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.numberOfLines = 0;
    //设置占位文字默认颜色
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    
    // 添加视图
    [self addSubview:self.placeholderLabel];
    
    // 根据初始状态判断子控件是否显示
    [self judgmentSubviewsDisplayed:self];
}

// 对占位符Label进行布局
- (void)layoutPlaceholderLabel {
    
    CGRect frame = self.placeholderLabel.frame;
    frame.origin.y = self.textContainerInset.top;
    frame.origin.x = self.textContainerInset.left + PADDING * 1.5;
    frame.size.width = self.frame.size.width - self.textContainerInset.left * 2.0;
    
    // 根据文字计算高度
    CGSize maxSize = CGSizeMake(frame.size.width, MAXFLOAT);
    frame.size.height = [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    self.placeholderLabel.frame = frame;
}

// 重写字体的设置方法，保证两个字的大小一样
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    if (self.myPlaceholder || self.myPlaceholder.length == 0) {
        return;
    }
    
    // 如果传nil的话则为系统默认大小。
    if (!font) {
        font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    
    // 修改占位符文字的大小。
    self.placeholderLabel.font = font;
    
    //重新计算子控件frame
    [self setNeedsLayout];
}

// 重写set方法，设置占位符文字
- (void)setMyPlaceholder:(NSString *)myPlaceholder {
    
    _myPlaceholder = [myPlaceholder copy];
    
    // 初始化占位符Lable
    [self createPlaceholderLabel];
    
    //设置文字
    _placeholderLabel.text = myPlaceholder;
    
    //重新计算子控件frame
    [self setNeedsLayout];
}

@end
