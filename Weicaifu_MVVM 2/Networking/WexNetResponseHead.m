//
//  WexNetResponseHead.m
//  WeXFin
//
//  Created by Mark on 15/7/28.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexNetResponseHead.h"

@implementation WexNetResponseHead

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return true;
}

- (WexNetResponseStatus)status {
    
    if (self.code == nil) {
        return WexNetResponseStatusUnknown;
    }
    if ([self.code isEqualToString:@"200"]) {
        return WexNetResponseStatusSuccess;
    }
    if ([self.code isEqualToString:@"1012"]) {
        return WexNetResponseStatusSessionTimeOut;
    }
    if ([self.code isEqualToString:@"503"]) {
        return WexNetResponseStatusServerUpgrading;
    }
    return WexNetResponseStatusFail;
}

- (NSString *)errorMessage {
    return self.paramErrList.firstObject.errMsg ?: self.msg;
}

@end

@implementation WexNetResponseHeadErrorInfo

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return true;
}

@end

