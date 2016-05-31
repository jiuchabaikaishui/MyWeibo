//
//  StatusFunction.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/28.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicFunction.h"
#import "Status.h"

@interface StatusFunction : BasicFunction

/**
 *  获取某条微博前面或后面的一些微博
 *
 *  @param count    需获取的微博数（默认20）
 *  @param statusId 所依据的某条微博id（不传就取当前的）
 *  @param front    是取前面的还是后面的
 *  @param success  获取成功后的block
 *  @param failure  获取失败后的block
 */
+ (void)achieveStatus:(int)count fromStatus:(NSString *)statusId front:(BOOL)front  successfulBlock:(void (^)(NSArray *statusArr))success failureBlock:(void (^)(NSError *error))failure;
/**
 *  发送微博
 *
 *  @param content 微博的文字内容
 *  @param pics    微博的图片数组
 *  @param success  发送成功后的block
 *  @param failure  发送失败后的block
 */
+ (void)sendStatusWithContent:(NSString *)content pictures:(NSArray *)pics successfulBlock:(void (^)(Status *status))success failureBlock:(void (^)(NSError *error))failure;

@end
