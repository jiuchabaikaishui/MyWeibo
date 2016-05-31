//
//  MainTabBarButton.m
//  MyWeibo
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "MainTabBarButton.h"
#import "MainBadgeButton.h"

#define Image_Proportion         0.6

@interface MainTabBarButton ()

@property (weak,nonatomic) MainBadgeButton *badgeButton;

@end

@implementation MainTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        //添加提醒按钮
        MainBadgeButton *button = [MainBadgeButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        self.badgeButton = button;
    }
    
    return self;
}
- (void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue) {
        _badgeValue = badgeValue;
        self.badgeButton.badgeValue = badgeValue;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.badgeButton.frame;
    rect.origin.y = self.frame.size.height/8;
    CGFloat SW = self.frame.size.width;
    CGFloat proportion = 1/12.0;
    CGFloat BW = rect.size.width > SW*(0.5 - proportion) ? SW*(0.5 - proportion) : self.badgeButton.frame.size.width;
    rect.size.width = BW;
    rect.origin.x = SW*(1 - proportion) - BW;
    self.badgeButton.frame = rect;//CGRectMake(0, 0, 50, 20);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*Image_Proportion + 4);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height*Image_Proportion, contentRect.size.width, contentRect.size.height*(1 - Image_Proportion));
}
- (void)setHighlighted:(BOOL)highlighted
{
    
}


@end
