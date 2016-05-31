//
//  StatusFrame.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/1.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusFrame.h"
#import "ConFunc.h"
#import "WBImagesView.h"

@implementation StatusFrame

- (void)setStatus:(Status *)status
{
    if (status) {
        /** 顶部的view */
//        @property (assign, nonatomic, readonly)CGRect topImageViewF;
//        /** 头像 */
//        @property (assign, nonatomic, readonly)CGRect iconImageViewF;
//        /** 会员图标 */
//        @property (assign, nonatomic, readonly)CGRect vipImageViewF;
//        /** 配图 */
//        @property (assign, nonatomic, readonly)CGRect photoImageViewF;
//        /** 昵称 */
//        @property (assign, nonatomic, readonly)CGRect nameLabelF;
//        /** 时间 */
//        @property (assign, nonatomic, readonly)CGRect timeLabelF;
//        /** 来源 */
//        @property (assign, nonatomic, readonly)CGRect souceLabelF;
//        /** 正文\内容 */
//        @property (assign, nonatomic, readonly)CGRect contextLabelF;
//        /** 被转发微博的view(父控件) */
//        @property (assign, nonatomic, readonly)CGRect forwardBackImageViewF;
//        /** 被转发微博作者的昵称 */
//        @property (assign, nonatomic, readonly)CGRect forwardNameLabelF;
//        /** 被转发微博的正文\内容 */
//        @property (assign, nonatomic, readonly)CGRect forwardContextLabelF;
//        /** 被转发微博的配图 */
//        @property (assign, nonatomic, readonly)CGRect forwardPhotImageViewF;
//        /** 微博的工具条 */
//        @property (assign, nonatomic, readonly)CGRect statusToolBarF;
        
        _status = status;
        
        //初步设置topImageView
        CGFloat X = 0;
        CGFloat Y = 0;
        CGFloat W = MainScreen_Width - 2*SPACING;
        CGFloat H = 0;
        _topImageViewF = CGRectMake(X, Y, W, H);
        
        //头像
        X = SPACING;
        Y = SPACING;
        W = 44;
        H = W;
        _iconImageViewF = CGRectMake(X, Y, W, H);
        
        //名称
        X = CGRectGetMaxX(_iconImageViewF) + SPACING;
        _nameLabelF = (CGRect){{X,Y},[ConFunc getAutoSize:CGFLOAT_MAX andStr:self.status.user.name andFont:StatusNameFont]};
        
        //VIP
        if (status.user.mbtype > 2) {
            X = CGRectGetMaxX(_nameLabelF) + SPACING;
            H = _nameLabelF.size.height;
            W = H;
            _vipImageViewF = CGRectMake(X, Y, W, H);
        }
        
        //时间
        X = _nameLabelF.origin.x;
        CGSize size = [ConFunc getAutoSize:CGFLOAT_MAX andStr:self.status.created_time andFont:StatusTimeFont];
        Y = CGRectGetMaxY(_iconImageViewF) - size.height;
        _timeLabelF = (CGRect){{X,Y},size};
        
        //来源
        X = CGRectGetMaxX(_timeLabelF) + SPACING;
        _souceLabelF = (CGRect){{X,Y},[ConFunc getAutoSize:CGFLOAT_MAX andStr:self.status.source andFont:StatusSourceFont]};
        
        //正文
        X = _iconImageViewF.origin.x;
        Y = CGRectGetMaxY(_iconImageViewF) + SPACING;
        W = _topImageViewF.size.width - 2*SPACING;
        H = [ConFunc getAutoSize:W andStr:self.status.text andFont:StatusContextFont].height;
        _contextLabelF = CGRectMake(X, Y, W, H);
        
        //配图
        if (status.pic_urls.count) {
            size = [WBImagesView imagesViewSizeWithPhotosCount:(int)status.pic_urls.count];
            W = size.width;
            H = size.height;
            X = _contextLabelF.origin.x + SPACING;
            Y = CGRectGetMaxY(_contextLabelF) + SPACING;
            _photoImageViewF = CGRectMake(X, Y, W, H);
        }
        
        //被转发weibo
        if (status.retweeted_status) {
            X = _contextLabelF.origin.x;
            Y = CGRectGetMaxY(_contextLabelF) + SPACING;
            W = _contextLabelF.size.width;
            H = 0;
            _forwardBackImageViewF = CGRectMake(X, Y, W, H);
            
            //转发微博昵称
            X = SPACING;
            Y = 1.5*SPACING;
            _forwardNameLabelF = (CGRect){{X,Y},[ConFunc getAutoSize:MAXFLOAT andStr:status.retweeted_status.user.name andFont:StatusNameFont]};
            
            //转发微博正文
            Y = CGRectGetMaxY(_forwardNameLabelF) + SPACING;
            W = _forwardBackImageViewF.size.width - 2*SPACING;
            H = [ConFunc getAutoSize:W andStr:status.retweeted_status.text andFont:StatusContextFont].height;
            _forwardContextLabelF = CGRectMake(X, Y, W, H);
            
            //转发微博配图
            if (status.retweeted_status.pic_urls.count) {
                X += SPACING;
                Y = CGRectGetMaxY(_forwardContextLabelF) + SPACING;
                size = [WBImagesView imagesViewSizeWithPhotosCount:(int)status.retweeted_status.pic_urls.count];
                W = size.width;
                H = size.height;
                _forwardPhotImageViewF = CGRectMake(X, Y, W, H);
                
                H = CGRectGetMaxY(_forwardPhotImageViewF) + SPACING;
            }
            else
            {
                H = CGRectGetMaxY(_forwardContextLabelF) + SPACING;
            }
        }
        else
        {
            if (status.pic_urls.count) {
                //重新计算topImageView
                H = CGRectGetMaxY(_photoImageViewF) + SPACING;
            }
            else
            {
                //重新计算topImageView
                H = CGRectGetMaxY(_contextLabelF) + SPACING;
            }
        }
        
        //重新计算topImageView
        X = _forwardBackImageViewF.origin.x;
        Y = _forwardBackImageViewF.origin.y;
        W = _forwardBackImageViewF.size.width;
        _forwardBackImageViewF = CGRectMake(X, Y, W, H);
        
        //重新计算topImageView
        X = _topImageViewF.origin.x;
        Y = _topImageViewF.origin.y;
        W = _topImageViewF.size.width;
        H = CGRectGetMaxY(_forwardBackImageViewF);
        _topImageViewF = CGRectMake(X, Y, W, H);
        
        //工具条
        Y = CGRectGetMaxY(_topImageViewF);
        H = 44;
        _statusToolBarF = CGRectMake(X, Y, W, H);
        
        //cell的高度
        _cellHeight = CGRectGetMaxY(_statusToolBarF) + SPACING;
    }
}

@end
