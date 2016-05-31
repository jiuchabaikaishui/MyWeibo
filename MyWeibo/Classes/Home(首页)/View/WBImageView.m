//
//  WBImageView.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/10.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "WBImageView.h"
#import "UIImageView+WebCache.h"

@interface WBImageView ()

@property (weak, nonatomic)UIImageView *gifImageView;

@end

@implementation WBImageView

#pragma mark - 属性方法
- (void)setPhoto:(Photo *)photo
{
    if (photo) {
        _photo = photo;
        self.gifImageView.hidden = ![photo.thumbnail_pic rangeOfString:@".gif"].length;
        [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:DefaultImage];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"timeline_image_gif"];
        [self addSubview:imageView];
        self.gifImageView = imageView;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.gifImageView.image.size;
    CGFloat X = self.frame.size.width - size.width;
    CGFloat Y = self.frame.size.height - size.height;
    self.gifImageView.frame = (CGRect){{X,Y},size};
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
