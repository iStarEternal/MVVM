//
//  WexDataAccessor.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/19.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexDataAccessor.h"


static NSUInteger titleIndex = 0;

@implementation WexDataAccessor

- (void)getDataWithLocal:(void (^)(WexMessageEntity *))local success:(void (^)(WexMessageEntity *))success failure:(void (^)(NSError *))failure {
    
    titleIndex ++;
    
    static WexMessageEntity *testEntity = nil;
    
    // 返回本地数据
    if (testEntity) {
        local(testEntity);
    }
    
    
    testEntity = [[WexMessageEntity alloc] init];
    testEntity.success = true;
    testEntity.message = @"你好";
    testEntity.title = [NSString stringWithFormat:@"第%lu页", titleIndex];
    testEntity.nextTitle = [NSString stringWithFormat:@"第%lu页", titleIndex + 1];
    
    
    // 返回网络数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        success(testEntity);
    });
}

@end
