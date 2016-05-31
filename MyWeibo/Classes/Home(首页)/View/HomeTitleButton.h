//
//  HomeTitleButton.h
//  MyWeibo
//
//  Created by apple on 16/2/4.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeTitleButtonType){
    HomeTitleButtonTypeDown = 0,
    HomeTitleButtonTypeUp = 1
};

@interface HomeTitleButton : UIButton
@property (assign,nonatomic) HomeTitleButtonType type;

+ (instancetype)homeTitleButtonWithFrame:(CGRect)frame;
- (void)setFrameWithTitle:(NSString *)title forState:(UIControlState)state;

@end
