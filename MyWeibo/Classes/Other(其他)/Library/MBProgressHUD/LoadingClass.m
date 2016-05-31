//
//  LoadingClass.m
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "LoadingClass.h"

#define Delay_Time  1.5
static LoadingClass *shareInstance;

@interface LoadingClass ()

@property (weak, nonatomic) MBProgressHUD *progressHud;
@property (assign,nonatomic) NSInteger count;

@end

@implementation LoadingClass

+ (LoadingClass *)shareLoadingClass
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:zone];
    });
    
    return shareInstance;
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)show
{
    return [self showMessage:@"正在加载中…"];
}
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    return [[self shareLoadingClass] showMessage:message toView:view];
}
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (!self.count) {
        UIView *theView;
        if (view) {
            theView = view;
        }
        else
        {
            theView = [[UIApplication sharedApplication].windows lastObject];
        }
        self.progressHud = [MBProgressHUD showHUDAddedTo:theView animated:YES];
    }
    self.progressHud.label.text = message;
    self.count++;
    
    return self.progressHud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self shareLoadingClass].count--;
    if (![self shareLoadingClass].count) {
        [[self shareLoadingClass].progressHud hideAnimated:YES];
    }
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)showSuccess
{
    [self showSuccess:YES andView:nil];
}
+ (void)showFailure
{
    [self showSuccess:NO andView:nil];
}
+ (void)showSuccess:(BOOL)success andView:(UIView *)view
{
    if (![self shareLoadingClass].count) {
        [self shareLoadingClass].count++;
        if (!view) {
            view = [[UIApplication sharedApplication].windows lastObject];
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        NSString *imageName = success ? @"CheckmarkS" : @"CheckmarkF";
        UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.square = YES;
        hud.label.text = success ? @"成功！" : @"失败！";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(Delay_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [self shareLoadingClass].count--;
        });
    }
}

+ (void)showMessageOnly:(NSString *)message
{
    if (![self shareLoadingClass].count) {
        [self shareLoadingClass].count++;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
        //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(Delay_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [self shareLoadingClass].count--;
        });
    }
}

@end
