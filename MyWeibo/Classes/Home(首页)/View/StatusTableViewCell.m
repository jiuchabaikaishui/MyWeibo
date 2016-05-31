//
//  StatusTableViewCell.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/1.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ConFunc.h"
#import "StatusTopView.h"
#import "StatusToolBar.h"

@interface StatusTableViewCell ()
/** 顶部的view */
@property (weak, nonatomic)StatusTopView *topImageView;
/** 微博的工具条 */
@property (weak, nonatomic)StatusToolBar *statusToolBar;

@end

@implementation StatusTableViewCell

#pragma mark - 属性方法
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //设置微博顶部子控件数据
    [self setupTopViewData];
    
    //设置微博的工具条数据
    [self setupStatusToolBarData];
}

+ (instancetype)statusTableViewCellWith:(UITableView *)tableView
{
    static NSString *ID = @"statusCell";
    
    StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加微博顶部子控件
        [self setupTopViewSubviews];
        
        //添加微博的工具条
        [self setupStatusToolBar];
    }
    
    return self;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += SPACING;
    frame.origin.x = SPACING;
    frame.size.width -= 2 * SPACING;
    frame.size.height -= SPACING;
    [super setFrame:frame];
}

/**
 *  添加微博顶部子控件
 */
- (void)setupTopViewSubviews
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = view;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    /** 顶部的view */
    UIImageView *imageView = [[StatusTopView alloc] init];
    [self.contentView addSubview:imageView];
    self.topImageView = (StatusTopView *)imageView;
}

/**
 *  设置微博顶部子控件数据
 */
- (void)setupTopViewData
{
    /** 顶部的view */
    self.topImageView.frame = self.statusFrame.topImageViewF;
    self.topImageView.statusFrame = self.statusFrame;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    StatusToolBar *imageView = [[StatusToolBar alloc] init];
    [self.contentView addSubview:imageView];
    self.statusToolBar = imageView;
//    self.statusToolBar.hidden = YES;
}
/**
 *  设置微博的工具条数据
 */
- (void)setupStatusToolBarData
{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.status = self.statusFrame.status;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
