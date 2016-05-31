//
//  SettingItem.m
//  MyWeibo
//
//  Created by     -MINI on 16/4/12.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "SettingItem.h"
#import "Confunc.h"

@implementation SettingItem

/**
 *  获得一个右边带箭头的Item模型
 *
 *  @param icon        图标
 *  @param title       标题
 *  @param subTitle    子标题
 *  @param destVcClass 目标控制器
 *
 *  @return 右边带箭头的Item模型
 */
+ (instancetype)settingItemArrowWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    return [self settingItemWithType:SettingItemTypeArrow icon:icon title:title subTitle:subTitle badgeValue:nil rightStr:(NSString *)nil destVcClass:destVcClass option:nil];
}
/**
 *  获得一个右边带开关的Item模型
 *
 *  @param icon     图标
 *  @param title    标题
 *  @param subTitle 子标题
 *  @param option   点击后的操作
 *
 *  @return 右边带开关的Item模型
 */
+ (instancetype)settingItemSwitchWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option
{
    return [self settingItemWithType:SettingItemTypeSwitch icon:icon title:title subTitle:subTitle badgeValue:nil rightStr:(NSString *)nil destVcClass:nil option:option];
}
/**
 *  获得一个右边带标签的Item模型
 *
 *  @param rightStr 右边标签的文字
 *  @param icon     图标
 *  @param title    标题
 *  @param subTitle 子标题
 *  @param option   点击后的操作
 *
 *  @return 右边带标签的Item模型
 */
+ (instancetype)settingItemLabelWithRightStr:(NSString *)rightStr icon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option
{
    return [self settingItemWithType:SettingItemTypeLabel icon:icon title:title subTitle:subTitle badgeValue:nil rightStr:(NSString *)rightStr destVcClass:nil option:option];
}
/**
 *  获得一个右边带提醒文字的Item模型
 *
 *  @param badgeValue 提醒文字
 *  @param icon       图标
 *  @param title      标题
 *  @param subTitle   子标题
 *  @param option     点击后的操作
 *
 *  @return 右边带提醒文字的Item模型
 */
+ (instancetype)settingItemBadgeValueWithBadgeValue:(NSString *)badgeValue icon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option
{
    return [self settingItemWithType:SettingItemTypeBadgeValue icon:icon title:title subTitle:subTitle badgeValue:badgeValue rightStr:(NSString *)nil destVcClass:nil option:option];
}
/**
 *  获得一个右边什么都没有的Item模型
 *
 *  @param icon     图标
 *  @param title    标题
 *  @param subTitle 子标题
 *  @param option   点击后的操作
 *
 *  @return 右边什么都没有的Item模型
 */
+ (instancetype)settingItemNilWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option
{
    return [self settingItemWithType:SettingItemTypeNil icon:icon title:title subTitle:subTitle badgeValue:nil rightStr:(NSString *)nil destVcClass:nil option:option];
}
/**
 *  获得一个Item模型
 *
 *  @param dic Item的数据字典
 *
 *  @return Item模型
 */
+ (instancetype)settingItemArrowWithDic:(NSDictionary *)dic
{
    return [self settingItemWithType:(SettingItemType)[dic[@"type"] integerValue] icon:dic[@"icon"] title:dic[@"title"] subTitle:dic[@"subTitle"] badgeValue:dic[@"badgeValue"] rightStr:dic[@"rightStr"] destVcClass:dic[@"destVcClass"] option:dic[@"option"]];
}
/**
 *  获得一个Item模型
 *
 *  @param type        模型的类型
 *  @param icon        图标
 *  @param title       标题
 *  @param subTitle    子标题
 *  @param badgeValue  提醒文字
 *  @param rightStr    右边标签的文字
 *  @param destVcClass 目标控制器
 *  @param option      点击后的操作
 *
 *  @return Item模型
 */
+ (instancetype)settingItemWithType:(SettingItemType)type icon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle badgeValue:(NSString *)badgeValue rightStr:(NSString *)rightStr destVcClass:(Class)destVcClass option:(void (^)())option
{
    SettingItem *item = [[SettingItem alloc] init];
    item.type = type;
    if (![ConFunc isBlankString:icon]) {
        item.icon = [icon copy];
    }
    if (![ConFunc isBlankString:title]) {
        item.title = [title copy];
    }
    if (![ConFunc isBlankString:subTitle]) {
        item.subTitle = [subTitle copy];
    }
    if (![ConFunc isBlankString:badgeValue]) {
        item.badgeValue = [badgeValue copy];
    }
    if (![ConFunc isBlankString:rightStr]) {
        item.rightStr = [rightStr copy];
    }
    if (destVcClass) {
        item.destVcClass = destVcClass;
    }
    if (option) {
        item.option = option;
    }
    
    return item;
}

@end
