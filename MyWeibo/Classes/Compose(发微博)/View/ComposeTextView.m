//
//  ComposeTextView.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/14.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "ComposeTextView.h"
#import "ConFunc.h"

@interface ComposeTextView ()

@property (weak, nonatomic)UILabel *label;

@end

@implementation ComposeTextView

#pragma mark - 属性方法
- (void)setPlaceholder:(NSString *)placeholder
{
    if (![ConFunc isBlankString:placeholder]) {
        _placeholder = [placeholder copy];
        self.label.text = placeholder;
    }
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (placeholderColor) {
        _placeholderColor = placeholderColor;
        self.label.textColor = placeholderColor;
    }
}
- (void)setFont:(UIFont *)font
{
    if (font) {
        [super setFont:font];
        self.label.font = font;
    }
}

#pragma mark - 系统方法
- (void)dealloc
{
    [Notification_DefaultCenter removeObserver:self];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.font = self.font;
        label.textColor = [UIColor lightGrayColor];
        label.numberOfLines = 0;
        [self insertSubview:label atIndex:0];
        self.label = label;
        
        [Notification_DefaultCenter addObserver:self selector:@selector(selfTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentInset = UIEdgeInsetsZero;
    
    if (![ConFunc isBlankString:self.placeholder]) {
        CGFloat SW = self.frame.size.width;
        CGFloat SH = self.frame.size.height;
        CGFloat spacing = SPACING;
        CGFloat X = spacing;
        CGFloat Y = spacing;
        CGFloat W = SW;
        CGFloat TH = [ConFunc getAutoSize:W andStr:self.placeholder andFont:self.font].height;
        CGFloat H = TH > SH - 2*Y ? SH - 2*Y : TH;
        self.label.frame = CGRectMake(X, Y, W, H);
    }
}

#pragma mark - 自定义方法
- (void)selfTextDidChange:(NSNotification *)notification
{
    self.label.hidden = ![ConFunc isBlankString:self.text];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
