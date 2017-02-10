//
//  WexNetResponseHead.h
//  WeXFin
//
//  Created by Mark on 15/7/28.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "JSONModel.h"


#pragma mark - WexNetResponseHead
#pragma mark

typedef NS_ENUM(NSInteger, WexNetResponseStatus){
    WexNetResponseStatusUnknown,
    WexNetResponseStatusSuccess,
    WexNetResponseStatusFail,
    WexNetResponseStatusSessionTimeOut,
    WexNetResponseStatusServerUpgrading,
};


@class AFHTTPRequestOperation;
@class WexNetResponseHeadErrorInfo;
@protocol WexNetResponseHeadErrorInfo;

@interface WexNetResponseHead : JSONModel

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *msg;

@property (nonatomic, strong) NSString *subCode;
@property (nonatomic, strong) NSString *subMsg;

@property (nonatomic, strong) NSString *serverTime;
@property (nonatomic, strong) NSArray<WexNetResponseHeadErrorInfo *><WexNetResponseHeadErrorInfo> *paramErrList;

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSError<Ignore> *error;
@property (nonatomic, strong) AFHTTPRequestOperation<Ignore> *operation;

@property (nonatomic, assign, readonly) WexNetResponseStatus status;

@property (nonatomic, assign, readonly) NSString *errorMessage;

@end

@interface WexNetResponseHeadErrorInfo : JSONModel

@property (nonatomic, strong) NSString *paramName;
@property (nonatomic, strong) NSString *errMsg;

@end



