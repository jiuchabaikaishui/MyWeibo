//
//  AppDelegate.m
//  MyWeibo
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "NewFeatureViewController.h"
#import "OAuthViewController.h"
#import "Account.h"
#import "MainTool.h"
#import "AccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    Account *account = [AccountTool achieveAccount];
    
    if (account) {
        //选择根控制器
        [MainTool chooseRootViewController];
    }
    else
    {
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    
    /**
     *  iOS8以上程序必须注册通知不然不能在程序的图标右上角显示消息数
     */
    {
//        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//            UIUserNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//            UIUserNotificationSettings *mySetting = [UIUserNotificationSettings settingsForTypes:myType categories:nil];
//            [[UIApplication sharedApplication] registerUserNotificationSettings:mySetting];
//        }else{
//            UIRemoteNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myType];
//        }
    }
    
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        [application registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 在后台开启任务让程序持续保持运行状态（能保持运行的时间是不确定）
    [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 *  内存警告时调用
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    QSPLog(@"%s",__FUNCTION__);
    
    //停止图片下载
    [[SDWebImageManager sharedManager] cancelAll];
    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
