//
//  WexDataAccessor.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/19.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WexMessageEntity.h"

@interface WexHomeDataAccessor : NSObject

- (void)getDataWithIndex:(NSUInteger)index
                   local:(void (^)(WexMessageEntity *data))local
                 success:(void (^)(WexMessageEntity *data))success
                 failure:(void (^)(NSError *error))failure;

@end
