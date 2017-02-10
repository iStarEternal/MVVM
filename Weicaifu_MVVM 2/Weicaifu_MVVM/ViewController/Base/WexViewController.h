//
//  WexViewController.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WexViewModelProtocol.h"
#import "WexViewModel.h"
#import "WexDataController.h"

@interface WexViewController : UIViewController <WexViewModelDelegate, WexViewModelNavigationService>

@property (nonatomic, strong, readonly) WexViewModel *viewModel;
- (instancetype)initWithViewModel:(WexViewModel *)viewModel;

@property (nonatomic, strong, readonly) WexDataController *dataController;
- (Class)dataControllerClass;

@end


@interface WexViewModel (CreateViewController) <WexViewModelForViewControllerProtocol>

@end
