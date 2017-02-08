//
//  WexTableViewModel.h
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WexViewModel.h"

@class WexTableViewModel;

@protocol WexTableViewModelDelegate <WexViewModelDelegate>

@end



/**
 TableView Manager
 */
@interface WexTableViewModel : WexViewModel <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<WexTableViewModelDelegate> delegate;


#pragma mark - Cell 操作

- (void)loadAllCells;

- (void)appendCell:(UITableViewCell *)cell toSection:(NSInteger)section;

- (void)insertCell:(UITableViewCell *)cell toIndexPath:(NSIndexPath*)indexPath;

- (void)replaceCell:(UITableViewCell *)target withCell:(UITableViewCell *)replacement atSection:(NSInteger)section;

- (void)removeCell:(UITableViewCell *)cell atSection:(NSInteger)section;

- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)removeAllCells;

- (void)synchronizeAllCells;

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSMutableArray *)rowsForSection:(NSInteger)section;

- (void)reloadCell:(UITableViewCell *)cell withRowAnimation:(UITableViewRowAnimation)animation;

- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;


#pragma mark - 动态航

- (void)markDynamicCellBeginFlag:(NSString *)beginFlag toSection:(NSInteger)section ;

- (NSInteger)indexOfDynamicCellBeginFlag:(NSString *)beginFlag section:(NSInteger)section;

@end


/// 创建TableView
@interface WexTableViewModel (TableViewFactory)

- (UITableView *)createTableView;

@end
