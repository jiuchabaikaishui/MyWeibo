//
//  LoadingClass.h
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface LoadingClass : NSObject
+ (MBProgressHUD *)show;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
+ (void)showSuccess:(BOOL)success andView:(UIView *)view;

+ (void)showMessageOnly:(NSString *)message;
+ (void)showSuccess;
+ (void)showFailure;

@end
