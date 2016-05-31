//
//  NetworkingRequest.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "NetworkingRequest.h"
#import "AFNetworking.h"
#import "LoadingClass.h"

@interface NetworkingRequest ()

@end

@implementation NetworkingRequest


+ (void)networkingRequestGET:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure
{
    [self networkingRequestGET:YES urlString:urlStr paramaters:params successfulBlock:sucess failureBlock:failure];
}
+ (void)networkingRequestPOST:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure
{
    [self networkingRequestPOST:YES urlString:urlStr paramaters:params successfulBlock:sucess failureBlock:failure];
}
+ (void)networkingRequestGET:(BOOL)isWait urlString:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure
{
    [self networkingRequestIsGET:YES isWait:isWait urlString:urlStr paramaters:params successfulBlock:sucess failureBlock:failure];
}
+ (void)networkingRequestPOST:(BOOL)isWait urlString:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure
{
    [self networkingRequestIsGET:NO isWait:isWait urlString:urlStr paramaters:params successfulBlock:sucess failureBlock:failure];
}
+ (void)networkingRequestIsGET:(BOOL)isGET isWait:(BOOL)isWait urlString:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure
{
    [self networkingRequestIsGET:isGET isWait:isWait isShowSuccessAndFailure:YES urlString:urlStr paramaters:params successfulBlock:sucess failureBlock:failure];
}
+ (void)networkingRequestIsGET:(BOOL)isGET isWait:(BOOL)isWait isShowSuccessAndFailure:(BOOL)isShow urlString:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    if ([urlStr isEqualToString:@"https://api.weibo.com/oauth2/access_token"]) {//||[urlStr isEqualToString:@"https://rm.api.weibo.com/2/remind/unread_count.json"]
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    
    if (isWait) {
        [LoadingClass show];
    }
    
    if (isGET) {
        [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if (isWait) {
                [LoadingClass hideHUD];
            }
            if (isShow) {
                [LoadingClass showSuccess];
            }
            sucess(responseObject);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            if (isWait) {
                [LoadingClass hideHUD];
            }
            if (isShow) {
                [LoadingClass showFailure];
            }
            failure(error);
        }];
    }
    else
    {
        [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if (isWait) {
                [LoadingClass hideHUD];
            }
            if (isShow) {
                [LoadingClass showSuccess];
            }
            sucess(responseObject);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            if (isWait) {
                [LoadingClass hideHUD];
            }
            if (isShow) {
                [LoadingClass showFailure];
            }
            failure(error);
        }];
    }
}
+ (void)networkingRequestPOST:(BOOL)isWait isShowSuccessAndFailure:(BOOL)isShow urlString:(NSString *)urlStr paramaters:(NSDictionary *)params fileDataArray:(NSArray *)dataArray successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    
    if (isWait) {
        [LoadingClass show];
    }
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (FileDataMode *model in dataArray) {
            [formData appendPartWithFileData:model.data name:model.name fileName:model.fileName mimeType:model.mimeType];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (isWait) {
            [LoadingClass hideHUD];
        }
        if (isShow) {
            [LoadingClass showSuccess];
        }
        sucess(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (isWait) {
            [LoadingClass hideHUD];
        }
        if (isShow) {
            [LoadingClass showFailure];
        }
        failure(error);
    }];
}

@end


@implementation FileDataMode



@end
