//
//  WexBaseNetAdapter.h
//  WeXFin
//
//  Created by Mark on 15/7/27.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "WexNetResponseHead.h"
#import "WexNetAdapterResponseHandler.h"


typedef enum : NSUInteger {
    WexNetAdapterStatusRun,     // 接口调用中
    WexNetAdapterStatusIdle,    // 接口空闲
} WexNetAdapterStatus;


@interface WexNetAdapter : NSObject

+ (instancetype)adapter;

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

#pragma mark - 参数

/**
 *  请求的URL，默认使用info.plist中的URLString
 */
@property (nonatomic, strong) NSString *requestURLString;

/*
 *  请求的接口路径，名称。例如：/pwd/salt，默认值：@""空白字符串
 */
@property (nonatomic, copy) NSString *requestPath;

/**
 *  接口超时时间，默认值：60.0
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  参数，默认值：nil
 */
@property (nonatomic, strong) NSDictionary *parameters;

/**
 *  参数，默认值：nil
 */
@property (nonatomic, strong) __kindof JSONModel *parameterModel;

/**
 *  当前接口的状态
 */
@property (nonatomic, assign) WexNetAdapterStatus status;

/**
 *  响应对象处理器，默认值：WexNetAdapterResponseNormalHandler
 */
@property (nonatomic, strong) WexNetAdapterResponseHandler *responseHandler;

/**
 *  响应对象类型，默认值：[NSDictionary class]
 */
@property (nonatomic, strong) Class responseClass;


#pragma mark - 调用接口
typedef void (^WexAdapterSuccess)(WexNetResponseHead *head, id response);
typedef void (^WexAdapterFailure)(WexNetResponseHead *head);

typedef void (^WexAdapterDownloadProgress)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);
typedef void (^WexAdapterDownloadSuccess)(WexNetResponseHead *head, NSData *fileData);

/**
 *  适配器POST
 *
 *  @param parameterModel 参数 JSONModel对象
 *  @param success        请求成功
 *  @param failure        请求失败，包括微财富StatusCode != 100, HttpStatusCode not in Success area
 *
 *  @return x
 */
- (AFHTTPRequestOperation *)POSTWithParameterModel:(JSONModel *)parameterModel success:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure;

/**
 *  适配器POST
 *
 *  @param parameters 参数 @{ @"": @"" }
 *  @param success    请求成功
 *  @param failure    请求失败，直接返回
 *
 *  @return x
 */
- (AFHTTPRequestOperation *)POSTWithParameters:(NSDictionary *)parameters success:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure;

/**
 *  适配器POST 放弃返回值
 */
- (AFHTTPRequestOperation *)POST;

/**
 *  适配器POST
 *
 *  @param success    请求成功
 *  @param failure    请求失败，直接返回
 *
 *  @return x
 */
- (AFHTTPRequestOperation *)POSTWithSuccess:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure;


/**
 GET请求

 @param success 请求成功
 @param failure 请求失败
 @return x
 */
- (AFHTTPRequestOperation *)GETWithSuccess:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure;

/**
 *  下载
 *
 *  @param progressBlock 下载进度
 *  @param success       下载成功
 *  @param failure       下载失败
 *
 *  @return x
 */
- (AFHTTPRequestOperation *)downloadWithProgressBlock:(WexAdapterDownloadProgress)progressBlock success:(WexAdapterDownloadSuccess)success failure:(WexAdapterFailure)failure;

/**
 *  取消当前队列的任务
 */
- (void)cancelAllOperations;



#pragma mark - URL

+ (NSString *)defaultRequestURLString;


#pragma mark - Cookies相关（用于恢复登录状态）

/// 保存Cookies
+ (void)saveNetCookies;
/// 恢复Cookies
+ (void)restoreNetCookies;
/// 删除保存的Cookies
+ (void)deleteSavedNetCookies;


#pragma mark - 其他

/// 服务器时间
+ (NSDate *)serviceDate;

@end
