//
//  WexViewController.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexViewController.h"
#import <objc/runtime.h>

@interface WexViewController ()

@end

@implementation WexViewController

- (instancetype)initWithViewModel:(WexViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _viewModel.navigationService = self;
        
        _dataController = [[[self dataControllerClass] alloc] init];
        _viewModel.delegate = _dataController;
    }
    return self;
}

- (Class)dataControllerClass {
    return [WexDataController class];
}


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel handleNavigationItem:self.navigationItem];
    [self.viewModel handleView:self.view];
    
    [self.viewModel viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 跳转实现

- (void)pushViewModel:(WexViewModel *)viewModel animated:(BOOL)animated {
    WexViewController *viewController = [viewModel createViewController];
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)popViewModelAnimated:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToViewModel:(WexViewModel *)viewModel animated:(BOOL)animated {
    WexViewController *viewController = viewModel.viewController;
    [self.navigationController popToViewController:viewController animated:animated];
}

- (void)popToRootViewModelAnimated:(BOOL)animated {
    [self.navigationController popToRootViewControllerAnimated:animated];
}

@end


@implementation WexViewModel (CreateViewController)

static const void * ViewControllerKey = &ViewControllerKey;

- (WexViewController *)viewController {
    return objc_getAssociatedObject(self, ViewControllerKey);
}

- (void)setViewController:(WexViewController *)viewController {
    objc_setAssociatedObject(self, ViewControllerKey, viewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WexViewController *)createViewController {
    self.viewController = [[WexViewController alloc] initWithViewModel:self];
    return self.viewController;
}

@end
