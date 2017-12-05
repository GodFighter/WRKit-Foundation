//
//  WRTableView.h
//  WRTableView
//
//  Created by xianghui on 2017/11/30.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRTableViewDataSource.h"

/** 表视图 */
@interface WRTableView : UIView
/** 表视图 */
@property (weak, nonatomic, readonly) UITableView *tableView;
/** 加载cell block
 @param tableView 表合视图
 @param cell cell
 @param indexPath 索引
 @param object 持有对象
 */
@property (copy, nonatomic) void (^loadedCellBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath, id object);
/** 表视图选中回调block
 @param tableView 表试图
 @param indexPath 选中索引
 */
@property (copy, nonatomic) void (^tableViewCellDidSelectedBlock)(UITableView *tableView, NSIndexPath *indexPath);
/** 加载header block
 @param tableView 表合视图
 @param header header
 @param section 区
 */
@property (copy, nonatomic) void (^loadedHeaderBlock)(UITableView *tableView, UITableViewHeaderFooterView *header, NSInteger section);
/** 加载footer block
 @param tableView 表合视图
 @param footer footer
 @param section 区
 */
@property (copy, nonatomic) void (^loadedFooterBlock)(UITableView *tableView, UITableViewHeaderFooterView *footer, NSInteger section);
/** 根据数据源初始化
 @param dataSource 数据源
 @return 表视图
 */
- (instancetype)initWithDataSource:(WRTableViewDataSource *)dataSource;
/** 刷新数据，不更新表视图注册信息 */
- (void)update;
/** 刷新数据，更新表视图注册信息 */
- (void)updateDataSource;
- (void)reloadIndexPath:(NSIndexPath *)indexPath height:(CGFloat)height;

@end

