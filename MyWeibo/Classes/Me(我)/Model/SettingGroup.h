//
//  SettingGroup.h
//  MyWeibo
//
//  Created by apple on 16/4/11.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject

/**
 *  tableView一组cell的头部
 */
@property (copy,nonatomic) NSString *header;
/**
 *  tableView一组cell的尾部
 */
@property (copy,nonatomic) NSString *fooder;
/**
 *  这一组的cell数据
 */
@property (strong,nonatomic) NSArray *items;

/**
 *  获得一个SettingGroup实例
 *
 *  @param items  实例中表示行的数据模型
 *  @param header 组的头部文字
 *  @param fooder 组的尾部文字
 *
 *  @return SettingGroup实例
 */
+ (instancetype)settingGroupWithItems:(NSArray *)items header:(NSString *)header fooder:(NSString *)fooder;

@end
