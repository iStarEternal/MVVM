//
//  UIViewController+HUD.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/3.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexViewModel+HUD.h"

@implementation WexViewModel (HUD)



#pragma mark - HUD

- (void)showWaitHUD {
    [WexHUD showWaitHUD];
}

- (void)showWaitHUDWithStatus:(NSString *)status {
    [WexHUD showWaitHUDWithStatus:status];
}


- (void)showErrorHUD {
    [WexHUD showErrorHUD];
}

- (void)showErrorHUDWithStatus:(NSString *)status {
    [WexHUD showErrorHUDWithStatus:status];
}


- (void)showSuccessHUD {
    [WexHUD showSuccessHUD];
}

- (void)showSuccessHUDWithStatus:(NSString *)status {
    [WexHUD showSuccessHUDWithStatus:status];
}

- (void)showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [WexHUD showSuccessHUDWithStatus:status maskType:maskType];
}


- (void)dismissHUD {
    [WexHUD dismiss];
}


#pragma mark - Info

- (void)showInfo:(NSString *)info {
    [WexHUD showInfo:info];
}

- (void)showInfo:(NSString *)info duration:(NSTimeInterval)duration {
    [WexHUD showInfo:info duration:duration];
}


@end
