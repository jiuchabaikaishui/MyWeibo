//
//  StatusTopView.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/10.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusTopView.h"
#import "ConFunc.h"
#import "UIImageView+WebCache.h"
#import "ForwardStatusView.h"
#import "Photo.h"
#import "WBImagesView.h"

@interface StatusTopView ()

/** 头像 */
@property (weak, nonatomic)UIImageView *iconImageView;
/** 会员图标 */
@property (weak, nonatomic)UIImageView *vipImageView;
/** 配图 */
@property (weak, nonatomic)WBImagesView *photoImageView;
/** 昵称 */
@property (weak, nonatomic)UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic)UILabel *timeLabel;
/** 来源 */
@property (weak, nonatomic)UILabel *souceLabel;
/** 正文\内容 */
@property (weak, nonatomic)UILabel *contextLabel;
/** 被转发微博的view(父控件) */
@property (weak, nonatomic)ForwardStatusView *forwardBackImageView;

@end

@implementation StatusTopView

#pragma mark - 属性方法
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    if (statusFrame) {
        _statusFrame = statusFrame;
        
        Status *status = statusFrame.status;
        StatusUser *user = status.user;
        
        /** 头像 */
        self.iconImageView.frame = self.statusFrame.iconImageViewF;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:DefaultImage];
        
        /** 会员图标 */
        self.vipImageView.frame = self.statusFrame.vipImageViewF;
        if (user.mbtype > 2) {
            [self.vipImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%i",user.mbrank]]];
            
            self.nameLabel.textColor = [UIColor orangeColor];
        }
        else
        {
            [self.vipImageView setImage:[UIImage imageNamed:@"common_icon_membership_expired"]];
            
            self.nameLabel.textColor = [UIColor blackColor];
        }
        
        /** 昵称 */
        self.nameLabel.frame = self.statusFrame.nameLabelF;
        self.nameLabel.text = user.name;
        
        /** 时间 */
        self.timeLabel.frame = self.statusFrame.timeLabelF;
        self.timeLabel.text = status.created_time;
        QSPLog(@"----------------------------------------%@",status.created_time);
        
        /** 来源 */
        self.souceLabel.frame = self.statusFrame.souceLabelF;
        self.souceLabel.text = status.source;
        
        //时间
        CGFloat X = self.statusFrame.nameLabelF.origin.x;
        CGSize size = [ConFunc getAutoSize:CGFLOAT_MAX andStr:status.created_time andFont:StatusTimeFont];
        CGFloat Y = CGRectGetMaxY(self.statusFrame.iconImageViewF) - size.height;
        self.timeLabel.frame = (CGRect){{X,Y},size};
        
        //来源
        X = CGRectGetMaxX(self.timeLabel.frame) + SPACING;
        self.souceLabel.frame = (CGRect){{X,Y},[ConFunc getAutoSize:CGFLOAT_MAX andStr:status.source andFont:StatusSourceFont]};
        
        /** 正文\内容 */
        self.contextLabel.frame = self.statusFrame.contextLabelF;
        self.contextLabel.text = status.text;
        
        /** 配图 */
        if (status.pic_urls.count) {
            self.photoImageView.hidden = NO;
            self.photoImageView.frame = self.statusFrame.photoImageViewF;
            self.photoImageView.photos = self.statusFrame.status.pic_urls;
        }
        else
        {
            self.photoImageView.hidden = YES;
        }
        
        /** 设置被转播微博内部子控件数据 */
        self.forwardBackImageView.statusFrame = self.statusFrame;
    }
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [ConFunc imageWithName:@"timeline_card_top_background_os7"];
        self.highlightedImage = [ConFunc imageWithName:@"timeline_card_top_background_highlighted_os7"];
        
        /** 头像 */
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.iconImageView = imageView;
        
        /** 会员图标 */
        imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.vipImageView = imageView;
        self.vipImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        /** 配图 */
        imageView = [[WBImagesView alloc] init];
        [self addSubview:imageView];
        self.photoImageView = (WBImagesView *)imageView;
        
        /** 昵称 */
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.nameLabel = label;
        self.nameLabel.font = StatusNameFont;
        self.nameLabel.textColor = QSPClolor(240, 140, 19);
        
        /** 时间 */
        label = [[UILabel alloc] init];
        [self addSubview:label];
        self.timeLabel = label;
        self.timeLabel.font = StatusTimeFont;
        
        /** 来源 */
        label = [[UILabel alloc] init];
        [self addSubview:label];
        self.souceLabel = label;
        self.souceLabel.font = StatusSourceFont;
        self.souceLabel.textColor = QSPClolor(135, 135, 135);
        
        /** 正文\内容 */
        label = [[UILabel alloc] init];
        [self addSubview:label];
        self.contextLabel = label;
        self.contextLabel.font = StatusContextFont;
        self.contextLabel.numberOfLines = 0;
        self.contextLabel.textColor = QSPClolor(39, 39, 39);
        
        /** 被转发微博的view(父控件) */
        imageView = [[ForwardStatusView alloc] init];
        [self addSubview:imageView];
        self.forwardBackImageView = (ForwardStatusView *)imageView;
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
