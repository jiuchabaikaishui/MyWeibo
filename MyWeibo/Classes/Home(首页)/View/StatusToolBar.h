//
//  StatusToolBar.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/9.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"

@interface StatusToolBar : UIImageView

/**
 *  微博模型
 */
@property (strong, nonatomic)Status *status;

@end
