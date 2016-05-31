//
//  Status.h
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//  微博模型（一个status就代表一条微博）

#import <Foundation/Foundation.h>
#import "StatusUser.h"

@interface Status : NSObject<NSCoding>
/*
{
     idstr = 3946451421287985;
     "comments_count" = 5;
     "reposts_count" = 57;
     "created_at" = "Thu Feb 25 17:00:03 +0800 2016";
    "pic_urls" =             (
    );
    source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>";
    text = "\U55b5\U661f\U4eba\U7684\U4e16\U754c\Uff0c\U4f60\U4e0d\U61c2\Uff0c\U8981\U77e5\U9053\U5730\U7403\U662f\U55b5\U661f\U4eba\U7684\Uff01[doge]http://t.cn/R4wlTHQ";
    user =             {
        gender = f;
        idstr = 2909406375;
        name = "\U667a\U969c\U5c0f\U5a4a\U7838";
        "profile_image_url" = "http://tp4.sinaimg.cn/2909406375/50/5741264798/0";
    };
 }
 */

/**
*  字符串的id
*/
@property (copy, nonatomic) NSString *idstr;
/**
 *  转发数
 */
@property (assign, nonatomic)long long int reposts_count;
/**
 *  评论数
 */
@property (assign, nonatomic)long long int comments_count;
/**
 *  赞数
 */
@property (assign,nonatomic) long long int attitudes_count;
/**
 *  发送时间
 */
@property (copy, nonatomic) NSString *created_at;
/**
 *  创建时间
 */
@property (weak,nonatomic) NSString *created_time;
/**
 *  图片数组
 */
@property (strong, nonatomic) NSArray *pic_urls;
/**
 *  来源
 */
@property (copy, nonatomic) NSString *source;
/**
 *  正文
 */
@property (copy, nonatomic) NSString *text;
/**
 *  缩略图（单张配图）
 */
//@property (copy,nonatomic) NSString *thumbnail_pic;
/**
 *  转发的微博
 */
@property (strong,nonatomic) Status *retweeted_status;
/**
 *  作者模型
 */
@property (strong, nonatomic) StatusUser *user;

//+ (instancetype)statusWith:(NSDictionary *)dic;
//- (instancetype)initWith:(NSDictionary *)dic;

@end
