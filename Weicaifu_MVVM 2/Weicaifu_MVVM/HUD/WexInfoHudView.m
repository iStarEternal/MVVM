//
//  WexInfoHudView.m
//  WeXFin
//
//  Created by Mark on 15/7/29.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexInfoHudView.h"
#import "StarExtension.h"

@interface WexInfoHudView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat duration;

@end

@implementation WexInfoHudView

+ (void)showTitle:(NSString *)title {
    NSTimeInterval duration = 0;
    if (title.length < 10) {
        duration = 1.5;
    }
    else if (title.length >= 10 && title.length < 15) {
        duration = 2.0;
    }
    else {
        duration = 3;
    }
    [self showTitle:title duration:duration];
}

+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration {
    [self showTitle:title duration:duration inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showTitle:(NSString *)title inView:(UIView *)view {
    [self showTitle:title duration:1.5 inView:view];
}

+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration inView:(UIView *)view {
    
    if ([NSString isNullOrEmpty:title]) {
        return;
    }
    if (!view) {
        return;
    }
    WexInfoHudView *hudView = [[WexInfoHudView alloc] init];
    hudView.duration = duration;
    [hudView showTitle:title inView:view];
}

- (void)showTitle:(NSString *)title inView:(UIView *)view {
    
    [view addSubview:self];
    
    // self
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];;
    
    // 设置圆角
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    
    // _titleLabel
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    
//    self.titleLabel.textColor = @"white_color".resColor;
//    self.titleLabel.font = @"label_14px_font".resFont;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.text = title;
    
    // Set autolayout
    NSDictionary *viewsDictionary = @{
                                      @"self" : self,
                                      @"titleLabel" : _titleLabel,
                                      };
    
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:[self(200)]"
                          options:0
                          metrics:nil
                          views:viewsDictionary]];
    
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:[self]-50-|"
                          options:0
                          metrics:nil
                          views:viewsDictionary]];
    
    [view addConstraint:[NSLayoutConstraint
                         constraintWithItem:self
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:NSLayoutRelationEqual
                         toItem:view
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-5-[titleLabel]-5-|"
                          options:0
                          metrics:nil
                          views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-10-[titleLabel]-10-|"
                          options:0
                          metrics:nil
                          views:viewsDictionary]];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration];
}

- (void)dismiss {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^ {
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
