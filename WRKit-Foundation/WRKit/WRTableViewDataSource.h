//
//  WRTableViewDataSource.h
//  WRTableView
//
//  Created by xianghui on 2017/11/30.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - WRTableViewItem
/** 表视图项目 */
@interface WRTableViewItem : NSObject
/** cell类 */
@property (assign, nonatomic) Class cellClass;
/** 高 */
@property (assign, nonatomic) CGFloat height;
/** 标识 */
@property (copy, nonatomic) NSString *identifier;
/** 对象 */
@property (weak, nonatomic) id object;

@end
#pragma mark - WRTableViewSection
/** 表视图段 */
@interface WRTableViewSection : NSObject
/** 头视图类 */
@property (assign, nonatomic) Class headerClass;
/** 底视图类 */
@property (assign, nonatomic) Class footerClass;
/** 头视图高 */
@property (assign, nonatomic) CGFloat headerHeight;
/** 底视图高 */
@property (assign, nonatomic) CGFloat footerHeight;
/** 头视图标识 */
@property (copy, nonatomic) NSString *headerIdentifier;
/** 底视图标识 */
@property (copy, nonatomic) NSString *footerIdentifier;
/** 项目数组 */
@property (strong, nonatomic, readonly) NSArray <WRTableViewItem *> *itemsArray;
/** 根据项目初始化 */
- (instancetype)initWithItems:(NSArray <WRTableViewItem *> *)items;

@end
#pragma mark - WRTableViewDataDource
/** 表视图数据源 */
@interface WRTableViewDataSource : UIView
/** 段数组 */
@property (strong, nonatomic, readonly) NSArray <WRTableViewSection *> *sectionsArray;
/** 根据段数组初始化 */
- (instancetype)initWithSections:(NSArray <WRTableViewSection *> *)sections;

@end
