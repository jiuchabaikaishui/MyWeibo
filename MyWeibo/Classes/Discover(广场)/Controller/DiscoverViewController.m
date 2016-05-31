//
//  DiscoverViewController.m
//  MyWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SearchTextField.h"

@interface DiscoverViewController ()<UITextFieldDelegate>

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
}

#pragma mark - 触摸点击手势
- (void)rightItemAction:(UIButton *)sender
{
    if ([self.tabBarItem.title isEqualToString:@"首页"]) {
        self.tabBarItem.title = @"广场";
    }
    else
    {
        self.tabBarItem.title = @"首页";
    }
    
    self.tabBarItem.badgeValue = @"你麻痹";
}

#pragma mark - 控制器周期
- (void)settingUi
{
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 28);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"设置" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
    
    CGRect rect = CGRectMake(SPACING, SPACING, button.frame.origin.x - SPACING*2, MainNavBar_Height - SPACING*2);
    SearchTextField *searchTextField = [SearchTextField searchTextFieldWithFrame:rect];
    searchTextField.enablesReturnKeyAutomatically = NO;
    searchTextField.delegate = self;
    self.navigationItem.titleView = searchTextField;
}

#pragma mark - <UITextFieldDelegate>代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
