//
//  WexNetResponse.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/8.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "JSONModel.h"

@interface WexNetResponse : JSONModel

@property (nonatomic, assign) NSInteger businessCode;
@property (nonatomic, copy) NSString * businessMessage;

@end
