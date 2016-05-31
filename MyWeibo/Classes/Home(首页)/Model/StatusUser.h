//
//  StatusUser.h
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusUser : NSObject<NSCoding>

/*
user =             {
    gender = f;
    idstr = 2909406375;
    name = "\U667a\U969c\U5c0f\U5a4a\U7838";
    "profile_image_url" = "http://tp4.sinaimg.cn/2909406375/50/5741264798/0";
};
 */
/**
*  性别
*/
@property (copy, nonatomic)NSString *gender;
/**
 *  字符串id
 */
@property (copy, nonatomic)NSString *idstr;
/**
 *  姓名
 */
@property (copy, nonatomic)NSString *name;
/**
 *  用户头像
 */
@property (copy, nonatomic)NSString *profile_image_url;
@property (assign,nonatomic, getter=isVip) BOOL vip;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;

//+ (instancetype)statusUserWith:(NSDictionary *)dic;
//- (instancetype)initWith:(NSDictionary *)dic;

@end
