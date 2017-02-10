//
//  WexFirstViewModel.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/17.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexFirstDataController.h"

#import "WexHomeDataAccessor.h"


@interface WexFirstDataController ()

@end

@implementation WexFirstDataController


#pragma mark - 加载数据

- (void)firstViewModel:(WexFirstViewModel *)firstViewModel
     loadDataWithIndex:(NSUInteger)index
              complete:(void (^)(WexMessageEntity *, NSError *))complete {
    
    WexHomeDataAccessor *dataAccessor = [[WexHomeDataAccessor alloc] init];
    
    [dataAccessor
     getDataWithIndex:index
     local:^(WexMessageEntity *data) {
         
         
         // 逻辑处理在这里做
         complete(data, nil);
     }
     success:^(WexMessageEntity *data) {
         complete(data, nil);
     }
     failure:^(NSError *error) {
         // 
         complete(nil, error);
     }];
}

- (void)firstViewModel:(WexFirstViewModel *)firstViewModel submitWithArg1:(NSString *)arg1 complete:(void (^)(NSError *))complete {
    complete(nil);
}

@end
