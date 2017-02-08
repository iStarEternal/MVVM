//
//  TestModel.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/19.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WexMessageEntity : NSObject

@property (nonatomic, assign)   BOOL        success;
@property (nonatomic, strong)   NSString    *message;

@property (nonatomic, copy)     NSString    *title;
@property (nonatomic, copy)     NSString    *nextTitle;

@end
