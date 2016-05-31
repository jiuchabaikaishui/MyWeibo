//
//  StatusToolBar.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/9.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusToolBar.h"
#import "ConFunc.h"

@interface StatusToolBar ()

@property (strong, nonatomic)NSMutableArray *buttons;
@property (strong, nonatomic)NSMutableArray *lineViews;

@end

@implementation StatusToolBar

#pragma mark - 属性方法
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _buttons;
}
- (NSMutableArray *)lineViews
{
    if (_lineViews == nil) {
        _lineViews = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _lineViews;
}
- (void)setStatus:(Status *)status
{
    if (status) {
        _status = status;
        UIButton *button = self.buttons[0];
        [self settingDataWithButton:button andName:@"转发" andCount:status.reposts_count];
        button = self.buttons[1];
        [self settingDataWithButton:button andName:@"评论" andCount:status.comments_count];
        button = self.buttons[2];
        [self settingDataWithButton:button andName:@"赞" andCount:status.attitudes_count];
    }
}

#pragma mark - 初始化实例化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        //设置背景
        self.image = [ConFunc imageWithName:@"timeline_card_bottom_background_os7"];
        self.highlightedImage = [ConFunc imageWithName:@"timeline_card_bottom_background_highlighted_os7"];
        
        //设置按钮
        [self.buttons addObject:[self settingButtonWithTitle:@"转发" imageName:@"timeline_icon_retweet_os7" bgImageName:@"timeline_card_leftbottom_highlighted_os7"]];
        [self.buttons addObject:[self settingButtonWithTitle:@"评论" imageName:@"timeline_icon_comment_os7" bgImageName:@"timeline_card_middlebottom_highlighted_os7"]];
        [self.buttons addObject:[self settingButtonWithTitle:@"赞" imageName:@"timeline_icon_unlike_os7" bgImageName:@"timeline_card_rightbottom_highlighted_os7"]];
        
        //设置分割线
        [self settingLineViews];
    }
    
    return self;
}

#pragma mark - 自定义方法
- (UIButton *)settingButtonWithTitle:(NSString *)title imageName:(NSString *)image bgImageName:(NSString *)bgName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[ConFunc imageWithName:bgName] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self addSubview:button];
    
    return button;
}
- (void)settingLineViews
{
    for (int index = 0; index < self.buttons.count - 1; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"timeline_card_bottom_line_os7"];
        imageView.highlightedImage = [UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7"];
        [self addSubview:imageView];
        [self.lineViews addObject:imageView];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat LW = 2.0;
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = (self.frame.size.width - LW*self.lineViews.count)/self.buttons.count;
    CGFloat H = self.frame.size.height;
    
    //设置按钮的frame
    for (UIButton *button in self.buttons) {
        NSInteger index = [self.buttons indexOfObject:button];
        X = (W + LW)*index;
        button.frame = CGRectMake(X, Y, W, H);
    }
    
    CGFloat LH = H;
    CGFloat LY = Y;
    CGFloat LX = 0;
    for (UIImageView *imageView in self.lineViews) {
        NSInteger index = [self.lineViews indexOfObject:imageView];
        LX = W + (W + LW)*index;
        imageView.frame = CGRectMake(LX, LY, LW, LH);
    }
}
- (void)settingDataWithButton:(UIButton *)button andName:(NSString *)name andCount:(long long)count
{
    /**
     0 -> @"转发"
     <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
     >= 10000
     * 整万(10100, 20326, 30000 ....) : 1万, 2万
     * 其他(14364) : 1.4万
     */
    NSString *title = nil;
    if (count) {//count 不等于 0
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%lld",count];
        }
        else//count 大于或等于 10000
        {
            double doubleCount = count/10000.0;
            title = [NSString stringWithFormat:@"%.1f万",doubleCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    else
    {
        title = name;
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}

@end
