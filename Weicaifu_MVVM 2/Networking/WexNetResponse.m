//
//  WexNetResponse.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/8.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexNetResponse.h"

@implementation WexNetResponse

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return true;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"businessCode"]) {
        return true;
    }
    
    if ([propertyName isEqualToString:@"businessMessage"]) {
        return true;
    }
    return false;
}

@end
