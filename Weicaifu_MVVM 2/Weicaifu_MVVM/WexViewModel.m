//
//  WexViewModel.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexViewModel.h"

@implementation WexViewModel

- (void)handleNavigationItem:(UINavigationItem *)navigationItem {
    _navigationItem = navigationItem;
}

- (void)handleView:(UIView *)view {
    _view = view;
}

- (void)viewDidLoad {
    // ...
}

@end
