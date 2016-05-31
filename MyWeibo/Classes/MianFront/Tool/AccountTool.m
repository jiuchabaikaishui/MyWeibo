//
//  AccountTool.m
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "AccountTool.h"

//账户信息存储路径
#define accountPath           [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool

/**
 *  保存账户信息
 *
 *  @param accont 账户模型
 */
+ (void)savaAccount:(Account *)account
{
    NSDate *now = [NSDate date];
    //计算过期时间
    account.expiresDate = [now dateByAddingTimeInterval:account.expires_in];
    
    //归档模型
    [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
    [NSKeyedArchiver archivedDataWithRootObject:account];
}

/**
 *  获取账户信息
 *
 *  @return 账户模型
 */
+ (Account *)achieveAccount
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:accountPath]) {
        Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
        NSDate *now = [NSDate date];
        /*
         NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
         依次为降序，相等，升序
         */
        if ([now compare:account.expiresDate] == NSOrderedAscending) {//还没有过期
            return account;
        }
    }
    
    return nil;
}

@end
