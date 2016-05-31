//
//  SettingBasicTableViewController.m
//  MyWeibo
//
//  Created by apple on 16/4/11.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "SettingBasicTableViewController.h"
#import "SettingTableViewCell.h"
#import "ConFunc.h"

#define Section_HF_Height   33

@interface SettingBasicTableViewController ()

@end

@implementation SettingBasicTableViewController

#pragma mark - 属性方法
- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _groups;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.allowsSelection = NO;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - 自定义方法
/**
 *  添加一组数据
 *
 *  @param group 组数据模型
 */
- (void)addGroup:(SettingGroup *)group
{
    [self.groups addObject:group];
}

#pragma mark - <UItableViewDatasource,UITableDelegate>代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SettingGroup *group = self.groups[section];
    return group.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [SettingTableViewCell settingTableViewCell:tableView];
    
    SettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取出模型
    SettingGroup *group = self.groups[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    if (item.option) {
        item.option();
    }
    
    if (item.destVcClass) {
        UIViewController *nextCtr = [[item.destVcClass alloc] init];
        [self.navigationController pushViewController:nextCtr animated:YES];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.groups[section];
    if (![ConFunc isBlankString:group.fooder]) {
        return group.fooder;
    }
    
    return nil;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.groups[section];
    if (![ConFunc isBlankString:group.header]) {
        return group.header;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    SettingGroup *group = self.groups[section];
//    CGFloat heght = 0;
//    
//    if (section == 0) {
//        if ([ConFunc isBlankString:group.header]) {
//            heght =  SPACING;
//        }
//        else
//        {
//            heght =  Section_HF_Height;
//        }
//    }
//    else
//    {
//        SettingGroup *lastGroup = self.groups[section - 1];
//        
//        if (![ConFunc isBlankString:group.header]) {
//            heght =  Section_HF_Height;
//        }
//        else
//        {
//            if ([ConFunc isBlankString:lastGroup.fooder]) {
//                heght =  SPACING;
//            }
//            else
//            {
//                heght =  0;
//            }
//        }
//    }
//    
//    QSPLog(@"第%i组的header：%f",(int)section,heght);
    //    return heght;
    
    CGFloat heght = 0;
    if (section == 0) {
        heght = SPACING;
    }
    else
    {
        heght = SPACING/2;
    }
    
    QSPLog(@"第%i组的header：%f",(int)section,heght);
    return heght;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    SettingGroup *group = self.groups[section];
//    CGFloat heght = 0;
//    
//    if (section == self.groups.count - 1) {
//        if ([ConFunc isBlankString:group.fooder]) {
//            heght =  SPACING;
//        }
//        else
//        {
//            heght =  Section_HF_Height;
//        }
//    }
//    else
//    {
//        SettingGroup *nextGroup = self.groups[section + 1];
//        
//        if (![ConFunc isBlankString:group.fooder]) {
//            heght =  Section_HF_Height;
//        }
//        else
//        {
//            if ([ConFunc isBlankString:nextGroup.header]) {
//                heght =  SPACING;
//            }
//            else
//            {
//                heght =  0;
//            }
//        }
//    }
//    
//    QSPLog(@"第%i组的fooder：%f",(int)section,heght);
//    return heght;
    
    CGFloat heght = 0;
    if (section == self.groups.count - 1) {
        heght = SPACING;
    }
    else
    {
        heght = SPACING/2;
    }
    
    QSPLog(@"第%i组的header：%f",(int)section,heght);
    return heght;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
