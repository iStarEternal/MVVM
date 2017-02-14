//
//  WexBaseNetAdapter.m
//  WeXFin
//
//  Created by Mark on 15/7/27.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexNetAdapter.h"
#import "WexBaseNetCache.h"

#import "WexNetAdapterResponseHandler.h"

#define WEX_NET_COOKIES_ARRAY @"WEX_NET_COOKIES_ARRAY"

@interface WexNetAdapter () {}

@end

@implementation WexNetAdapter


#pragma mark -

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _status = WexNetAdapterStatusIdle;
        
        _requestPath = @"";
        _requestURLString = [WexNetAdapter defaultRequestURLString];
        _timeoutInterval = 60.0;
        
        _responseHandler = [WexNetAdapterResponseNormalHandler handler];
        self.responseClass = [NSDictionary class];
        
    }
    return self;
}

+ (instancetype)adapter {
    return [[self alloc] init];
}



#pragma mark - Getter & Setter

- (AFHTTPRequestOperationManager *)requestManager {
    if (_requestManager == nil) {
        _requestManager = [AFHTTPRequestOperationManager manager];
    }
    return _requestManager;
}

- (Class)responseClass {
    return self.responseHandler.responseClass;
}

- (void)setResponseClass:(Class)responseClass {
    self.responseHandler.responseClass = responseClass;
}

// 获取参数
- (NSDictionary *)getParamsters {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSDictionary *staticParameters = [self getStaticParameters];
    [parameters addEntriesFromDictionary:staticParameters];
    
    if (self.parameters) {
        [parameters addEntriesFromDictionary:self.parameters];
    }
    
    if (self.parameterModel) {
        [parameters addEntriesFromDictionary:[self.parameterModel toDictionary]];
    }
    
    return [parameters copy];
}

// 静态参数
- (NSDictionary *)getStaticParameters {
    
    NSMutableDictionary *staticParameters = [NSMutableDictionary dictionary];
    
//    NSString *deviceIdentifier = [WexApplicationInfo uniqueDeviceIdentifier];
//    
//    // 默认参数
//    // 应用版本
//    [staticParameters setObject:[WexApplicationInfo appVersion] forKey:@"version"];
//    // 应用平台 1 iphone 2 android
//    [staticParameters setObject:@"1" forKey:@"platformType"];
//    // 应用类别 1 app
//    [staticParameters setObject:@"1" forKey:@"appType"];
//    // 设备唯一标识
//    [staticParameters setObject:deviceIdentifier forKey:@"deviceIdentify"];
//    // 客户端请求时间 客户端使用从1970-1-1 00:00:00到现在的毫秒数
//    [staticParameters setObject:[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"reqTime"];
//    // 本地化信息 目前客户端填写zh_CN, 目前的处理方法是,无论客户端填写什么都转成zh_CN
//    [staticParameters setObject:@"zh_CN" forKey:@"locale"];
//    // app下载渠道id
//    [staticParameters setObject:@"20" forKey:@"channelId"];
//    // 当前设备IP地址
//    [staticParameters setObject:[WexApplicationInfo IPAddress] forKey:@"clientIp"];
    
    return [staticParameters copy];
}



#pragma mark - POST

- (AFHTTPRequestOperation *)POSTWithSuccess:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure {
    
    LogBackTrace(@"POST调用堆栈");
    
    self.status = WexNetAdapterStatusRun;
    
    [self postRequestStartNotification];
    
    // 将adapter缓存起来，用于后面处理SESSION超时异常
    [[WexBaseNetCache getInstance] pushAdapter:self];
    
    NSString *URLString = [self.requestURLString stringByAppendingPathComponent:self.requestPath];
    NSString *requestPath = self.requestPath;
    NSDictionary *POSTParameters = [self getParamsters];
    NSTimeInterval timeoutInterval = self.timeoutInterval;
    
    LogWarning(@"\n适配器链接: [%@.m:0]", NSStringFromClass([self class]));
    LogWarning(@"URL地址:%@ ", URLString);
    LogWarning(@"\n请求接口:%@ \nPOST Parameters: %@", requestPath, POSTParameters);
    
    self.requestManager.requestSerializer.timeoutInterval = timeoutInterval;
    return [self.requestManager POST:URLString parameters:POSTParameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        LogSuccess(@"\n请求成功\n地址: %@\n参数: %@\nResponse: %@", URLString, requestPath, responseObject);
        [self postRequestOverNotification];
        [self POSTSuccessFinish:operation response:responseObject success:success failure:failure];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        LogFailure(@"\n请求失败\n地址: %@\n参数: %@\nError: %@", URLString, requestPath, error);
        [self postRequestOverNotification];
        [self POSTFailureFinish:operation error:error failureBlock:failure];
    }];
}

- (AFHTTPRequestOperation *)POSTWithParameterModel:(JSONModel *)parameterModel success:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure {
    
    self.parameterModel = parameterModel;
    return [self POSTWithSuccess:success failure:failure];
}

- (AFHTTPRequestOperation *)POSTWithParameters:(NSDictionary *)parameters success:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure {
    
    self.parameters = parameters;
    return [self POSTWithSuccess:success failure:failure];
}

- (AFHTTPRequestOperation *)POST {
    return [self POSTWithSuccess:NULL failure:NULL];
}


#pragma mark - GET

- (AFHTTPRequestOperation *)GETWithSuccess:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure {
    
    LogBackTrace(@"GET调用堆栈");
    
    self.status = WexNetAdapterStatusRun;
    
    [self postRequestStartNotification];
    
    // 将adapter缓存起来，用于后面处理SESSION超时异常
    [[WexBaseNetCache getInstance] pushAdapter:self];
    
    NSString *URLString = [self.requestURLString stringByAppendingPathComponent:self.requestPath];
    NSString *requestPath = self.requestPath;
    NSDictionary *POSTParameters = [self getParamsters];
    NSTimeInterval timeoutInterval = self.timeoutInterval;
    
    LogWarning(@"\n适配器链接: [%@.m:0]", NSStringFromClass([self class]));
    LogWarning(@"URL地址:%@ ", URLString);
    LogWarning(@"\n请求接口:%@ \nPOST Parameters: %@", requestPath, POSTParameters);
    
    self.requestManager.requestSerializer.timeoutInterval = timeoutInterval;
    return [self.requestManager GET:URLString parameters:POSTParameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        LogSuccess(@"\n请求成功\n地址: %@\n参数: %@\nResponse: %@", URLString, requestPath, responseObject);
        [self postRequestOverNotification];
        [self POSTSuccessFinish:operation response:responseObject success:success failure:failure];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        LogFailure(@"\n请求失败\n地址: %@\n参数: %@\nError: %@", URLString, requestPath, error);
        [self postRequestOverNotification];
        [self POSTFailureFinish:operation error:error failureBlock:failure];
    }];
}


#pragma mark 处理返回结果

- (void)POSTSuccessFinish:(AFHTTPRequestOperation *)operation response:(id)responseObject success:(WexAdapterSuccess)success failure:(WexAdapterFailure)failure {
    
    self.status = WexNetAdapterStatusIdle;
    
    if (false == [[WexBaseNetCache getInstance] isAdapterExist:self]) {
        // 该adapter因为SESSION超时已被清空
        // 1. 防止重入
        // 2. 截断此前已提交的所有接口
        return;
    }
    
    // 处理返回结果
    self.responseHandler.requestOperation = operation;
    [self.responseHandler handleResponseObject:responseObject];
    
    WexNetResponseHead *head = self.responseHandler.head;
    
    // 服务器升级
    if (head.status == WexNetResponseStatusServerUpgrading) {
        [self postServerUpgradingNotificationWithMessage:head.errorMessage];
    }
    else {
        [self postServerNormalNotification];
    }
    
    // 成功状态
    if (head.status == WexNetResponseStatusSuccess) {
        // 进入正常状态标记
        [[WexBaseNetCache getInstance] leaveExceptionStatus];
        // 将缓存的adapter释放
        [[WexBaseNetCache getInstance] popAdapter:self];
        
        id body = self.responseHandler.body;
        if (success) {
            success(head, body);
        }
        return;
    }
    // 超时状态
    else if (head.status == WexNetResponseStatusSessionTimeOut) {
        
        // 截断此前已提交的所有接口
        [[WexBaseNetCache getInstance] clearAdapterArray];
        // 防止后续接口的重入-另一种重入
        if ([[WexBaseNetCache getInstance] isInExceptionStatus]) {
            LogInfo(@"Avoid in Exception: %@", self);
        }
        else {
            [[WexBaseNetCache getInstance] enterExceptionStatus];
            // 在iOS7某些版本中因为接口结束有动画，会导致后续的登录页面无法压入，这边延后一点以避免这个问题
            [self performSelector:@selector(postSessionTimeoutNotification) withObject:nil afterDelay:0.3];
        }
    }
    // 失败状态
    if(head.status == WexNetResponseStatusFail) {
        // 进入正常状态标记
        [[WexBaseNetCache getInstance] leaveExceptionStatus];
    }
    // 接口调用情况不明
    else {
        LogError(@"接口调用情况不明%@", head.code);
    }
    
    // 将缓存的adapter释放
    [[WexBaseNetCache getInstance] popAdapter:self];
    
    // 回调
    if (failure) {
        failure(head);
    }
}

- (void)POSTFailureFinish:(AFHTTPRequestOperation *)operation error:(NSError *)error failureBlock:(WexAdapterFailure)failure {
    
    self.status = WexNetAdapterStatusIdle;
    
    if (false == [[WexBaseNetCache getInstance] isAdapterExist:self]) {
        // 该adapter因为SESSION超时已被清空
        // 1. 防止重入
        // 2. 截断此前已提交的所有接口
        return;
    }
    
    // 处理错误
    self.responseHandler.requestOperation = operation;
    [self.responseHandler handleError:error];
    
    WexNetResponseHead *head = self.responseHandler.head;
    
    // 将缓存的adapter释放
    [[WexBaseNetCache getInstance] popAdapter:self];
    
    // 回调
    if (failure) {
        failure(head);
    }
}




#pragma mark - Download

- (AFHTTPRequestOperation *)downloadWithProgressBlock:(WexAdapterDownloadProgress)progressBlock success:(WexAdapterDownloadSuccess)success failure:(WexAdapterFailure)failure {
    
    LogBackTrace(@"POST调用堆栈");
    
    self.status = WexNetAdapterStatusRun;
    
    // 将adapter缓存起来，用于后面处理SESSION超时异常
    [[WexBaseNetCache getInstance] pushAdapter:self];
    
    NSString *URLString = self.requestURLString;
    NSString *requestPath = self.requestPath;
    NSDictionary *POSTParameters = [self getParamsters];
    NSTimeInterval timeoutInterval = self.timeoutInterval;
    
    LogWarning(@"\n适配器链接: [%@.m:0]", NSStringFromClass([self class]));
    LogWarning(@"URL地址:%@ ", URLString);
    LogWarning(@"\n请求接口:%@ \nPOST Parameters: %@", requestPath, POSTParameters);
    
    self.requestManager.requestSerializer.timeoutInterval = timeoutInterval;
    self.requestManager.responseSerializer = [AFCompoundResponseSerializer serializer];
    AFHTTPRequestOperation *operation = [self.requestManager POST:URLString parameters:POSTParameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *contentType = operation.response.allHeaderFields[@"Content-Type"];
        if ([contentType isEqualToString:@"application/json"]) {
            LogSuccess(@"\n请求成功\n地址: %@\n参数: %@\nResponse: %@", URLString, requestPath, responseObject);
            [self POSTSuccessFinish:operation response:responseObject success:nil failure:failure];
        }
        else if ([contentType isEqualToString:@"application/pdf"]){
            LogSuccess(@"\n下载成功\n地址: %@\n参数: %@\n", URLString, requestPath);
            [self downloadFinish:operation response:responseObject success:success failure:failure];
        }
        else {
            LogSuccess(@"\n下载成功\n地址: %@\n参数: %@\n", URLString, requestPath);
            [self downloadFinish:operation response:responseObject success:success failure:failure];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        LogFailure(@"\n请求失败\n地址: %@\n参数: %@\nError: %@", URLString, requestPath, error);
        [self POSTFailureFinish:operation error:error failureBlock:failure];
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if (progressBlock) {
            progressBlock(bytesRead, totalBytesRead, totalBytesExpectedToRead);
        }
    }];
    return operation;
}


#pragma mark 处理返回结果

- (void)downloadFinish:(AFHTTPRequestOperation *)operation response:(id)responseObject success:(WexAdapterDownloadSuccess)success failure:(WexAdapterFailure)failure {
    
    self.status = WexNetAdapterStatusIdle;
    
    [[WexBaseNetCache getInstance] popAdapter:self];
    
    WexNetResponseHead *head = [[WexNetResponseHead alloc] init];
    
    if (![responseObject isKindOfClass:[NSData class]]) {
        head.code = @"-999";
        head.msg = @"网络请求异常";
        if (failure) {
            failure(head);
        }
    }
    else {
        head.code = @"100";
        head.msg = @"OK";
        if (success) {
            success(head, responseObject);
        }
    }
    
}


#pragma mark - 操作

- (void)cancelAllOperations {
    [self.requestManager.operationQueue cancelAllOperations];
}


#pragma mark - 通知

// 请求开始
- (void)postRequestStartNotification {
    // 目前用于手势密码弹出，在有接口调用时后延
//    [[NSNotificationCenter defaultCenter] postNotificationName:WEX_NET_ADAPTER_START_NOTIFY object:nil userInfo:nil];
}
// 请求结束
- (void)postRequestOverNotification {
    // 目前用于手势密码弹出，在有接口调用时后延
//    [[NSNotificationCenter defaultCenter] postNotificationName:WEX_NET_ADAPTER_END_NOTIFY object:nil userInfo:nil];
}
// Session过期
- (void)postSessionTimeoutNotification {
//    [[NSNotificationCenter defaultCenter] postNotificationName:WEX_NET_SESSION_TIMEOUT_NOTIFY object:nil userInfo:nil];
}
// 服务器升级
- (void)postServerUpgradingNotificationWithMessage:(NSString *)message {
    NSDictionary *info = @{@"message": message};
//    [[NSNotificationCenter defaultCenter] postNotificationName:WEX_NET_ADAPTER_SERVER_UPGRADING_NOTIFICATION object:nil userInfo:info];
}
// 服务器正常
- (void)postServerNormalNotification {
//    [[NSNotificationCenter defaultCenter] postNotificationName:WEX_NET_ADAPTER_SERVER_NORMAL_NOTIFICATION object:nil userInfo:nil];
}



#pragma mark - URL

// 当前URL
+ (NSString *)defaultRequestURLString {
    
    NSMutableString* url = nil;
#if WEX_TEST_SERVER == 1 // 测试环境
    url = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"WexServiceTestName"]];
#elif WEX_DEVELOP_SERVER == 1 // 开发环境
    url = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"WexServiceDevelopName"]];
#else // 生产环境
    url = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"WexServiceDistributeName"]];
#endif
    
    return url;
}


#pragma mark - Cookies相关（用于恢复登录状态）

// 保存Cookies
+ (void)saveNetCookies {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* cookies = cookieStorage.cookies;
    
    // 将cookie值转为Data数据保存
    NSMutableArray *dataCookieArray = [[NSMutableArray alloc] init];
    
    for (NSHTTPCookie *cookie in cookies) {
        NSDictionary *dic = [cookie properties];
        [dataCookieArray addObject:dic];
    }
    
    [userDefaults setObject:dataCookieArray forKey:WEX_NET_COOKIES_ARRAY];
    
    [userDefaults synchronize];
}
// 恢复Cookies
+ (void)restoreNetCookies {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* cookies = [userDefaults objectForKey:WEX_NET_COOKIES_ARRAY];
    
    if (cookies && [cookies count] > 0) {
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        for (NSDictionary *dict in cookies) {
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dict];
            [cookieStorage setCookie:cookie];
        }
    }
}
// 删除保存的Cookies
+ (void)deleteSavedNetCookies {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:WEX_NET_COOKIES_ARRAY];
    
    [userDefaults synchronize];
    
    
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        [cookieStorage deleteCookie:cookie];
    }
    
}

// 服务器时间
+ (NSDate *)serviceDate {
    return nil;
//    return [NSDate dateWithTimeIntervalSince1970:([WexSettingsConfig shared].serviceDate.integerValue / 1000.)];
}
@end
