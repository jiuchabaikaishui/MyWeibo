//
//  WBImagesView.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/10.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "WBImagesView.h"
#import "WBImageView.h"
#import "SDPhotoBrowser.h"

#define ImageView_W             70
#define ImageView_H             ImageView_W

@interface WBImagesView ()<SDPhotoBrowserDelegate>

@property (strong, nonatomic)NSMutableArray *imageViews;
@property (strong, nonatomic)NSMutableArray *showImageViews;

@end

@implementation WBImagesView

#pragma mark - 属性方法
- (NSMutableArray *)imageViews
{
    if (_imageViews == nil) {
        _imageViews = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _imageViews;
}
- (NSMutableArray *)showImageViews
{
    if (_showImageViews == nil) {
        _showImageViews = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _showImageViews;
}
- (void)setPhotos:(NSArray *)photos
{
    [self.showImageViews removeAllObjects];
    
    if (photos) {
        _photos = photos;
        
        for (int index = 0; index < self.imageViews.count; index++) {
            WBImageView *imageView = self.imageViews[index];
            
            if (index < photos.count) {
                imageView.hidden = NO;
                imageView.photo = photos[index];
                
                int maxColumns = photos.count == 4 ? 2 : 3;
                int col = index%maxColumns;
                int row = index/maxColumns;
                CGFloat X = col*(ImageView_W + SPACING);
                CGFloat Y = row*(ImageView_H + SPACING);
                imageView.frame = CGRectMake(X, Y, ImageView_W, ImageView_H);
                
                // Aspect : 按照图片的原来宽高比进行缩
                // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
                // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
                // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
                if (photos.count == 1) {
                    imageView.contentMode = UIViewContentModeScaleAspectFit;
                    imageView.clipsToBounds = NO;
                }
                else
                {
                    imageView.contentMode = UIViewContentModeScaleAspectFill;
                    imageView.clipsToBounds = YES;
                }
                
                [self.showImageViews addObject:imageView];
            }
            else
            {
                imageView.hidden = YES;
            }
        }
    }
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        for (int index = 0; index < 9; index++) {
            WBImageView *imageView = [[WBImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            imageView.tag = index;
            [self addSubview:imageView];
            [self.imageViews addObject:imageView];
            
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)]];
        }
    }
    
    return self;
}
- (void)imageViewClicked:(UITapGestureRecognizer *)sender
{
    QSPLog(@"您点击了第%i张图片！",(int)sender.view.tag + 1);
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photos.count; // 图片总数
    browser.currentImageIndex = sender.view.tag;
    browser.delegate = self;
    [browser show];
}

#pragma mark - 自定义方法
+ (CGSize)imagesViewSizeWithPhotosCount:(int)count
{
    int maxColumns = count == 4 ? 2 : 3;
    int cols = count > maxColumns ? maxColumns : count;
    int rows = (count - 1)/maxColumns + 1;
    CGFloat W = cols*ImageView_W + (cols - 1)*SPACING;
    CGFloat H = rows*ImageView_H + (rows - 1)*SPACING;
    
    return CGSizeMake(W, H);
}

#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.showImageViews[index];
    return imageView.image;//[self.subviews[index] currentImage];
}
// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [[self.photos[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
