//
//  WexFirstViewController.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/17.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexFirstViewController.h"

#import "WexFirstViewModel.h"
#import "WexFirstDataController.h"

#import "WexMessageEntity.h"

@interface WexFirstViewController () <WexFirstViewModelNavigationService, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong, readonly) WexFirstViewModel *viewModel;
@property (nonatomic, strong, readonly) WexFirstDataController *dataController;


@property (nonatomic, copy) void(^CameraImagePicked)(UIImage *);

@end

@implementation WexFirstViewController

@dynamic viewModel;
@dynamic dataController;


#pragma mark - 页面加载

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (Class)dataControllerClass {
    return [WexFirstDataController class];
}



#pragma mark - 拍照 & 代理

- (void)presentCameraWithComplete:(void (^)(UIImage *))complete {
    
    self.CameraImagePicked = complete;
    
    NSUInteger sourceType = 0;
    
    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{ }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:true completion:NULL];
    self.CameraImagePicked(info[UIImagePickerControllerOriginalImage]);
}



@end


@implementation WexFirstViewModel (CreateViewController)

- (WexViewController *)createViewController {
    return [[WexFirstViewController alloc] initWithViewModel:self];
}

- (UINavigationController *)makeRootViewContorller {
    WexViewController *viewController = [self createViewController];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navc;
}

@end
