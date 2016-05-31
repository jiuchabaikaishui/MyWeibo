//
//  GeneralViewController.m
//  MyWeibo
//
//  Created by apple on 16/4/17.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "GeneralViewController.h"
#import "SettingItem.h"
#import "LoadingClass.h"

@interface GeneralViewController ()

@end

@implementation GeneralViewController

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
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"阅读模式",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""},
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"字号大小",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""},
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"显示备注",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             },
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"图片质量设置",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             },
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"声音",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             },
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"多语言环境",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""},
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"关于微博",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
                                     ],
                             @"header":@"",
                             @"fooder":@""
                             },
                         @{
                             @"items":
                                 @[
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"清除图片缓存",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@"",@"option":^{
                                         [LoadingClass show];
                                         
                                         NSFileManager *manager = [NSFileManager defaultManager];
                                         NSString *pathStr = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                         [manager removeItemAtPath:pathStr error:nil];
                                         
                                         [LoadingClass hideHUD];
                                     }},
                                     @{@"type":@(SettingItemTypeArrow),@"icon":@"",@"title":@"清空搜索历史",@"subTitle":@"",@"badgeValue":@"",@"rightStr":@""}
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
