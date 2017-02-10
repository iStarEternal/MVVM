//
//  WexInfoHudView.h
//  WeXFin
//
//  Created by Mark on 15/7/29.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

// 浮层提示
@interface WexInfoHudView : UIView

+ (void)showTitle:(NSString *)title;

+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration;

//+ (void)showTitle:(NSString *)title inView:(UIView *)view;

//+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration inView:(UIView *)view;

//- (void)showTitle:(NSString *)title inView:(UIView *)view;

@end
