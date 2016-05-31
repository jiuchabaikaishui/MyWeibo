//
//  MainTabBar.h
//  MyWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarModel.h"

@class MainTabBar;
@protocol MainTabBarDelegate <NSObject>

- (void)mainTabBar:(MainTabBar *)tabBar selectedFromIndex:(int)formIndex toIndex:(int)toIndex;
- (void)mainTabBarPlusButtonClicked:(MainTabBar *)tabBar;

@end

@interface MainTabBar : UIView
@property (weak,nonatomic) id<MainTabBarDelegate> delegate;

- (void)clickedButton:(NSInteger)num;
- (void)addButtonWithItem:(UITabBarItem *)item;

@end
