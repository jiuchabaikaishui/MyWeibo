//
//  SettingBasicTableViewController.h
//  MyWeibo
//
//  Created by apple on 16/4/11.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingGroup.h"

@interface SettingBasicTableViewController : UITableViewController
/**
 *  控制器中所拥有的cell组的数据模型数组
 */
@property (strong,nonatomic) NSMutableArray *groups;

/**
 *  添加一组数据
 *
 *  @param group 组数据模型
 */
- (void)addGroup:(SettingGroup *)group;

@end
