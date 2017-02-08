//
//  UIViewController+HUD.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/3.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WexHUD.h"
#import "WexInfoHudView.h"

@interface UIViewController (HUD)

#pragma mark - HUD

- (void)showWaitHUD;
- (void)showWaitHUDWithStatus:(NSString *)status;

- (void)showErrorHUD;
- (void)showErrorHUDWithStatus:(NSString *)status;

- (void)showSuccessHUD;
- (void)showSuccessHUDWithStatus:(NSString *)status;
- (void)showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;

- (void)dismissHUD;


#pragma mark - Info

- (void)showInfo:(NSString *)info;
- (void)showInfo:(NSString *)info duration:(NSTimeInterval)duration;

@end
