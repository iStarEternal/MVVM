//
//  WexBaseNetCache.m
//  WeXFin
//
//  Created by Mark on 15/8/18.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexBaseNetCache.h"

__strong static id _sharedWexBaseNetCacheObject = nil;

@interface WexBaseNetCache ()

@property (nonatomic, strong) NSMutableArray* adapterArray;
@property (nonatomic) BOOL bGlobalException;

@end

@implementation WexBaseNetCache

+ (WexBaseNetCache*)getInstance {
    
    static dispatch_once_t predWexBaseNetCache = 0;
    dispatch_once(&predWexBaseNetCache, ^{
        _sharedWexBaseNetCacheObject = [[self alloc] init];
        [_sharedWexBaseNetCacheObject commonInit];
    });
    return _sharedWexBaseNetCacheObject;
}

- (void)commonInit
{
    _adapterArray = [NSMutableArray array];
    _bGlobalException = NO;
}

#pragma mark - 用于SESSION超时处理

// 压入adapter
- (void)pushAdapter:(NSObject*)adapter
{
    [_adapterArray addObject:adapter];
}

// 弹出adapter
- (void)popAdapter:(NSObject*)adapter
{
    [_adapterArray removeObject:adapter];
}

// adapter缓存是否存在
- (BOOL)isAdapterExist:(NSObject*)adapter
{
    if ([_adapterArray indexOfObject:adapter] == NSNotFound)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

// 清空adapter缓存
- (void)clearAdapterArray
{
    [_adapterArray removeAllObjects];
}

- (BOOL)isInExceptionStatus
{
    return _bGlobalException;
}

- (void)enterExceptionStatus
{
    _bGlobalException = YES;
}

- (void)leaveExceptionStatus
{
    _bGlobalException = NO;
}

@end
