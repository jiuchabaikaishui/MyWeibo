//
//  SettingGroup.m
//  MyWeibo
//
//  Created by apple on 16/4/11.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "SettingGroup.h"

@implementation SettingGroup

/**
 *  获得一个SettingGroup实例
 *
 *  @param items  实例中表示行的数据模型
 *  @param header 组的头部文字
 *  @param fooder 组的尾部文字
 *
 *  @return SettingGroup实例
 */
+ (instancetype)settingGroupWithItems:(NSArray *)items header:(NSString *)header fooder:(NSString *)fooder
{
    SettingGroup *group = [[self alloc] init];
    group.items = items;
    group.header = header;
    group.fooder = fooder;
    return group;
}

@end
