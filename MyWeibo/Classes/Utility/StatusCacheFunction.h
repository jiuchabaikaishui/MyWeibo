//
//  StatusCacheFunction.h
//  MyWeibo
//
//  Created by     -MINI on 16/4/8.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"

@interface StatusCacheFunction : NSObject

/**
 *  存储微博的字典数据
 *
 *  @param dic 微博的字典数据
 */
+ (void)addDicStatus:(NSDictionary *)dic;

/**
 *  存储微博的字典数据数组
 *
 *  @param dicArr 微博的字典数据数组
 */
+ (void)addDicStatuses:(NSArray *)dicArr;

/**
 *  获取微博字典数据
 *
 *  @param count    获取数据的量
 *  @param statusId 以此id的微博为基础
 *  @param front    是否大于上面的id
 *
 *  @return 获取到的微博数据数组
 */
+ (NSArray *)achieveDicStatuses:(int)count fromStatus:(NSString *)statusId front:(BOOL)front;

/**
 *  存储微博的模型数据
 *
 *  @param dic 微博的模型数据
 */
+ (void)addModelStatus:(Status *)model;

/**
 *  存储微博的模型数据数组
 *
 *  @param dicArr 微博的模型数据数组
 */
+ (void)addModelStatuses:(NSArray *)modelArr;

/**
 *  获取微博模型数据
 *
 *  @param count    获取数据的量
 *  @param statusId 以此id的微博为基础
 *  @param front    是否大于上面的id
 *
 *  @return 获取到的微博数据数组
 */
+ (NSArray *)achieveModelStatuses:(int)count fromStatus:(NSString *)statusId front:(BOOL)front;

@end
