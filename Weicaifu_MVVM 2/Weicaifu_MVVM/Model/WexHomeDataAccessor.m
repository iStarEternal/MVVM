//
//  WexDataAccessor.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/19.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexHomeDataAccessor.h"

#import "WexNetAdapter.h"
#import "WexNetAdapterFactory.h"

@interface WexHomeDataAccessor ()

@end

@implementation WexHomeDataAccessor

- (void)getDataWithIndex:(NSUInteger)index
                   local:(void (^)(WexMessageEntity *))local
                 success:(void (^)(WexMessageEntity *))success
                 failure:(void (^)(NSError *))failure {
    
    WexNetAdapter *homeNetAdapter = [WexNetAdapterFactory createNetAdatperWithKey:kHomeRequestKey];
    [homeNetAdapter POSTWithSuccess:^(WexNetResponseHead *head, id response) {
        
        WexMessageEntity *testEntity = [[WexMessageEntity alloc] init];
        testEntity.success = true;
        testEntity.message = @"你好";
        testEntity.index = index;
        testEntity.title = [NSString stringWithFormat:@"第%lu页", index];
        testEntity.nextTitle = [NSString stringWithFormat:@"第%lu页", index + 1];
        
        success(testEntity);
    } failure:^(WexNetResponseHead *head) {
        
        NSError *error = head.error;
        failure(error);
    }];
    
    
    // --------------
    
    WexMessageEntity *testEntity = [[WexMessageEntity alloc] init];
    testEntity.success = true;
    testEntity.message = @"你好";
    testEntity.index = index;
    testEntity.title = [NSString stringWithFormat:@"第%lu页", index];
    testEntity.nextTitle = [NSString stringWithFormat:@"第%lu页", index + 1];
   
    // 模拟返回本地数据
    static void *f;
    if (f) {
        local(testEntity);
        f = NULL;
    }
    f = &f;
    
    // 模拟返回网络数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        success(testEntity);
    });
}





@end
