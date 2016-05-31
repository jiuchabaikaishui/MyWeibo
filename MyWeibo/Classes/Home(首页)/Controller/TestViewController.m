//
//  TestViewController.m
//  MyWeibo
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:@"ic_return"] forState:UIControlStateNormal];
//    [button setFrame:CGRectMake(0, 0, 24, 24)];
//    [button addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    
    self.title = [NSString stringWithFormat:@"第%i页",(int)self.navigationController.viewControllers.count];
}

#pragma mark - 点击触摸手势
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    TestViewController *ctr = [[TestViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)backItemAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
