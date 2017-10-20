//
//  WRTableView.h
//  WRKitDemo
//
//  Created by xianghui on 2017/9/26.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/** 表视图对象类型 */
typedef NS_ENUM(NSInteger, WRTableViewObjectType) {
    /** cell */
    WRTableViewObjectType_Cell = 0,
    /** 头 */
    WRTableViewObjectType_Header,
    /** 尾 */
    WRTableViewObjectType_Footer,
};
#pragma mark - WRTableViewCellObject
/** cell 的对象 */
@interface WRTableViewCellObject : NSObject
/** 表视图对象类型 */
@property (assign, nonatomic) WRTableViewObjectType type;
/** 标识 */
@property (copy, nonatomic) NSString *identifier;
/** cell 类名 */
@property (copy, nonatomic) NSString *cellClassName;
/** 高
 @note 默认44
 */
@property (assign, nonatomic) CGFloat height;

@end
#pragma mark - WRTableViewDataSource
@interface WRTableViewDataSource : NSObject
/** 对象数组
 @note 包含 WRTableViewCellObject 实例的数组
 */
@property (strong, nonatomic) NSMutableArray <NSMutableArray <WRTableViewCellObject *> *> *objectsArray;
/** 表视图头视图高度数组 */
@property (strong, nonatomic) NSMutableArray <NSNumber *>* headerHeightsArray;
/** 表视图尾视图高度数组 */
@property (strong, nonatomic) NSMutableArray <NSNumber *>* footerHeightsArray;

@end
#pragma mark - WRTableView
/** 表视图 */
@interface WRTableView : UIView
/** 表视图 */
@property (strong, nonatomic) UITableView *tableView;
/** 数据源 */
@property (strong, nonatomic) WRTableViewDataSource *dataSource;
/** 头尾视图参数，不设置则为nil */
@property (strong, nonatomic) NSArray <NSString *>*headerViewIdentifier;
@property (strong, nonatomic) NSArray <NSString *>*headerViewClassName;
@property (strong, nonatomic) NSArray <NSString *>*footerViewIdentifier;
@property (strong, nonatomic) NSArray <NSString *>*footerViewClassName;
/** 加载cell block
 @param tableView 表合视图
 @param cell cell
 @param indexPath 索引
 */
@property (copy, nonatomic) void (^loadedCellBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
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
/** 表视图选中回调block
 @param tableView 表试图
 @param indexPath 选中索引
*/
@property (copy, nonatomic) void (^tableViewCellDidSelectedBlock)(UITableView *tableView, NSIndexPath *indexPath);

/** 初始化
 @note 单一section，单一cell样式的集合视图
 */
- (instancetype)initSingleSectionSingleCellIdentifier:(NSString *)cellIdentifier
                                        cellClassName:(nullable NSString *)cellClassName
                                           cellHeight:(CGFloat)cellHeight
                                            cellCount:(NSInteger)cellCount;
/** 初始化
 @note 单一section，单一cell样式的集合视图,带header和footer
 */
- (instancetype)initSingleSectionSingleCellIdentifier:(NSString *)cellIdentifier
                                        cellClassName:(nullable NSString *)cellClassName
                                           cellHeight:(CGFloat)cellHeight
                                            cellCount:(NSInteger)cellCount
                                         headerHeight:(CGFloat)headerHeight
                                         footerHeight:(CGFloat)footerHeight;
/** 初始化
 @note 多section，单一cell样式的集合视图,带header和footer
 */
- (instancetype)initMultiSectionSingleCellIdentifier:(NSString *)cellIdentifier
                                       cellClassName:(nullable NSString *)cellClassName
                                          cellHeight:(CGFloat)cellHeight
                                           cellCount:(NSArray <NSNumber *> *)cellCounts
                                       headerHeights:(nullable NSArray <NSNumber *>*)headerHeights
                                       footerHeights:(nullable NSArray <NSNumber *>*)footerHeights;

/** 初始化
 @note 深度定制，每个section的cell可以不用类型
 @param cellIdentifiers         cell 的标识数组，区分section
 @param cellClassNames          cell 的类名数组，区分section
 @param cellHeights             cell 的高度数组，区分section
 @param headerHeights             头的尺寸数组，区分section
 @param footerHeights             尾的尺寸数组，区分section
 */
- (instancetype)initWithCellIdentifiers:(NSArray <NSArray <NSString *>*>*)cellIdentifiers
                         cellClassNames:(NSArray <NSArray <NSString *>*>*)cellClassNames
                             cellHeight:(NSArray <NSArray <NSNumber *>*>*)cellHeights
                          headerHeights:(nullable NSArray <NSNumber *>*)headerHeights
                          footerHeights:(nullable NSArray <NSNumber *>*)footerHeights;
/** 刷新 */
- (void)wr_reloadData;
NS_ASSUME_NONNULL_END
@end
