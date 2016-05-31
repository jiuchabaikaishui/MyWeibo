//
//  SettingItem.h
//  MyWeibo
//
//  Created by     -MINI on 16/4/12.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SettingItemType) {
    SettingItemTypeArrow = 0,//右边带箭头（默认）
    SettingItemTypeSwitch = 1,//右边带开关
    SettingItemTypeLabel = 2,//右边带标签
    SettingItemTypeBadgeValue = 3,//右边带消息提示
    SettingItemTypeNil = 4//右边什么也没有
};
@interface SettingItem : NSObject

/**
 *  右边按钮的类型
 */
@property (assign, nonatomic) SettingItemType type;
/**
 *  图标
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  子标题
 */
@property (copy, nonatomic) NSString *subTitle;
/**
 *  数字
 */
@property (copy, nonatomic) NSString *badgeValue;
/**
 *  右边的标签文字
 */
@property (copy, nonatomic) NSString *rightStr;
/**
 *  目标控制器
 */
@property (assign, nonatomic) Class destVcClass;

/**
 *  点击所做的操作
 */
@property (copy, nonatomic) void (^option)();

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
+ (instancetype)settingItemArrowWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass;
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
+ (instancetype)settingItemSwitchWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option;
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
+ (instancetype)settingItemLabelWithRightStr:(NSString *)rightStr icon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option;
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
+ (instancetype)settingItemBadgeValueWithBadgeValue:(NSString *)badgeValue icon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option;
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
+ (instancetype)settingItemNilWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle option:(void (^)())option;
/**
 *  获得一个Item模型
 *
 *  @param dic Item的数据字典
 *
 *  @return Item模型
 */
+ (instancetype)settingItemArrowWithDic:(NSDictionary *)dic;
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
+ (instancetype)settingItemWithType:(SettingItemType)type icon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle badgeValue:(NSString *)badgeValue rightStr:(NSString *)rightStr destVcClass:(Class)destVcClass option:(void (^)())option;

@end
