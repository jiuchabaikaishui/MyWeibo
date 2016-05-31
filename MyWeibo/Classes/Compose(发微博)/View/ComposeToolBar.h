//
//  ComposeToolBar.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/16.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ComposeToolBarButtonType) {
    ComposeToolBarButtonTypeCamera,
    ComposeToolBarButtonTypePicture,
    ComposeToolBarButtonTypeMention,
    ComposeToolBarButtonTypeTrend,
    ComposeToolBarButtonTypeEmotion
};

@class ComposeToolBar;
@protocol ComposeToolBarDelegate <NSObject>

- (void)composeToolBarDelegate:(ComposeToolBar *)toolBar clickedButtonType:(ComposeToolBarButtonType)type;

@end

@interface ComposeToolBar : UIView
@property (weak, nonatomic)id<ComposeToolBarDelegate> delegate;

@end
