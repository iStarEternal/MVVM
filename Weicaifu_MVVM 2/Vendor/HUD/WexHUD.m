//
//  WexHUD.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/7/28.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexHUD.h"
#import "SVProgressHUD.h"
#import "WexInfoHudView.h"

@implementation WexHUD

+ (void)showWaitHUD {
    [self showWaitHUDWithStatus:@"客官，请稍候片刻..."];
}

+ (void)showWaitHUDWithStatus:(NSString *)status {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismiss {
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeNone)];
    [SVProgressHUD dismiss];
}

+ (void)showErrorHUD {
    [self showWaitHUDWithStatus:@"很抱歉>_<服务器开小差了..."];
}

+ (void)showErrorHUDWithStatus:(NSString *)status {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showErrorWithStatus:status];
}


+ (void)showSuccessHUD {
    [self showSuccessHUDWithStatus:@""];
}

+ (void)showSuccessHUDWithStatus:(NSString *)status {
    [self showSuccessHUDWithStatus:status maskType:SVProgressHUDMaskTypeNone];
}

+ (void)showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD showSuccessWithStatus:status];
}


+ (void)showInfo:(NSString *)info {
    [WexInfoHudView showTitle:info];
}

+ (void)showInfo:(NSString *)info duration:(NSTimeInterval)duration {
    [WexInfoHudView showTitle:info duration:duration];
}


+ (void)showProgress:(float)progress {
    [self showProgress:progress status:nil];
}

+ (void)showProgress:(float)progress status:(NSString *)status {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showProgress:progress status:status];
}


@end
