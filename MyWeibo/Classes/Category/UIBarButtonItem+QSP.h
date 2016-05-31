//
//  UIBarButtonItem+QSP.h
//  MyWeibo
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (QSP)

+ (UIBarButtonItem *)getBarButtonItem:(NSString *)title imageName:(NSString *)imageName highImageName:(NSString *)highImageName taget:(id)taget andAction:(SEL)action;

@end
