//
//  UserFunction.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/28.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicFunction.h"
#import "StatusUser.h"
#import "StatusUnreadCountModel.h"

@interface UserFunction : BasicFunction

/**
 *  获取用户信息
 *
 *  @param success 获取成功后的block
 *  @param failure 获取失败后的block
 */
+ (void)achieveUserInfoWithsuccessfulBlock:(void (^)(StatusUser *user))success failureBlock:(void (^)(NSError *error))failure;
/**
 *  获取账户信息
 *
 *  @param code 获取码
 *  @param success 获取成功后的block
 *  @param failure 获取失败后的block
 */
+ (void)accessTokenWithCode:(NSString *)code successfulBlock:(void (^)(Account *account))success failureBlock:(void (^)(NSError *error))failure;
/**
 *  获取用户未读消息
 *
 *  @param uid     用户的id
 *  @param success 获取成功后的block
 *  @param failure 获取失败后的block
 */
+ (void)userUnreadCountWithUid:(NSString *)uid succesefulBlock:(void (^)(StatusUnreadCountModel *unreadModel))succese failureBlock:(void (^)(NSError *error))failure;

@end
