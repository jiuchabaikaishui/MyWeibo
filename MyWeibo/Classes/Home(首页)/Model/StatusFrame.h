//
//  StatusFrame.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/1.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Status.h"


@interface StatusFrame : NSObject

/**
 *  微博数据模型
 */
@property (strong, nonatomic)Status *status;

/** 顶部的view */
@property (assign, nonatomic, readonly)CGRect topImageViewF;
/** 头像 */
@property (assign, nonatomic, readonly)CGRect iconImageViewF;
/** 会员图标 */
@property (assign, nonatomic, readonly)CGRect vipImageViewF;
/** 配图 */
@property (assign, nonatomic, readonly)CGRect photoImageViewF;
/** 昵称 */
@property (assign, nonatomic, readonly)CGRect nameLabelF;
/** 时间 */
@property (assign, nonatomic, readonly)CGRect timeLabelF;
/** 来源 */
@property (assign, nonatomic, readonly)CGRect souceLabelF;
/** 正文\内容 */
@property (assign, nonatomic, readonly)CGRect contextLabelF;
/** 被转发微博的view(父控件) */
@property (assign, nonatomic, readonly)CGRect forwardBackImageViewF;
/** 被转发微博作者的昵称 */
@property (assign, nonatomic, readonly)CGRect forwardNameLabelF;
/** 被转发微博的正文\内容 */
@property (assign, nonatomic, readonly)CGRect forwardContextLabelF;
/** 被转发微博的配图 */
@property (assign, nonatomic, readonly)CGRect forwardPhotImageViewF;
/** 微博的工具条 */
@property (assign, nonatomic, readonly)CGRect statusToolBarF;
/** cell高度 */
@property (assign, nonatomic, readonly)CGFloat cellHeight;

@end
