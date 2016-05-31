//
//  MessageViewController.m
//  MyWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"去首页" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
}

#pragma mark - 触摸手势方法
- (void)rightBarButtonAction:(UIBarButtonItem *)sender
{
    self.tabBarController.selectedIndex = 0;
}

@end
