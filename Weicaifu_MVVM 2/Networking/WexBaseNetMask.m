//
//  WexBaseNetMask.m
//  WeXFin
//
//  Created by Mark on 15/9/22.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexBaseNetMask.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

static void _maskDict(NSMutableDictionary* dict, NSString* value);
static NSString* _maskValue(NSString* value);
static NSMutableString* _sortedParamString(NSMutableDictionary* dict);
static NSMutableString* _sha2Hex(unsigned char* sha, NSInteger length);

static void _maskDict(NSMutableDictionary* dict, NSString* value)
{
    NSString* middleValue = _maskValue(value);

    // 生成参数序列
    NSMutableString* paramString = _sortedParamString(dict);

    // 将id加密生成的key直接拼接在拼接好的参数串末尾
    [paramString appendString:middleValue];

    // MD5
    const char* pwdMessage = [paramString cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char md5[CC_MD5_DIGEST_LENGTH]; // 16
    CC_MD5((unsigned char*)pwdMessage, (CC_LONG)strlen(pwdMessage), md5);

    NSMutableString* md5Str = _sha2Hex(md5, CC_MD5_DIGEST_LENGTH);

    [dict setObject:md5Str forKey:@"sign"];
}

static NSString* _maskValue(NSString* value)
{
    // 大写
    NSString* uppercaseValue = [value uppercaseString];

    const char* valueArray = [uppercaseValue cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger length = [uppercaseValue length];
    char newValueArray[50] = {0};

    // 变更内容
    for (int i = 0; i < length; i++)
    {
        // 数字转换为小写字母+2
        if (valueArray[i] >= '0' && valueArray[i] <= '9')
        {
            newValueArray[i] = (char) ('c' - '0' + valueArray[i]);
        }
        // A-F大小字母+3
        else if (valueArray[i] >= 'A' && valueArray[i] <= 'F')
        {
            newValueArray[i] = (char) (valueArray[i] + 3);
        }
        // G-Z大写字母-1
        else if (valueArray[i] >= 'G' && valueArray[i] <= 'Z')
        {
            newValueArray[i] = (char) (valueArray[i] - 1);
        }
    }

    // 移位
    if (length >= 3)
    {
        // 第一位和最后一位
        char tmp = newValueArray[0];
        newValueArray[0] = newValueArray[length - 1];
        newValueArray[length - 1] = tmp;

        // 第二位和最后第三位
        tmp = newValueArray[1];
        newValueArray[1] = newValueArray[length - 3];
        newValueArray[length - 3] = tmp;

        // 第三位和最后第二位
        tmp = newValueArray[2];
        newValueArray[2] = newValueArray[length - 2];
        newValueArray[length - 2] = tmp;
    }

    NSString* middleValue = [[NSString alloc] initWithCString:newValueArray encoding:NSASCIIStringEncoding];

    return middleValue;
}

static NSMutableString* _sortedParamString(NSMutableDictionary* dict)
{
    // 将所有的NSNull处理为空字符串
    for (NSString* key in dict.allKeys)
    {
        NSString* value = [dict objectForKey:key];
        
        if ([value isKindOfClass:[NSNull class]])
        {
            [dict setObject:@"" forKey:key];
        }
    }
    
    // Keys排序
    NSArray* keys = [dict allKeys];
    NSArray* sortedKeysArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
                                {
                                    return [obj1 compare:obj2 options:NSNumericSearch];
                                }];

    // 连接
    NSMutableString* paramString = [NSMutableString stringWithString:@""];

    for (int index = 0; index < sortedKeysArray.count; ++index)
    {
        NSString* key = sortedKeysArray[index];

        if (sortedKeysArray.count == 1)
        {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@", key, [dict objectForKey:key]]];
        }
        else if (index == sortedKeysArray.count - 1)
        {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@", key, [dict objectForKey:key]]];
        }
        else
        {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@&", key, [dict objectForKey:key]]];
        }
    }

    return paramString;
}

static NSMutableString* _sha2Hex(unsigned char* sha, NSInteger length)
{
    NSMutableString* shaStr = [[NSMutableString alloc] init];

    for (NSInteger index = 0; index < length; ++index)
    {
        [shaStr appendFormat:@"%02x", sha[index]];
    }

    return shaStr;
}


@implementation _WexBaseNetMask

static WexBaseNetMask_t * _sharedMask = NULL;

+ (WexBaseNetMask_t*)sharedMask
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMask = malloc(sizeof(WexBaseNetMask_t));
        _sharedMask->maskDict = _maskDict;
    });
    return _sharedMask;
}

+ (void)destroy
{
    _sharedMask ? free(_sharedMask): 0;
    _sharedMask = NULL;
}

@end
