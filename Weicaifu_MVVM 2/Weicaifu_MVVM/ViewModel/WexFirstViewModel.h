//
//  WexFirstViewModel.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexTableViewModel.h"


@class WexFirstViewModel;
@class WexMessageEntity;


// 数据代理
@protocol WexFirstViewModelDelegate <WexTableViewModelDelegate>

@required
// 加载数据
- (void)firstViewModel:(WexFirstViewModel *)firstViewModel
     loadDataWithIndex:(NSUInteger)index
              complete:(void(^)(WexMessageEntity *data, NSError *error))complete;

- (void)firstViewModel:(WexFirstViewModel *)firstViewModel
        submitWithArg1:(NSString *)arg1
              complete:(void(^)(NSError *error))complete;

//- (void)

@end


// 页面代理
@protocol WexFirstViewModelNavigationService <WexViewModelNavigationService>

@optional
- (void)presentCameraWithComplete:(void(^)(UIImage *image))complete;

@end




@interface WexFirstViewModel : WexTableViewModel

@property (nonatomic, weak) id<WexFirstViewModelDelegate> delegate;

@property (nonatomic, weak) id<WexFirstViewModelNavigationService> navigationService;

@property (nonatomic, strong) WexMessageEntity *data;

@end
