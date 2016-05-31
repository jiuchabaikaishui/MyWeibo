//
//  UserFunction.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/28.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "UserFunction.h"

@implementation UserFunction
+ (void)achieveUserInfoWithsuccessfulBlock:(void (^)(StatusUser *user))success failureBlock:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    params[@"access_token"] = [AccountTool achieveAccount].access_token;
    params[@"uid"] = @([AccountTool achieveAccount].uid);
    [NetworkingRequest networkingRequestIsGET:YES isWait:YES isShowSuccessAndFailure:NO urlString:@"https://api.weibo.com/2/users/show.json" paramaters:params successfulBlock:^(id data) {
        QSPLog(@"%@",data);
        
        StatusUser *user = [StatusUser mj_objectWithKeyValues:data];
        if (success) {
            success(user);
        }
    } failureBlock:^(NSError *error) {
        QSPLog(@"%@",error);
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)accessTokenWithCode:(NSString *)code successfulBlock:(void (^)(Account *account))success failureBlock:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = Weibo_AppKey;
    params[@"client_secret"] = Weibo_AppSecret;
    params[@"grant_type"] = Weibo_Type;
    params[@"code"] = code;
    params[@"redirect_uri"] = Weibo_RedirectURL;
    [NetworkingRequest networkingRequestIsGET:NO isWait:YES isShowSuccessAndFailure:NO urlString:@"https://api.weibo.com/oauth2/access_token" paramaters:params successfulBlock:^(id data) {
        QSPLog(@"成功：%@",data);
        
        //存储账号数据
        Account *account = [Account accountWithDict:data];
        if (success) {
            success(account);
        }
    } failureBlock:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)userUnreadCountWithUid:(NSString *)uid succesefulBlock:(void (^)(StatusUnreadCountModel *unreadModel))succese failureBlock:(void (^)(NSError *error))failure;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = uid;
    params[@"access_token"] = [AccountTool achieveAccount].access_token;
    [NetworkingRequest networkingRequestIsGET:YES isWait:NO isShowSuccessAndFailure:NO urlString:@"https://rm.api.weibo.com/2/remind/unread_count.json" paramaters:params successfulBlock:^(id data) {
//        QSPLog(@"%@",data);
        StatusUnreadCountModel *model = [StatusUnreadCountModel mj_objectWithKeyValues:data];
        if (succese) {
            succese(model);
        }
    } failureBlock:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
