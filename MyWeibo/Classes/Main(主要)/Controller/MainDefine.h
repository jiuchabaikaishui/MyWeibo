//
//  MainDefine.h
//  ItcastWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 itcast. All rights reserved.
//

#ifndef MainDefine_h
#define MainDefine_h

/**
 *  公用宏部分
 */
#define IOS7                                ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define IOS8                                ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define QSPClolor(r,g,b)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define MainControllerView_Color            QSPClolor(226, 226, 226)
#define DefaultImage                        [UIImage imageNamed:@"defaultPic"]

#define SPACING     8
#define MainScreen_Bounds                   [UIScreen mainScreen].bounds
#define MainScreen_Width                     MainScreen_Bounds.size.width
#define MainScreen_Height                   MainScreen_Bounds.size.height

#define MainStatusBar_Height                [[UIApplication sharedApplication] statusBarFrame].size.height
#define MainNavBar_Height                   ([self isKindOfClass:[UIViewController class]] ? self.navigationController.navigationBar.frame.size.height : 44)
#define MainStatus_NavBar_Height            (MainStatusBar_Height + MainNavBar_Height)

/**
 *  宏方法
 */
#define MainAlertMsg(msg)                   {NSString *title = @"提示";NSString *buttonTitle = @"确定";if (IOS8) {UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:nil];[alertController addAction:action];[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];}else{UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil, nil];[alertView show];}}

/**
 *  常用对象
 */
#define Notification_DefaultCenter                      [NSNotificationCenter defaultCenter]

/**
 *  账号相关的宏
 */
#define Weibo_AppKey        @"3539443582"
#define Weibo_AppSecret     @"c2451b85dd81313fe30afb71b74692d3"
#define Weibo_Type          @"authorization_code"
#define Weibo_RedirectURL   @"http://ios.itcast.cn"
#define Weibo_LoginURL      [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",Weibo_AppKey,Weibo_RedirectURL]]

/**
 *  微博cell上的宏
 */
#define StatusNameFont [UIFont systemFontOfSize:14]
#define StatusTimeFont [UIFont systemFontOfSize:12]
#define StatusSourceFont StatusTimeFont
#define StatusContextFont [UIFont systemFontOfSize:13]

#endif /* MainDefine_h */
