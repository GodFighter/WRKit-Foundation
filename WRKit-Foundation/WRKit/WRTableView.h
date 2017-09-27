//
//  WRTableView.h
//  WRKitDemo
//
//  Created by xianghui on 2017/9/26.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

#pragma mark -
/** cell 的对象 */
@interface WRTableViewCellObject : NSObject
/** 标识 */
@property (copy, nonatomic) NSString *identifier;
/** cell 类名 */
@property (copy, nonatomic) NSString *cellClassName;
/** 高
 @note 默认44
 */
@property (assign, nonatomic) CGFloat height;

@end

#pragma mark -
@interface WRTableViewDataSource : NSObject
/** 对象数组
 @note 包含 WRTableViewCellObject 实例的数组
 */
@property (strong, nonatomic) NSMutableArray <NSArray <WRTableViewCellObject *> *> *objectsArray;

@end
#pragma mark - 
/** 表视图 */
@interface WRTableView : UIView
/** 表视图 */
@property (strong, nonatomic) UITableView *tableView;
/** 数据源 */
@property (strong, nonatomic) WRTableViewDataSource *dataSource;
/** 表视图选中回调block
 @param tableView 表试图
 @param indexPath 选中索引
*/
@property (copy, nonatomic) void (^tableViewCellDidSelectedBlock)(UITableView *tableView, NSIndexPath *indexPath);

NS_ASSUME_NONNULL_END
@end
