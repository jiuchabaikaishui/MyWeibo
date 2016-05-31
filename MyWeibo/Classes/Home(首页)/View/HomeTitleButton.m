//
//  HomeTitleButton.m
//  MyWeibo
//
//  Created by apple on 16/2/4.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "HomeTitleButton.h"
#import "ConFunc.h"

#define Title_Image_Scale      (2/3.0)

@implementation HomeTitleButton

+ (instancetype)homeTitleButtonWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置高亮时不要自动调整图片
        self.adjustsImageWhenHighlighted = NO;
        //设置字体及颜色
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeLeft;
        //设置背景图片
        [self setBackgroundImage:[ConFunc imageWithName:@"navigationbar_filter_background_highlighted_os7"] forState:UIControlStateHighlighted];
    }
    
    return self;
}

- (void)setFrameWithTitle:(NSString *)title forState:(UIControlState)state
{
    [self setTitle:title forState:state];
    CGRect frame = self.frame;
    frame.size.width = [ConFunc getAutoSize:CGFLOAT_MAX andStr:title andFont:self.titleLabel.font].width + frame.size.height + SPACING;
    self.frame = frame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat H = self.frame.size.height;
    CGFloat W = self.frame.size.width > self.frame.size.height ? self.frame.size.width - self.frame.size.height : (self.frame.size.width - SPACING) * Title_Image_Scale;
    
    return CGRectMake(X, Y, W, H);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat X = self.frame.size.width > self.frame.size.height ? self.frame.size.width - self.frame.size.height + SPACING : (self.frame.size.width - SPACING) * (1.0 - Title_Image_Scale) + SPACING;
    CGFloat Y = 0;
    CGFloat H = self.frame.size.height;
    CGFloat W = self.frame.size.width > self.frame.size.height ? self.frame.size.height : (self.frame.size.width - SPACING) * (1.0 - Title_Image_Scale);
    
    return CGRectMake(X, Y, W, H);
}

@end
