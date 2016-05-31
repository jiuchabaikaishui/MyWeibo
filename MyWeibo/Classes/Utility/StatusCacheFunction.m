//
//  StatusCacheFunction.m
//  MyWeibo
//
//  Created by     -MINI on 16/4/8.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusCacheFunction.h"
#import "FMDB.h"
#import "AccountTool.h"

/**
 *  数据库路径
 */
#define DBPath_Str                  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/qspStatuses.sqlite"]
/**
 *  微博表名称
 */
#define StatusesDic_Table_Name          @"t_statusesDic"
#define StatusesModel_Table_Name          @"t_statusesModel"

@interface StatusCacheFunction ()

@end

@implementation StatusCacheFunction

static FMDatabaseQueue *dbQueue;

+ (void)initialize
{
    if (self == [self class]) {
        QSPLog(@"%@",DBPath_Str);
        dbQueue = [FMDatabaseQueue databaseQueueWithPath:DBPath_Str];
        
        [dbQueue inDatabase:^(FMDatabase *db) {
            NSString *sqlDicStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, access_token TEXT, idStr TEXT, dic BLOB);",StatusesDic_Table_Name];
            if ([db executeUpdate:sqlDicStr]) {
                QSPLog(@"创建微博字典表成功！");
            }
            else{
                QSPLog(@"创建微博字典表失败！");
            }
            
            NSString *sqlModelStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, access_token TEXT, idStr TEXT, model BLOB);",StatusesModel_Table_Name];
            if ([db executeUpdate:sqlModelStr]) {
                QSPLog(@"创建微博模型表成功！");
            }
            else{
                QSPLog(@"创建微博模型表失败！");
            }
        }];
    }
}

/**
 *  存储微博的字典数据
 *
 *  @param dic 微博的字典数据
 */
+ (void)addDicStatus:(NSDictionary *)dic
{
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (access_token, idStr, dic) VALUES (?, ?, ?);", StatusesDic_Table_Name];
        if ([db executeUpdate:sqlStr,[AccountTool achieveAccount].access_token,dic[@"idstr"],[NSKeyedArchiver archivedDataWithRootObject:dic]]) {
            QSPLog(@"保存微博成功！");
        }
        else
        {
            QSPLog(@"保存微博失败！");
        }
    }];
}

/**
 *  存储微博的字典数据数组
 *
 *  @param dicArr 微博的字典数据数组
 */
+ (void)addDicStatuses:(NSArray *)dicArr
{
    for (NSDictionary *dic in dicArr) {
        [self addDicStatus:dic];
    }
}

/**
 *  获取微博字典数据
 *
 *  @param count    获取数据的量
 *  @param statusId 以此id的微博为基础
 *  @param front    是否大于上面的id
 *
 *  @return 获取到的微博数据数组
 */
+ (NSArray *)achieveDicStatuses:(int)count fromStatus:(NSString *)statusId front:(BOOL)front
{
    __block NSMutableArray *mArr = nil;
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet;
        if (statusId) {
            if (front) {
                NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE access_token = ? AND idStr > ? ORDER BY idStr DESC LIMIT 0,?;",StatusesDic_Table_Name];
                resultSet = [db executeQuery:sqlStr,[AccountTool achieveAccount].access_token,statusId,@(count)];
            }
            else
            {
                NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE access_token = ? AND idStr < ? ORDER BY idStr DESC LIMIT 0,?;",StatusesDic_Table_Name];
                resultSet = [db executeQuery:sqlStr,[AccountTool achieveAccount].access_token,statusId,@(count)];
            }
        }
        else
        {
            NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE access_token = ? ORDER BY idStr DESC LIMIT 0,?;",StatusesDic_Table_Name];
            resultSet = [db executeQuery:sqlStr,[AccountTool achieveAccount].access_token,@(count)];
        }
        
        mArr = [NSMutableArray arrayWithCapacity:1];
        while (resultSet.next) {
            NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:[resultSet dataForColumn:@"dic"]];
            [mArr addObject:dic];
        }
    }];
    
    return mArr;
}

/**
 *  存储微博的模型数据
 *
 *  @param dic 微博的模型数据
 */
+ (void)addModelStatus:(Status *)model
{
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (access_token, idStr, model) VALUES (?, ?, ?);", StatusesModel_Table_Name];
        if ([db executeUpdate:sqlStr,[AccountTool achieveAccount].access_token,model.idstr,[NSKeyedArchiver archivedDataWithRootObject:model]]) {
            QSPLog(@"保存微博成功！");
        }
        else
        {
            QSPLog(@"保存微博失败！");
        }
    }];
}

/**
 *  存储微博的模型数据数组
 *
 *  @param dicArr 微博的模型数据数组
 */
+ (void)addModelStatuses:(NSArray *)modelArr
{
    for (Status *status in modelArr) {
        [self addModelStatus:status];
    }
}

/**
 *  获取微博模型数据
 *
 *  @param count    获取数据的量
 *  @param statusId 以此id的微博为基础
 *  @param front    是否大于上面的id
 *
 *  @return 获取到的微博数据数组
 */
+ (NSArray *)achieveModelStatuses:(int)count fromStatus:(NSString *)statusId front:(BOOL)front
{
    __block NSMutableArray *mArr = nil;
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet;
        if (statusId) {
            if (front) {
                NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE access_token = ? AND idStr > ? ORDER BY idStr DESC LIMIT 0,?;",StatusesModel_Table_Name];
                resultSet = [db executeQuery:sqlStr,[AccountTool achieveAccount].access_token,statusId,@(count)];
            }
            else
            {
                NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE access_token = ? AND idStr < ? ORDER BY idStr DESC LIMIT 0,?;",StatusesModel_Table_Name];
                resultSet = [db executeQuery:sqlStr,[AccountTool achieveAccount].access_token,statusId,@(count)];
            }
        }
        else
        {
            NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE access_token = ? ORDER BY idStr DESC LIMIT 0,?;",StatusesModel_Table_Name];
            resultSet = [db executeQuery:sqlStr,[AccountTool achieveAccount].access_token,@(count)];
        }
        
        mArr = [NSMutableArray arrayWithCapacity:1];
        while (resultSet.next) {
            NSData *data = [resultSet dataForColumn:@"model"];
            Status *stauts = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [mArr addObject:stauts];
        }
    }];
    
    return mArr;
}

@end
