//
//  MainNavigationViewController.m
//  MyWeibo
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "MainNavigationViewController.h"

#define ios7  ([[UIDevice currentDevice].systemVersion floatValue] > 7.0)

@interface MainNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic)UIViewController *currentShowVC;
@property (assign, nonatomic)BOOL canSlidingBack;

@end

@implementation MainNavigationViewController

#pragma mark - 控制器周期
/**
 *  第一次使用这个类的时候会调用（一个类只使用一次）
 */
+ (void)initialize
{
    //1.设置导航栏主题
    [self setNavigationBarTheme];
    
    //2.设置导航栏按钮主题
    [self setNavigationBarItemTheme];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isSlidingBack = YES;
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    self.delegate = self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (!self.canSlidingBack) {
        return self.canSlidingBack;
    }
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return self.currentShowVC == self.topViewController;
    }
    
    return YES;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count == 1) {
        self.currentShowVC = nil;
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    else
    {
        self.currentShowVC = viewController;
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    
    self.canSlidingBack = self.isSlidingBack;
}

#pragma mark - 触摸手势方法
- (void)backItemAction:(UIButton *)sender
{
    [self popViewControllerAnimated:YES];
}

#pragma - mark 自定义方法
+ (void)setNavigationBarTheme
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    if (!ios7) {
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [navigationBar setTitleTextAttributes:dic];
    
    navigationBar.tintColor = [UIColor orangeColor];
}

+ (void)setNavigationBarItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置背景
    if (!ios7) {
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    // 设置文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor grayColor];
    disableTextAttrs[NSShadowAttributeName] = nil;
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:ios7 ? 18 : 12];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ios7 ? [UIColor orangeColor] : [UIColor grayColor];
    textAttrs[NSShadowAttributeName] = nil;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:ios7 ? 18 : 12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

@end
