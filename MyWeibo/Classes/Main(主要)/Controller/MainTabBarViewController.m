//
//  MainViewController.m
//  MyWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "MainDefine.h"
#import "MainTabBar.h"
#import "TabBarModel.h"
#import "MainNavigationViewController.h"
#import "ComposeViewController.h"
#import "UserFunction.h"

@interface MainTabBarViewController ()<MainTabBarDelegate>
@property (weak,nonatomic) MainTabBar *mainTabBar;
//当设置selectIndex的时候，是否选中了相应的按钮
@property (assign,nonatomic) BOOL isSelected;

@end

@implementation MainTabBarViewController
#pragma mark - 属性方法
- (MainTabBar *)mainTabBar
{
    if (_mainTabBar == nil) {
        MainTabBar *tabBar = [[MainTabBar alloc] initWithFrame:self.tabBar.bounds];
        tabBar.delegate = self;
        [self.tabBar addSubview:tabBar];
        
        _mainTabBar = tabBar;
    }
    
    return _mainTabBar;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    if (!self.isSelected) {
        [self.mainTabBar clickedButton:selectedIndex];
    }
    
    self.isSelected = NO;
}

#pragma mark - 控制器周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildrenViewControllers];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(checkUnreadInfo:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
#pragma mark - 自定义方法
- (void)checkUnreadInfo:(NSTimer *)timer
{
    [UserFunction userUnreadCountWithUid:[NSString stringWithFormat:@"%lli",[AccountTool achieveAccount].uid] succesefulBlock:^(StatusUnreadCountModel *unreadModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int index = 0; index < self.viewControllers.count; index ++) {
                UIViewController *ctr = self.viewControllers[index];
                switch (index) {
                    case 0:
                        ctr.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unreadModel.status];
                        break;
                    case 1:
                        ctr.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unreadModel.messageCount];
                        break;
                    case 2:
                        break;
                    case 3:
                        ctr.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unreadModel.follower];
                        break;
                        
                    default:
                        break;
                }
            }
            QSPLog(@"%i",unreadModel.count);
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadModel.count;
        });
    } failureBlock:^(NSError *error) {
        QSPLog(@"%@",error);
    }];
}
/**
 *  设置所有的子控制器
 */
- (void)setupChildrenViewControllers
{
    //配置数据
    NSArray *arr = @[[TabBarModel tabBarModelWithDic:@{@"ctrClass":[HomeViewController class],@"title":@"首页",@"badgeValue":@"0",@"imageName":@"tabbar_home_os7",@"selectImageName":@"tabbar_home_selected_os7"}],[TabBarModel tabBarModelWithDic:@{@"ctrClass":[MessageViewController class],@"title":@"消息",@"badgeValue":@"0",@"imageName":@"tabbar_message_center_os7",@"selectImageName":@"tabbar_message_center_selected_os7"}],[TabBarModel tabBarModelWithDic:@{@"ctrClass":[DiscoverViewController class],@"title":@"广场",@"badgeValue":@"0",@"imageName":@"tabbar_discover_os7",@"selectImageName":@"tabbar_discover_selected_os7"}],[TabBarModel tabBarModelWithDic:@{@"ctrClass":[MeViewController class],@"title":@"我",@"badgeValue":@"0",@"imageName":@"tabbar_profile_os7",@"selectImageName":@"tabbar_profile_selected_os7"}]];
    
    //使用配置的数据，设置子控制器
    for (TabBarModel *model in arr) {
        UIViewController *ctr = [[model.ctrClass alloc] init];
        ctr.title = model.title;
        ctr.tabBarItem = [[UITabBarItem alloc] initWithTitle:model.title image:[[UIImage imageNamed:model.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:model.selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [ctr.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
        ctr.tabBarItem.badgeValue = model.badgeValue;
        
        MainNavigationViewController *nav = [[MainNavigationViewController alloc] initWithRootViewController:ctr];
        [self addChildViewController:nav];
        
        [self.mainTabBar addButtonWithItem:ctr.tabBarItem];
    }
}

#pragma mark - <MainTabBarDelegate>代理方法
- (void)mainTabBar:(MainTabBar *)tabBar selectedFromIndex:(int)formIndex toIndex:(int)toIndex
{
    self.isSelected = YES;
    self.selectedIndex = toIndex;
    if (formIndex == toIndex && toIndex == 0) {
        [Notification_DefaultCenter postNotificationName:@"RefreshHomeData" object:nil];
    }
}
- (void)mainTabBarPlusButtonClicked:(MainTabBar *)tabBar
{
    ComposeViewController *ctr = [[ComposeViewController alloc] init];
    MainNavigationViewController *nav = [[MainNavigationViewController alloc] initWithRootViewController:ctr];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
