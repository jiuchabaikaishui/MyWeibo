//
//  HomeViewController.m
//  MyWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "HomeViewController.h"
#import "TestViewController.h"
#import "UIBarButtonItem+QSP.h"
#import "HomeTitleButton.h"
#import "StatusFunction.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
#import "StatusFrame.h"
#import "MJExtension.h"
#import "StatusTableViewCell.h"
#import "ConFunc.h"
#import "MJRefresh.h"
#import "UserFunction.h"

@interface HomeViewController ()

/**
 *  所有的微博数组
 */
@property (strong, nonatomic)NSMutableArray *statusFrames;

@end

@implementation HomeViewController

#pragma mark - 属性方法
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _statusFrames;
}

#pragma mark - 控制器周期
- (void)dealloc
{
    [Notification_DefaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self settingUi];
    
    //集成刷新控件
    [self settingRefreshCtr];
    
    //获得用户信息
    [self gettingUserData];
    
    [Notification_DefaultCenter addObserver:self selector:@selector(refreshHomeData:) name:@"RefreshHomeData" object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 10;
}

#pragma mark - 触摸点击手势
- (void)titleButtonAction:(HomeTitleButton *)sender
{
    if (sender.type == HomeTitleButtonTypeDown) {
        [sender setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
        sender.type = HomeTitleButtonTypeUp;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
        sender.type = HomeTitleButtonTypeDown;
    }
}
- (void)leftBarAction:(UIBarButtonItem *)sender
{
    QSPLog(@"左边按钮被点了！");
    
    TestViewController *ctr = [[TestViewController alloc] init];
    ctr.title = @"Push";
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)rightBarAction:(UIBarButtonItem *)sender
{
    QSPLog(@"右边按钮被点了！");
    
    TestViewController *ctr = [[TestViewController alloc] init];
    ctr.title = @"Push";
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)refreshHomeData:(NSNotification *)sender
{
    if (self.tabBarController.selectedIndex != 0) {
        self.tabBarController.selectedIndex = 0;
    }
    [self refreshWeiboData:nil andIsUp:NO];
}

#pragma mark - 自定义方法
- (void)refreshWeiboData:(UIRefreshControl *)sender andIsUp:(BOOL)isUp
{
    NSString *statusId;
    if (isUp) {
        StatusFrame *statusFrame = [self.statusFrames lastObject];
        long long int maxId = [statusFrame.status.idstr longLongValue] - 1;
        statusId = [NSString stringWithFormat:@"%lli",maxId];
    }
    else
    {
        if (self.statusFrames.count) {
            StatusFrame *statusFrame = self.statusFrames[0];
            // 加载ID比since_id大的微博
            statusId = statusFrame.status.idstr;
        }
    }
    [StatusFunction achieveStatus:10 fromStatus:statusId front:!isUp successfulBlock:^(NSArray *statusArr) {
        NSMutableArray *statusFrameArr = [NSMutableArray arrayWithCapacity:1];
        for (Status *status in statusArr) {
            StatusFrame *statusFrame = [[StatusFrame alloc] init];
            statusFrame.status = status;
            QSPLog(@"%@",status.idstr);
            [statusFrameArr addObject:statusFrame];
        }
        
        //显示最新微博数量
        if (statusFrameArr.count > 0) {
            if (isUp) {
                [self.statusFrames addObjectsFromArray:statusFrameArr];
                [self.tableView.mj_footer endRefreshing];
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.tabBarItem.badgeValue = nil;
                });
                [self showNewStatusCount:statusFrameArr.count];
                [statusFrameArr addObjectsFromArray:self.statusFrames];
                self.statusFrames = statusFrameArr;
                [self.tableView.mj_header endRefreshing];
            }
            
            [self.tableView reloadData];
        }
        else
        {
            if (isUp) {
                [self.tableView.mj_footer endRefreshing];
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.tabBarItem.badgeValue = nil;
                });
                [self showNewStatusCount:statusFrameArr.count];
                [self.tableView.mj_header endRefreshing];
            }
        }
    } failureBlock:^(NSError *error) {
        QSPLog(@"-----------------------%@",error);
        if (isUp) {
            [self.tableView.mj_footer endRefreshing];
        }
        else
        {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}
- (void)gettingUserData
{
    [UserFunction achieveUserInfoWithsuccessfulBlock:^(StatusUser *user) {
        Account *account = [AccountTool achieveAccount];
        account.name = user.name;
        [AccountTool savaAccount:account];
        
        HomeTitleButton *titleButton = (HomeTitleButton *)self.navigationItem.titleView;
        [titleButton setFrameWithTitle:account.name forState:UIControlStateNormal];
    } failureBlock:^(NSError *error) {
        QSPLog(@"%@",error);
    }];
}
- (void)settingRefreshCtr
{
    __weak typeof(self) weakSelf = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshWeiboData:nil andIsUp:NO];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf refreshWeiboData:nil andIsUp:YES];
    }];
    self.tableView.mj_footer = footer;
}
- (void)showNewStatusCount:(NSInteger)count
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setBackgroundImage:[ConFunc imageWithName:@"timeline_new_status_background_os7"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:button belowSubview:self.navigationController.navigationBar];
    
    NSString *title = @"没有新的微博数据！";
    if (count) {
        title = [NSString stringWithFormat:@"共有%i条新的微博数据！",(int)count];
    }
    [button setTitle:title forState:UIControlStateNormal];
    
    CGFloat X = SPACING;
    CGFloat W = MainScreen_Width - 2*SPACING;
    CGFloat H = 30;
    CGFloat Y = MainStatus_NavBar_Height - H;
    button.frame = CGRectMake(X, Y, W, H);
    
    //动画显示
    CGFloat duration = 0.7;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        button.transform = CGAffineTransformTranslate(button.transform, 0, H);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //复位
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [button removeFromSuperview];
        }];
    }];
}
- (void)settingUi
{
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem getBarButtonItem:nil imageName:@"navigationbar_friendsearch_os7" highImageName:@"navigationbar_friendsearch_highlighted_os7" taget:self andAction:@selector(leftBarAction:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getBarButtonItem:nil imageName:@"navigationbar_pop_os7" highImageName:@"navigationbar_pop_highlighted_os7" taget:self andAction:@selector(rightBarAction:)];
    
    HomeTitleButton *titleButton = [HomeTitleButton homeTitleButtonWithFrame:CGRectMake(0 , 0, 130, 44)];
    NSString *name = @"首页";
    Account *account = [AccountTool achieveAccount];
    if (![ConFunc isBlankString:account.name]) {
        name = account.name;
    }
    [titleButton setFrameWithTitle:name forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
    titleButton.type = HomeTitleButtonTypeDown;
    [titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    QSPLog(@"%@",self.navigationItem.rightBarButtonItem);
    
    self.tableView.backgroundColor = MainControllerView_Color;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SPACING, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - <UITableView>代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusTableViewCell *cell = [StatusTableViewCell statusTableViewCellWith:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end
