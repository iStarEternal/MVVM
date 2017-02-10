//
//  WexNetAdapterResponseHandler.h
//  Pythia
//
//  Created by 星星 on 17/2/8.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WexNetResponseHead.h"
#import "WexNetResponse.h"

@interface WexNetAdapterResponseHandler : NSObject

+ (instancetype)handler;

@property (nonatomic, strong) Class responseClass;
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;

@property (nonatomic, strong) WexNetResponseHead *head;
@property (nonatomic, strong) id body;

- (void)handleResponseObject:(id)responseObject;
- (void)handleError:(NSError *)error;

@end


@interface WexNetAdapterResponseNormalHandler : WexNetAdapterResponseHandler

@end
