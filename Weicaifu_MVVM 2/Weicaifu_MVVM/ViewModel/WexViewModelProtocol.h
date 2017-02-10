//
//  WexPushViewModelDelegate.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/2/6.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WexViewModel;
@class WexViewController;


@protocol WexViewModelForViewControllerProtocol <NSObject>

@required;
@property (nonatomic, strong) WexViewController *viewController;
- (WexViewController *)createViewController;

@optional
- (UINavigationController *)makeRootViewContorller;

@end



@protocol WexViewModelNavigationService <NSObject>

@required;
- (void)pushViewModel:(WexViewModel *)viewModel animated:(BOOL)animated;
- (void)popViewModelAnimated:(BOOL)animated;
- (void)popToViewModel:(WexViewModel *)viewModel animated:(BOOL)animated;
- (void)popToRootViewModelAnimated:(BOOL)animated;

@end
