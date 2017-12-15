//
//  Account.h
//  MyWeibo
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

@property (nonatomic, copy) NSString *access_token;
// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (assign, nonatomic) BOOL isRealName;
@property (nonatomic, assign) long long uid;
/**
 *  账号过期时间
 */
@property (strong, nonatomic) NSDate *expiresDate;
/**
 *  用户姓名
 */
@property (copy,nonatomic) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
