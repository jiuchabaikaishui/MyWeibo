//
//  MainTool.m
//  MyWeibo
//
//  Created by     -MINI on 16/2/24.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "MainTool.h"
#import "MainTabBarViewController.h"
#import "NewFeatureViewController.h"

@implementation MainTool

+ (void)chooseRootViewController
{
    //取出沙盒存储的版本号
    NSString *versionName = @"BundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *verssion = [defaults objectForKey:versionName];
    //取出软件当前版本号
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if ([verssion isEqualToString:currentVersion]) {
        //显示状态栏和主界面
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBarViewController alloc] init];
    }
    else
    {
        //隐藏状态栏，显示新特性界面
        [UIApplication sharedApplication].statusBarHidden = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NewFeatureViewController alloc] init];
        
        //存储新版本
        [defaults setObject:currentVersion forKey:versionName];
        [defaults synchronize];
    }
}

@end
