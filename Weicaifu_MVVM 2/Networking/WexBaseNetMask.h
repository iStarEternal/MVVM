//
//  WexBaseNetMask.h
//  WeXFin
//
//  Created by Mark on 15/9/22.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>

// 安全防范措施，参考http://blog.csdn.net/yiyaaixuexi/article/details/29210413
// 一种改写为C的方式
typedef struct _WexBaseNetMask
{
    void (*maskDict)(NSMutableDictionary* dict, NSString* value);
}WexBaseNetMask_t;

#define WexBaseNetMask ([_WexBaseNetMask sharedMask])

// 用于接口签名
@interface _WexBaseNetMask : NSObject

+ (WexBaseNetMask_t*)sharedMask;

@end
