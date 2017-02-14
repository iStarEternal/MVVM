//
//  AppDelegate.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/17.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

/* 优点
 
 1、层次清晰，职责明确：
 和界面有关的逻辑完全划到 ViewModel 和 View。
 View 负责绘制页面；
 ViewModel 负责界面逻辑；
 DataController 负责数据逻辑；
 Model 负责纯粹的数据层逻辑；
 ViewController 仅仅只是充当简单的胶水作用。
 
 2、耦合度低，测试性高：
 除开 ViewController 外，各个部件可以说是完全解耦合的，各个部分也是可以完全独立测试的。
 同一个功能，可以分别由不同的开发人员分别进行开发界面和数据访问，只需要确立好接口即可。
 
 3、学习成本低: 本质上来说，这个架构属于对 MVC 的优化，主要解决ViewController代码冗余问题。
 把原本属于 ViewController 的职责根据界面和逻辑部分相应的拆到 ViewModel 和 DataController 当中，
 是一个非常易于理解的架构设计，即使是新手也可以很快上手。
 
 */

/* 缺点
 
 1、iOS没有binding机制，数据之间的交互只能通过代理或者代码块实现，代码写起来比较费劲。
 2、传统的MVVM中，VM是一体的，而现在拆分成了ViewModel和DataController，代码写起来更费劲。
 
 */
