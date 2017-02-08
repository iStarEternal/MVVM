//
//  WexFirstViewModel.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/17.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexFirstDataController.h"

#import "WexDataAccessor.h"


@interface WexFirstDataController ()

@end

@implementation WexFirstDataController


#pragma mark - 加载数据

- (void)firstViewModel:(WexFirstViewModel *)firstViewModel loadDataWithComplete:(void (^)(WexMessageEntity *, NSError *))complete {
    
    WexDataAccessor *dataAccessor = [[WexDataAccessor alloc] init];
    
    [dataAccessor
     getDataWithLocal:^(WexMessageEntity *data) {
         complete(data, nil);
     }
     success:^(WexMessageEntity *data) {
         complete(data, nil);
     }
     failure:^(NSError *error) {
         complete(nil, error);
     }];
}

- (void)firstViewModel:(WexFirstViewModel *)firstViewModel submitWithArg1:(NSString *)arg1 complete:(void (^)(NSError *))complete {
    complete(nil);
}

@end
