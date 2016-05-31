//
//  NewFeatureViewController.m
//  MyWeibo
//
//  Created by apple on 16/2/9.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "MainTabBarViewController.h"

#define NewFeatureCount  3

@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (weak,nonatomic) UIPageControl *pageControl;

@end

@implementation NewFeatureViewController

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置界面
    [self settingUi];
}

#pragma mark - 控制器周期
- (void)startButtonClicked:(UIButton *)sender
{
    //显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[MainTabBarViewController alloc] init];
}
- (void)checkButtonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

#pragma mark - 自定义方法
/**
 *  设置界面
 */
- (void)settingUi
{
    //设置UIScrollView
    [self settingScrollView];
    
    //设置UIPageControl
    [self settingPageControl];
}

/**
 *  设置UIScrollView
 */
- (void)settingScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = QSPClolor(246, 246, 246);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat W = scrollView.frame.size.width;
    CGFloat H = scrollView.frame.size.height;
    int max = NewFeatureCount;
    scrollView.contentSize = CGSizeMake(W*max, H);
    for (int index = 0; index < max; index++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%i",index + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(W*index, 0, W, H)];
        imageView.image = image;
        [scrollView addSubview:imageView];
        
        //在最后一张图片上设置按钮
        if (index == max - 1) {
            [self settingLastImageView:imageView];
        }
    }
}

/**
 *  设置UIPageControl
 */
- (void)settingPageControl
{
    CGFloat H = 30;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.numberOfPages = NewFeatureCount;
    pageControl.bounds = CGRectMake(0, 0, self.view.frame.size.width, H);
    pageControl.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 30);
    [self.view addSubview:pageControl];
    
//    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
//    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    pageControl.currentPageIndicatorTintColor = QSPClolor(253, 98, 42);
    pageControl.pageIndicatorTintColor = QSPClolor(189, 189, 189);
}

- (void)settingLastImageView:(UIImageView *)imageView
{
    //默认UIImageView是不能交互的
    imageView.userInteractionEnabled = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [button setTitle:@"开始微博" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.bounds = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    button.center = CGPointMake(imageView.frame.size.width*0.5, imageView.frame.size.height*0.63);
    [button addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.selected = YES;
    [checkButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    checkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkButton.bounds = CGRectMake(0, 0, button.bounds.size.width, 44);
    checkButton.center = CGPointMake(button.center.x, button.center.y - 44);
    [checkButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [checkButton addTarget:self action:@selector(checkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkButton];
}

#pragma mark - <UIScrollViewDelegate>代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat X = scrollView.contentOffset.x;
    CGFloat floatPage = X/self.view.frame.size.width;
    int intPage = (int)(floatPage + 0.5);
    self.pageControl.currentPage = intPage;
}

@end
