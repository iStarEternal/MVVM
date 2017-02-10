//
//  WexBaseNetCache.h
//  WeXFin
//
//  Created by Mark on 15/8/18.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>

// 统一的接口缓存
@interface WexBaseNetCache : NSObject

+ (WexBaseNetCache*)getInstance;

#pragma mark - 用于SESSION超时处理
// 压入adapter
- (void)pushAdapter:(NSObject*)adapter;
// 弹出adapter
- (void)popAdapter:(NSObject*)adapter;
// adapter缓存是否存在
- (BOOL)isAdapterExist:(NSObject*)adapter;
// 清空adapter缓存
- (void)clearAdapterArray;

// 是否处于异常状态
- (BOOL)isInExceptionStatus;
- (void)enterExceptionStatus;
- (void)leaveExceptionStatus;

@end
