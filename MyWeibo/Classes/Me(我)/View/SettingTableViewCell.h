//
//  SettingTableViewCell.h
//  MyWeibo
//
//  Created by     -MINI on 16/4/12.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"

@interface SettingTableViewCell : UITableViewCell
/**
 *  需要展示的数据模型
 */
@property (strong, nonatomic) SettingItem *item;
/**
 *  在tableView中的位置
 */
@property (strong, nonatomic) NSIndexPath *indexPath;

+ (instancetype)settingTableViewCell:(UITableView *)tableView;

@end
