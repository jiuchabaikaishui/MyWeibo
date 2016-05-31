//
//  ForwardStatusView.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/10.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "ForwardStatusView.h"
#import "ConFunc.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"
#import "WBImagesView.h"

@interface ForwardStatusView ()

/** 被转发微博作者的昵称 */
@property (weak, nonatomic)UILabel *forwardNameLabel;
/** 被转发微博的正文\内容 */
@property (weak, nonatomic)UILabel *forwardContextLabel;
/** 被转发微博的配图 */
@property (weak, nonatomic)WBImagesView *forwardPhotImageView;

@end

@implementation ForwardStatusView

#pragma mark - 属性方法
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    if (statusFrame) {
        _statusFrame = statusFrame;
        
        Status *status = statusFrame.status.retweeted_status;
        StatusUser *user = status.user;
        
        if (status) {
            self.hidden = NO;
            self.frame = self.statusFrame.forwardBackImageViewF;
            
            self.forwardNameLabel.frame = self.statusFrame.forwardNameLabelF;
            self.forwardNameLabel.text = user.name;
            
            self.forwardContextLabel.frame = self.statusFrame.forwardContextLabelF;
            self.forwardContextLabel.text = status.text;
            
            if (status.pic_urls.count) {
                self.forwardPhotImageView.hidden = NO;
                self.forwardPhotImageView.frame = self.statusFrame.forwardPhotImageViewF;
                self.forwardPhotImageView.photos = self.statusFrame.status.retweeted_status.pic_urls;
            }
            else
            {
                self.forwardPhotImageView.hidden = YES;
            }
        }
        else
        {
            self.hidden = YES;
        }
    }
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [ConFunc imageWithName:@"timeline_retweet_background_os7" fromLeft:0.8 fromTop:0.5];
        self.highlightedImage = [ConFunc imageWithName:@"timeline_retweet_background_highlighted_os7" fromLeft:0.8 fromTop:0.5];
        
        /** 被转发微博的配图 */
        WBImagesView *imageView = [[WBImagesView alloc] init];
        [self addSubview:imageView];
        self.forwardPhotImageView = imageView;
        
        /** 被转发微博作者的昵称 */
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.forwardNameLabel = label;
        self.forwardNameLabel.font = StatusNameFont;
        self.forwardNameLabel.textColor = QSPClolor(67, 107, 163);
        
        /** 被转发微博的正文\内容 */
        label = [[UILabel alloc] init];
        [self addSubview:label];
        self.forwardContextLabel = label;
        self.forwardContextLabel.font = StatusContextFont;
        self.forwardContextLabel.textColor = QSPClolor(90, 90, 90);
        self.forwardContextLabel.numberOfLines = 0;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
