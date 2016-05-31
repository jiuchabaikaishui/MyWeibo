//
//  SettingViewController.m
//  MyWeibo
//
//  Created by apple on 16/4/17.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingItem.h"
#import "GeneralViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self settingUi];
    [self settingGroups];
}

#pragma mark - 触摸点击手势
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    
}

#pragma mark - 自定义方法
- (void)settingUi
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
}
- (void)settingGroups
{
    //配置数据
    NSArray *dataArr = @[
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"帐号管理",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             },
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"主题、背景",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             },
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"通知和提醒",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""},
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"通用设置",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@"",@"destVcClass":[GeneralViewController class]},
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"隐私与安全",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             },
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"意见反馈",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""},
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"关于微博",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             }
                         ];
    QSPLog(@"%@",dataArr);
    
    //创建数据模型
    for (NSDictionary *groupDic in dataArr) {
        NSMutableArray *groupItems = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary *dic in groupDic[@"items"]) {
            SettingItem *item = [SettingItem settingItemArrowWithDic:dic];
            [groupItems addObject:item];
        }
        [self addGroup:[SettingGroup settingGroupWithItems:groupItems header:groupDic[@"header"] fooder:groupDic[@"fooder"]]];
    }
}

@end
