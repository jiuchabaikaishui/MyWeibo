//
//  MeViewController.m
//  MyWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "MeViewController.h"
#import "UIBarButtonItem+QSP.h"
#import "SettingItem.h"
#import "SettingViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
    [self settingGroups];
}

#pragma mark - 控制器周期
- (void)settingUi
{
    self.view.backgroundColor = MainControllerView_Color;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemAction:)];
    [self.navigationItem setRightBarButtonItem:item];
}

#pragma mark - 触摸点击手势
- (void)rightItemAction:(UIButton *)sender
{
//    self.tabBarController.selectedIndex = 0;
//    self.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_os7"];
    
    SettingViewController *next = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - 自定义方法
- (void)settingGroups
{
    //配置数据
    NSArray *dataArr = @[
                            @{
                                @"items":
                               @[
                                   @{@"type":@(SettingItemTypeArrow),@"icon":@"new_friend",@"title":@"新的好友100000000000000000000000",@"subTitle":@"100000000000000000000000",@"badgeValue":@"",@"rightStr":@""}
                                ],
                                @"header":@"",
                                @"fooder":@""
                             },
                            @{
                                @"items":
                                    @[
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"album",@"title":@"我的相册",@"subTitle":@"109",@"badgeValue":@"",@"rightStr":@""},
                                        @{@"type":@(SettingItemTypeLabel),@"icon":@"collect",@"title":@"我的收藏",@"subTitle":@"100000000000000000000000",@"badgeValue":@"",@"rightStr":@"你好100000000000000000000000"},
                                        @{@"type":@(SettingItemTypeBadgeValue),@"icon":@"like",@"title":@"赞",@"subTitle":@"35",@"badgeValue":@"100000000000000000000000",@"rightStr":@""}
                                      ],
                                @"header":@"",
                                @"fooder":@""
                                },
                            @{
                                @"items":
                                    @[
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"album",@"title":@"我的相册",@"subTitle":@"109",@"badgeValue":@"",@"rightStr":@""},
                                        @{@"type":@(SettingItemTypeLabel),@"icon":@"collect",@"title":@"我的收藏",@"subTitle":@"100000000000000000000000",@"badgeValue":@"",@"rightStr":@"你好100000000000000000000000"},
                                        @{@"type":@(SettingItemTypeBadgeValue),@"icon":@"like",@"title":@"赞",@"subTitle":@"35",@"badgeValue":@"100000000000000000000000",@"rightStr":@""}
                                        ],
                                @"header":@"",
                                @"fooder":@""
                                },
                            @{
                                @"items":
                                    @[
                                        @{@"type":@(SettingItemTypeSwitch),@"icon":@"pay",@"title":@"微博支付",@"subTitle":@"100000000000000000000000",@"badgeValue":@"",@"rightStr":@""},
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"vip",@"title":@"会员中心",@"subTitle":@"0",@"badgeValue":@"",@"rightStr":@""},
                                        @{@"type":@(SettingItemTypeSwitch),@"icon":@"pay",@"title":@"微博支付",@"subTitle":@"100000000000000000000000",@"badgeValue":@"",@"rightStr":@""},
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"vip",@"title":@"会员中心",@"subTitle":@"0",@"badgeValue":@"",@"rightStr":@""}
                                      ],
                                @"header":@"",
                                @"fooder":@""
                                },
                            @{
                                @"items":
                                    @[
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"card",@"title":@"我的名片",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""},
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"draft",@"title":@"草稿箱",@"subTitle":@"0",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                                @"header":@"",
                                @"fooder":@""
                              },
                            @{
                                @"items":
                                    @[
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"card",@"title":@"我的名片",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""},
                                        @{@"type":@(SettingItemTypeArrow),@"icon":@"draft",@"title":@"草稿箱",@"subTitle":@"0",@"badgeValue":@"",@"rightStr":@""}
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
