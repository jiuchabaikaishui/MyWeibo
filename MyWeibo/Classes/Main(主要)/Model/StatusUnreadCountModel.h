//
//  StatusUnreadCountModel.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/28.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusUnreadCountModel : NSObject
/*
 "all_cmt" = 0;
 "all_follower" = 0;
 "all_mention_cmt" = 0;
 "all_mention_status" = 0;
 "attention_cmt" = 0;
 "attention_follower" = 0;
 "attention_mention_cmt" = 0;
 "attention_mention_status" = 0;
 badge = 0;
 "chat_group_client" = 0;
 "chat_group_notice" = 0;
 "chat_group_pc" = 0;
 cmt = 0;
 dm = 20;
 follower = 0;
 group = 0;
 invite = 0;
 "mention_cmt" = 0;
 "mention_status" = 0;
 notice = 0;
 "page_friends_to_me" = 0;
 photo = 0;
 status = 6;
 */

@property (assign, nonatomic)int all_cmt;
@property (assign, nonatomic)int all_follower;
@property (assign, nonatomic)int all_mention_cmt;
@property (assign, nonatomic)int all_mention_status;
@property (assign, nonatomic)int attention_cmt;
@property (assign, nonatomic)int attention_follower;
@property (assign, nonatomic)int attention_mention_cmt;
@property (assign, nonatomic)int attention_mention_status;
@property (assign, nonatomic)int badge;
@property (assign, nonatomic)int chat_group_client;
@property (assign, nonatomic)int chat_group_notice;
@property (assign, nonatomic)int chat_group_pc;
/**
 *  新评论数
 */
@property (assign, nonatomic)int cmt;
/**
 *  新私信数
 */
@property (assign, nonatomic)int dm;
/**
 *  新粉丝数
 */
@property (assign, nonatomic)int follower;
@property (assign, nonatomic)int group;
@property (assign, nonatomic)int invite;
/**
 *  新提及我的微博数
 */
@property (assign, nonatomic)int mention_cmt;
/**
 *  新提及我的评论数
 */
@property (assign, nonatomic)int mention_status;
@property (assign, nonatomic)int notice;
@property (assign, nonatomic)int page_friends_to_me;
@property (assign, nonatomic)int photo;
/**
 *  新微博未读数
 */
@property (assign, nonatomic)int status;

/**
 *  消息的总数
 */
- (int)messageCount;
/**
 *  总数
 */
- (int)count;

@end
