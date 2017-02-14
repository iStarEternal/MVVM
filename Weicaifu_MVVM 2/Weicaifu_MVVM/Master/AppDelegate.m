//
//  AppDelegate.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/17.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "AppDelegate.h"
#import "WexFirstViewController.h"
#import "WexFirstViewModel.h"

@interface AppDelegate ()
{}
@property (nonatomic, strong) WexFirstViewModel *rootViewModel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] init];
    
    self.rootViewModel = [[WexFirstViewModel alloc] init];
    self.window.rootViewController = [self.rootViewModel makeRootViewContorller];
    [self.window makeKeyAndVisible];
    
    
    // 获取数据
    [self getRemoteDataWithCallBack:^(NSObject *data) {
        
        NSString *str = (NSString *)data;
        printf("%s", [str UTF8String]); // print result is "返回的数据"
    }];
    
    return YES;
}


- (void)getRemoteDataWithCallBack:(void(^)(NSObject *data))callBack {
    
    // 1、取得数据
    // ...
    
    // 2、回调传入数据
    if (callBack != NULL) {
        callBack(@"返回的数据");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
