//
//  StatusTableViewCell.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/1.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusFrame.h"

@interface StatusTableViewCell : UITableViewCell

@property (strong, nonatomic)StatusFrame *statusFrame;

+ (instancetype)statusTableViewCellWith:(UITableView *)tableView;

@end
