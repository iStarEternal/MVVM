//
//  WexPushViewModelDelegate.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/2/6.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WexViewModel;

@protocol WexViewModelNavigationService <NSObject>

@required;
- (void)pushViewModel:(WexViewModel *)viewModel animated:(BOOL)animated;

@end



@class WexViewController;

@protocol WexViewModelProtocol <NSObject>


@required;
- (WexViewController *)createViewController;

@optional
- (UINavigationController *)makeRootViewContorller;

@end
