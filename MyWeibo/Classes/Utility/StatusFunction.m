//
//  StatusFunction.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/28.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusFunction.h"
#import "StatusCacheFunction.h"

@implementation StatusFunction

/**
 *  获取某条微博前面或后面的一些微博
 *
 *  @param count    需获取的微博数（默认20）
 *  @param statusId 所依据的某条微博id（不传就取当前的）
 *  @param front    是取前面的还是后面的
 *  @param success  获取成功后的block
 *  @param failure  获取失败后的block
 */
+ (void)achieveStatus:(int)count fromStatus:(NSString *)statusId front:(BOOL)front  successfulBlock:(void (^)(NSArray *statusArr))success failureBlock:(void (^)(NSError *error))failure
{
//    NSArray *arr = [StatusCacheFunction achieveDicStatuses:count fromStatus:statusId front:front];
//    if (arr.count) {
//        if (success) {
//            NSArray *statusArr = [Status mj_objectArrayWithKeyValuesArray:arr];
//            success(statusArr);
//        }
//    }
    NSArray *arr = [StatusCacheFunction achieveModelStatuses:count fromStatus:statusId front:front];
    if (arr.count) {
        if (success) {
            success(arr);
        }
    }
    else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
        params[@"access_token"] = [AccountTool achieveAccount].access_token;
        params[@"count"] = @(count);
        if (![ConFunc isBlankString:statusId]) {
            if (front) {
                // 加载ID比since_id大的微博
                params[@"since_id"] = statusId;
            }
            else
            {
                long long int maxId = [statusId longLongValue] - 1;
                [params setObject:@(maxId) forKey:@"max_id"];
            }
        }
        [NetworkingRequest networkingRequestGET:@"https://api.weibo.com/2/statuses/friends_timeline.json" paramaters:params successfulBlock:^(id data) {
            QSPLog(@"%@",data);
            NSArray *statusArr = [Status mj_objectArrayWithKeyValuesArray:data[@"statuses"]];
//            [StatusCacheFunction addDicStatuses:data[@"statuses"]];
            [StatusCacheFunction addModelStatuses:statusArr];
            
            if (success) {
                success(statusArr);
            }
        } failureBlock:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

+ (void)sendStatusWithContent:(NSString *)content pictures:(NSArray *)pics successfulBlock:(void (^)(Status *status))success failureBlock:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params setValue:content forKey:@"status"];
    Account *account = [AccountTool achieveAccount];
    [params setValue:account.access_token forKey:@"access_token"];
    
    if (pics&&pics.count) {
        NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:1];
        for (UIImage *image in pics) {
            FileDataMode *model = [[FileDataMode alloc] init];
            model.data = UIImageJPEGRepresentation(image, 0.5);
            model.name = @"pic";
            NSDate *date = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyyMMddHHmmss";
            model.fileName = [NSString stringWithFormat:@"%@,%i",[fmt stringFromDate:date],(int)[pics indexOfObject:image]];
            model.mimeType = @"image/jpeg";
            [dataArr addObject:model];
        }
        [NetworkingRequest networkingRequestPOST:YES isShowSuccessAndFailure:YES urlString:@"https://upload.api.weibo.com/2/statuses/upload.json" paramaters:params fileDataArray:dataArr successfulBlock:^(id data) {
            if (success) {
                success(nil);
            }
        } failureBlock:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    else
    {
        [NetworkingRequest networkingRequestPOST:@"https://api.weibo.com/2/statuses/update.json" paramaters:params successfulBlock:^(id data) {
            if (success) {
                success(nil);
            }
        } failureBlock:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
