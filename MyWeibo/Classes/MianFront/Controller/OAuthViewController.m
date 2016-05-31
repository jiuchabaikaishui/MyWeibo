//
//  OAuthViewController.m
//  MyWeibo
//
//  Created by apple on 16/2/22.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "OAuthViewController.h"
#import "UserFunction.h"
#import "Account.h"
#import "MainTabBarViewController.h"
#import "NewFeatureViewController.h"
#import "MainTool.h"
#import "AccountTool.h"
#import "LoadingClass.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:Weibo_LoginURL]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [LoadingClass hideHUD];
}

#pragma mark - 自定义方法
- (void)accessTokenWithCode:(NSString *)code
{
    [UserFunction accessTokenWithCode:code successfulBlock:^(Account *account) {
        //存储账号数据
        [AccountTool savaAccount:account];
        
        //选择根控制器
        [MainTool chooseRootViewController];
    } failureBlock:^(NSError *error) {
        QSPLog(@"失败：%@",error);
    }];
}

#pragma mark - <UIWebViewDelegate>代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = request.URL.absoluteString;
    QSPLog(@"%@",urlString);
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length) {
        int loction = (int)(range.location + range.length);
        NSString *code = [urlString substringFromIndex:loction];
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [LoadingClass showMessage:@"正在加载中…"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [LoadingClass hideHUD];
}

@end
