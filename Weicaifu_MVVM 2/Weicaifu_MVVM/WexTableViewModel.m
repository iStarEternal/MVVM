//
//  WexTableViewModel.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexTableViewModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UITableView+StarTemplateLayoutCell.h"

#import <objc/runtime.h>


@interface WexTableViewModel ()


@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation WexTableViewModel

@dynamic delegate;


- (void)handleView:(UIView *)view {
    [super handleView:view];
    
    UITableView *tableView = [self createTableView];
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    self.tableView.frame = self.view.bounds;
    
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}



#pragma mark - 数据源

- (NSMutableDictionary *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return _dataSource;
}



#pragma mark - TableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    return [rows count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    UITableViewCell *cell = rows[indexPath.row];
    
    NSInteger cellHeight = [tableView fd_heightForCellWithStaticCell:cell configuration:NULL];
    NSAssert(cellHeight, @"Cell height should not be 0.");
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    UITableViewCell *cell = rows[indexPath.row];
    NSAssert(cell, @"Cell should not be nil.");
    return cell;
}




#pragma mark - Cell 操作

- (void)loadAllCells {
    NSAssert(false, @"请在子类实现该方法");
}

- (void)insertCell:(UITableViewCell *)cell toIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    if (rows == nil) {
        rows = [NSMutableArray array];
        [self.dataSource setObject:rows forKey:[NSNumber numberWithInteger:indexPath.section]];
    }
    [rows removeObject:cell];
    [rows insertObject:cell atIndex:indexPath.row];
}

- (void)appendCell:(UITableViewCell *)cell toSection:(NSInteger)section {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows == nil) {
        rows = [NSMutableArray array];
        [self.dataSource setObject:rows forKey:[NSNumber numberWithInteger:section]];
    }
    if ([rows containsObject:cell]) {
        return;
    }
    [rows addObject:cell];
}

- (void)replaceCell:(UITableViewCell *)target withCell:(UITableViewCell *)replacement atSection:(NSInteger)section {
    
    NSMutableArray *rows = [self.dataSource objectForKey:@(section)];
    if (rows == nil) {
        rows = [NSMutableArray array];
        [self.dataSource setObject:rows forKey:@(section)];
    }
    
    NSUInteger index = [rows indexOfObject:target];
    if (index == NSNotFound) {
        return;
    }
    
    [rows replaceObjectAtIndex:index withObject:replacement];
    
}

- (void)removeCell:(UITableViewCell *)cell atSection:(NSInteger)section {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows) {
        [rows removeObject:cell];
    }
}

- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    if (rows) {
        [rows removeObjectAtIndex:indexPath.row];
    }
}

- (void)removeAllCells {
    
    if (self.dataSource) {
        [self.dataSource removeAllObjects];
    }
}

- (void)synchronizeAllCells {
    [self.tableView reloadData];
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray* rows = self.dataSource[@(indexPath.section)];
    
    if (rows) {
        if (indexPath.row < [rows count]) {
            return [rows objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (NSMutableArray *)rowsForSection:(NSInteger)section {
    return self.dataSource[@(section)];
}

- (void)reloadCell:(UITableViewCell *)cell withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    }
}

- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell {
    if (!cell) {
        return nil;
    }
    for (int i = 0; i < self.dataSource.count; i++) {
        NSMutableArray* rows = self.dataSource[@(i)];
        for (int j = 0; j < rows.count; j++) {
            if (rows[j] == cell) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    return nil;
}


#pragma mark - 动态行标记

static void *DynamicCellBeginFlagKey = &DynamicCellBeginFlagKey;

- (void)markDynamicCellBeginFlag:(NSString *)beginFlag toSection:(NSInteger)section {
    
    NSArray *rows = [self.dataSource objectForKey:@(section)];
    
    if (rows.lastObject) {
        objc_setAssociatedObject(rows.lastObject, &DynamicCellBeginFlagKey, beginFlag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSInteger)indexOfDynamicCellBeginFlag:(NSString *)beginFlag section:(NSInteger)section {
    
    NSArray *rows = [self.dataSource objectForKey:@(section)];
    
    for (int i = 0; i < rows.count; i++) {
        
        id obj = objc_getAssociatedObject(rows[i], &DynamicCellBeginFlagKey);
        
        if (obj && [obj isKindOfClass:[NSString class]] && [beginFlag isEqualToString:((NSString *)obj)]) {
            return i + 1;
        }
    }
    return 0;
}




@end


@implementation WexTableViewModel (TableViewFactory)


#pragma mark - 当前TableView

- (UITableView *)createTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = [UIColor orangeColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    return tableView;
}

@end
