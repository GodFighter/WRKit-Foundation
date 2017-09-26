//
//  WRTableView.h
//  WRKitDemo
//
//  Created by xianghui on 2017/9/26.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark -
@interface WRTableViewDataSource : NSObject
/** 数据源数组 */
@property (strong, nonatomic) NSMutableArray *dataSourceArray;
/** cell高度数组 */
@property (strong, nonatomic) NSMutableArray *cellHeightArray;

@end
#pragma mark - 
/** 表视图 */
@interface WRTableView : UIView
/** 表视图 */
@property (strong, nonatomic) UITableView *tableView;
/** cell 类名 */
@property (copy, nonatomic) NSString *cellClassName;
/** 数据源 */
@property (strong, nonatomic) WRTableViewDataSource *dataSource;

@end
