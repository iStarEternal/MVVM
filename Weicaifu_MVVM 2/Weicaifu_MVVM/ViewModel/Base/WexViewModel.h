//
//  WexViewModel.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WexViewModelProtocol.h"

@class WexViewModel;

@protocol WexViewModelDelegate <NSObject>

@required

@end


@interface WexViewModel : NSObject

/**
 跳转服务
 */
@property (nonatomic, weak) id<WexViewModelNavigationService> navigationService;

/**
 ViewModel代理
 */
@property (nonatomic, weak) id<WexViewModelDelegate> delegate;


@property (nonatomic, weak, readonly) UINavigationItem *navigationItem;
@property (nonatomic, weak, readonly) UIView *view;


- (void)viewDidLoad;

- (void)handleNavigationItem:(UINavigationItem *)navigationItem;
- (void)handleView:(UIView *)view;


@end
