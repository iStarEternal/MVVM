//
//  WexHUD.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/7/28.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface WexHUD : NSObject


+ (void)showWaitHUD;
+ (void)showWaitHUDWithStatus:(NSString *)status;

+ (void)showErrorHUD;
+ (void)showErrorHUDWithStatus:(NSString *)status;

+ (void)showSuccessHUD;
+ (void)showSuccessHUDWithStatus:(NSString *)status;
+ (void)showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;


+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress status:(NSString *)status;

+ (void)dismiss;

+ (void)showInfo:(NSString *)info;
+ (void)showInfo:(NSString *)info duration:(NSTimeInterval)duration;

@end
