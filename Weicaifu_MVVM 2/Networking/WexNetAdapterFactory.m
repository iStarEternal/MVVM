//
//  WexNetAdapterFactory.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/2/10.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNetAdapterFactory.h"
#import "WexNetAdapter.h"


NSString * const kHomeRequestKey = @"kHomeRequestKey";
NSString * const kLoginRequestKey = @"kLoginRequestKey";



@implementation WexNetAdapterFactory


+ (NSMutableDictionary *)cache {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NSMutableDictionary alloc] init];
    });
    return instance;
}

+ (WexNetAdapter *)createNetAdatperWithKey:(NSString *)key {
    
    if (!key || [key isEqualToString:@""]) {
        return nil;
    }
    
    if (!self.cache[key]) {
        WexNetAdapter *netAdapter = self.createNetAdatper;
        netAdapter.requestPath = self.requestPathMapping[key] ?: @"";
        netAdapter.responseClass = self.responseClassMapping[key] ?: [NSDictionary class];
        self.cache[key] = netAdapter;
    }
    return self.cache[key];
}

+ (WexNetAdapter *)createNetAdatper {
    return [[WexNetAdapter alloc] init];
}

+ (NSDictionary *)requestPathMapping {
    return @{
             kHomeRequestKey : @"/asset/overview",
             kLoginRequestKey : @"/login/do",
             };
}

+ (NSDictionary *)responseClassMapping {
    return @{
             kHomeRequestKey : [NSDictionary class],
             kLoginRequestKey : [NSDictionary class]
             };
}

@end

