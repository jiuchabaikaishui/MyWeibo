//
//  MainBadgeButton.m
//  MyWeibo
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "MainBadgeButton.h"

@implementation MainBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[self resizableImage:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    
    return self;
}
- (void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue && [badgeValue intValue]) {
        _badgeValue = [badgeValue copy];
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGSize imageSize = self.currentBackgroundImage.size;
        
        //计算文字的宽度以下两种方法任选一种
        //CGFloat strW = [badgeValue sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
        CGFloat strW = [badgeValue boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size.width;
        
        CGFloat H = imageSize.height;
        CGFloat spacing = 10;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
        CGFloat W = strW > imageSize.width - spacing ? strW + spacing : imageSize.width;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, W, H);
    }
    else
    {
        self.hidden = YES;
    }
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//}

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
- (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    
    //以下两种方法任选一种。
    //return [normal stretchableImageWithLeftCapWidth:w topCapHeight:h];
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

@end
