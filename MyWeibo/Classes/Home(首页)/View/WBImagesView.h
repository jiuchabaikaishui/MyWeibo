//
//  WBImagesView.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/10.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBImagesView : UIImageView

@property (strong, nonatomic)NSArray *photos;

+ (CGSize)imagesViewSizeWithPhotosCount:(int)count;

@end
