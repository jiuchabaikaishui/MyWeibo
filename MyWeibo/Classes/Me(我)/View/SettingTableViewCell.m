//
//  SettingTableViewCell.m
//  MyWeibo
//
//  Created by     -MINI on 16/4/12.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "ConFunc.h"
#import "MainBadgeButton.h"

#define RightView_MaxWidth        50

@interface SettingTableViewCell ()

/**
 *  右侧标签
 */
@property (strong, nonatomic) UILabel *rightLabel;
/**
 *  右侧开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  右侧箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  右侧提示数字
 */
@property (strong, nonatomic) MainBadgeButton *rightBadge;
/**
 *  背景图
 */
@property (weak, nonatomic) UIImageView *bgImageView;
/**
 *  选中状态背景图
 */
@property (weak, nonatomic) UIImageView *bgSelectImageView;
/**
 *  在哪个tableView上显示
 */
@property (weak, nonatomic) UITableView *tableView;


@end

@implementation SettingTableViewCell

#pragma mark - 属性方法
- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor grayColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _rightLabel;
}
- (UISwitch *)rightSwitch
{
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
    }
    
    return _rightSwitch;
}
- (UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    
    return _rightArrow;
}
- (MainBadgeButton *)rightBadge
{
    if (!_rightBadge) {
        _rightBadge = [[MainBadgeButton alloc] init];
    }
    
    return _rightBadge;
}
- (void)setItem:(SettingItem *)item
{
    if (item) {
        _item = item;
        
        //设置数据
        if (![ConFunc isBlankString:item.icon]) {
            self.imageView.image = [UIImage imageNamed:item.icon];
        }
        else
        {
            self.imageView.image = nil;
        }
        if (![ConFunc isBlankString:item.title]) {
            self.textLabel.text = item.title;
        }
        else
        {
            self.textLabel.text = nil;
        }
        if (![ConFunc isBlankString:item.subTitle]) {
            self.detailTextLabel.text = item.subTitle;
        }
        else
        {
            self.detailTextLabel.text = nil;
        }
        
        switch (item.type) {
            case SettingItemTypeArrow:
            {
                self.accessoryView = self.rightArrow;
            }
                break;
            case SettingItemTypeLabel:
            {
                CGSize size = [ConFunc getAutoSize:CGFLOAT_MAX andStr:item.rightStr andFont:self.rightLabel.font];
                self.rightLabel.bounds = (CGRect){{0,0},size};
                self.rightLabel.text = item.rightStr;
                self.accessoryView = self.rightLabel;
            }
                break;
            case SettingItemTypeSwitch:
            {
                self.accessoryView = self.rightSwitch;
                self.selectionStyle = UITableViewCellSelectionStyleNone;
            }
                break;
            case SettingItemTypeBadgeValue:
            {
                self.accessoryView = self.rightBadge;
                self.rightBadge.badgeValue = item.badgeValue;
            }
                break;
                
            default:
                self.accessoryView = nil;
                break;
        }
    }
}
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath) {
        _indexPath = indexPath;
        
        NSInteger totalRow = [self.tableView numberOfRowsInSection:indexPath.section];
        NSString *bgImageName;
        NSString *bgSelectImageName;
        if (totalRow == 1) {//只有一行
            bgImageName = @"common_card_background_os7";
            bgSelectImageName = @"common_card_background_highlighted_os7";
        }
        else if (indexPath.row == 0)//首行
        {
            bgImageName = @"common_card_top_background_os7";
            bgSelectImageName = @"common_card_top_background_highlighted_os7";
        }
        else if (indexPath.row == totalRow - 1)//尾行
        {
            bgImageName = @"common_card_bottom_background_os7";
            bgSelectImageName = @"common_card_bottom_background_highlighted_os7";
        }
        else//中行
        {
            bgImageName = @"common_card_middle_background_os7";
            bgSelectImageName = @"common_card_middle_background_highlighted_os7";
        }
        
        self.bgImageView.image = [ConFunc imageWithName:bgImageName];
        self.bgSelectImageView.image = [ConFunc imageWithName:bgSelectImageName];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += SPACING;
    frame.size.width -= 2*SPACING;
    
    [super setFrame:frame];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (![ConFunc isBlankString:self.item.subTitle]) {
        // 设置子标题
        CGRect rect = self.textLabel.frame;
        if (CGRectGetWidth(rect) > MainScreen_Width/2) {
            rect.size.width = MainScreen_Width/2;
            self.textLabel.frame = rect;
        }
        if (self.rightBadge) {
            rect = self.rightBadge.frame;
            if (CGRectGetWidth(rect) > RightView_MaxWidth) {
                rect.origin.x = CGRectGetMaxX(rect) - RightView_MaxWidth;
                rect.size.width = RightView_MaxWidth;
                self.rightBadge.frame = rect;
            }
        }
        if (self.rightLabel) {
            rect = self.rightLabel.frame;
            if (CGRectGetWidth(rect) > RightView_MaxWidth) {
                rect.origin.x = CGRectGetMaxX(rect) - RightView_MaxWidth;
                rect.size.width = RightView_MaxWidth;
                self.rightLabel.frame = rect;
            }
        }
        
        CGSize subtitleSize = [ConFunc getAutoSize:CGFLOAT_MAX andStr:self.item.subTitle andFont:self.detailTextLabel.font];//[self.item.subTitle sizeWithFont:self.detailTextLabel.font];
        CGFloat maxW = CGRectGetMinX(self.accessoryView.frame) - CGRectGetMaxX(self.textLabel.frame) - SPACING;
        CGFloat subtitleW = maxW <= subtitleSize.width ? maxW : subtitleSize.width;
        CGFloat subtitleH = subtitleSize.height;
        CGFloat subtitleX = CGRectGetMaxX(self.textLabel.frame) + 5;
        CGFloat subtitleY = (self.contentView.frame.size.height - subtitleH) * 0.5;
        self.detailTextLabel.frame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleH);
    }
}

#pragma mark - 自定义方法

#pragma mark - 工厂方法
+ (instancetype)settingTableViewCell:(UITableView *)tableView
{
    static NSString *ID = @"SettingTableViewCell";
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.tableView = tableView;
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.backgroundView = imageView;
        self.bgImageView = imageView;
        
        imageView = [[UIImageView alloc] init];
        self.selectedBackgroundView = imageView;
        self.bgSelectImageView = imageView;
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
