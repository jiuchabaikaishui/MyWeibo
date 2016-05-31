//
//  AccountTool.h
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTool : NSObject

/**
 *  保存账户信息
 *
 *  @param accont 账户模型
 */
+ (void)savaAccount:(Account *)account;

/**
 *  获取账户信息
 *
 *  @return 账户模型
 */
+ (Account *)achieveAccount;

@end
