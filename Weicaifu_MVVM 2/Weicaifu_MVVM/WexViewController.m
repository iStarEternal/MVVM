//
//  WexViewController.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexViewController.h"

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
    [self.navigationController pushViewController:viewController animated:true];
}

@end


@implementation WexViewModel (CreateViewController)

- (WexViewController *)createViewController {
    return [[WexViewController alloc] initWithViewModel:self];
}

@end
