//
//  UIBarButtonItem+QSP.m
//  MyWeibo
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "UIBarButtonItem+QSP.h"

@implementation UIBarButtonItem (QSP)

+ (UIBarButtonItem *)getBarButtonItem:(NSString *)title imageName:(NSString *)imageName highImageName:(NSString *)highImageName taget:(id)taget andAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero,button.currentImage.size};
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
