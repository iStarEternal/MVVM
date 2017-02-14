//
//  WexNetAdapterFactory.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/2/10.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WexNetAdapter.h"

extern NSString * const kHomeRequestKey;
extern NSString * const kLoginRequestKey;

/// 网络访问适配器工厂
@interface WexNetAdapterFactory : NSObject

+ (WexNetAdapter *)createNetAdatperWithKey:(NSString *)key;

@end
