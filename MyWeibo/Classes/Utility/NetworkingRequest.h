//
//  NetworkingRequest.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingRequest : NSObject

/**
 *  发送GET请求,出现等待提示，并出现成功失败提示
 *
 *  @param urlStr  请求的URL
 *  @param params  请求参数
 *  @param sucess  请求成功的block
 *  @param failure 请求失败的block
 */
+ (void)networkingRequestGET:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure;
/**
 *  发送POST请求,出现等待提示，并出现成功失败提示
 *
 *  @param urlStr  请求的URL
 *  @param params  请求参数
 *  @param sucess  请求成功的block
 *  @param failure 请求失败的block
 */
+ (void)networkingRequestPOST:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure;
/**
 *  发送GET请求,并出现成功失败提示
 *
 *  @param isWait  是否出现等待提示
 *  @param urlStr  请求的URL
 *  @param params  请求参数
 *  @param sucess  请求成功的block
 *  @param failure 请求失败的block
 */
+ (void)networkingRequestGET:(BOOL)isWait urlString:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure;
/**
 *  发送POST请求,并出现成功失败提示
 *
 *  @param isWait  是否出现等待提示
 *  @param urlStr  请求的URL
 *  @param params  请求参数
 *  @param sucess  请求成功的block
 *  @param failure 请求失败的block
 */
+ (void)networkingRequestPOST:(BOOL)isWait urlString:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure;
/**
 *  发送网络请求
 *
 *  @param isGET   是否为GET方法
 *  @param isWait  是否出现等待提示
 *  @param isShow  是否出现成功失败提示
 *  @param urlStr  请求的URL
 *  @param params  请求参数
 *  @param sucess  请求成功的block
 *  @param failure 请求失败的block
 */
+ (void)networkingRequestIsGET:(BOOL)isGET isWait:(BOOL)isWait isShowSuccessAndFailure:(BOOL)isShow urlString:(NSString *)urlStr paramaters:(NSDictionary *)params successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure;
/**
 *  发送带有文件的POST网络请求
 *
 *  @param isWait    是否出现等待提示
 *  @param isShow    是否出现成功失败提示
 *  @param urlStr    请求的URL
 *  @param params    请求参数
 *  @param dataArray 需要上传的文件数组
 *  @param sucess  请求成功的block
 *  @param failure 请求失败的block
 */
+ (void)networkingRequestPOST:(BOOL)isWait isShowSuccessAndFailure:(BOOL)isShow urlString:(NSString *)urlStr paramaters:(NSDictionary *)params fileDataArray:(NSArray *)dataArray successfulBlock:(void (^)(id data))sucess failureBlock:(void (^)(NSError *error))failure;

@end

@interface FileDataMode : NSObject

@property (strong, nonatomic)NSData *data;
@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *fileName;
@property (copy, nonatomic)NSString *mimeType;

@end
