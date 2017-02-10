//
//  WexNetAdapterResponseHandler.m
//  Pythia
//
//  Created by 星星 on 17/2/8.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "WexNetAdapterResponseHandler.h"
#import "AFHTTPRequestOperation.h"
//#import "WexSettingsConfig.h"

@interface WexNetAdapterResponseHandler ()

@end

@implementation WexNetAdapterResponseHandler

+ (instancetype)handler {
    return [[self alloc] init];
}

- (void)handleResponseObject:(id)responseObject {
    NSAssert(false, @"请在子类重写");
}

- (void)handleError:(NSError *)error {
    NSAssert(false, @"请在子类重写");
}

@end



@interface WexNetAdapterResponseNormalHandler ()

@end

@implementation WexNetAdapterResponseNormalHandler

- (void)handleResponseObject:(id)responseObject {
    
    
    NSError *err = nil;
    
    // 解析head
    NSDictionary *headDict = responseObject[@"head"];
    WexNetResponseHead *head = [[WexNetResponseHead alloc] initWithDictionary:headDict error:&err];
    if (err) {
        LogError(@"%@", err);
    }
    head.operation = self.requestOperation;
    head.statusCode = self.requestOperation.response.statusCode;
    // 保存服务器时间
    // [WexSettingsConfig shared].serviceDate = head.serverTime;
    
    self.head = head;
    
    // 失败
    if(self.head.status == WexNetResponseStatusFail) {
        self.body = nil;
    }
    
    // 服务器升级
    if (self.head.status == WexNetResponseStatusServerUpgrading) {
        self.head.msg = nil;
        self.body = nil;
    }
    
    // 请求超时
    else if (self.head.status == WexNetResponseStatusSessionTimeOut) {
        self.head.msg = nil;
        self.body = nil;
    }
    
    // 成功
    if (self.head.status == WexNetResponseStatusSuccess) {
        
        // 解析body
        id responseBody = [responseObject objectForKey:@"body"];
        id body = nil;
        
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            if (self.responseClass == [NSDictionary class]) {
                NSMutableDictionary *responseObj = [NSMutableDictionary dictionary];
                responseObj[@"businessCode"] = head.subCode;
                responseObj[@"businessMessage"] = head.subMsg;
                [responseObj addEntriesFromDictionary:responseBody];
                body = responseObj.copy;
            }
            else if ([self.responseClass isSubclassOfClass:[WexNetResponse class]]) {
                body = [[self.responseClass alloc] initWithDictionary:responseBody error:&err];
                [body setBusinessCode:head.subCode.integerValue];
                [body setBusinessMessage:head.subMsg];
                if (err) {
                    LogError(@"%@", err);
                }
            }
            else if ([self.responseClass isSubclassOfClass:[JSONModel class]]) {
                body = [[self.responseClass alloc] initWithDictionary:responseBody error:&err];
                if (err) {
                    LogError(@"%@", err);
                }
            }
        }
        self.body = body;
    }
}

- (void)handleError:(NSError *)error {
    
    WexNetResponseHead *head = [[WexNetResponseHead alloc] init];
    head.code = [NSString stringWithFormat:@"%ld", (long)error.code];
    head.operation = self.requestOperation;
    head.statusCode = self.requestOperation.response.statusCode;
    
    if (error.code == NSURLErrorTimedOut) {
        head.msg = @"请求超时了，请稍后重试吧";
    }
    else if (error.code == NSURLErrorNotConnectedToInternet) {
        head.msg = @"网络开了点小差，请检查您的手机是否联网哦";
    }
    else {
        head.msg = @"网络开了点小差，请稍后再试吧";
    }
    
    self.head = head;
    self.body = nil;
}

@end
