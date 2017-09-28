//
//  WRCollectionView.h
//  WRKitDemo
//
//  Created by xianghui on 2017/9/27.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/** 集合视图对象类型 */
typedef NS_ENUM(NSInteger, WRCollectionViewObjectType) {
    /** cell */
    WRCollectionViewObjectType_Cell = 0,
    /** 头 */
    WRCollectionViewObjectType_Header,
    /** 尾 */
    WRCollectionViewObjectType_Footer,
};
/** 集合视图样式类型 */
typedef NS_ENUM(NSInteger, WRCollectionViewStyle) {
    /** 横向 */
    WRCollectionViewStyle_Landscape = 0,
    /** 竖向 */
    WRCollectionViewStyle_Portrait,
    /** 横向一半 */
    WRCollectionViewStyle_LandscapeHalf,
    /** 竖向一半 */
    WRCollectionViewStyle_PortraitHalf
};
#pragma mark -
/** 集合视图布局 */
@interface WRCollectionViewLayout : UICollectionViewLayout
/** 数据源数组 */
@property (strong, nonatomic, readonly) NSArray *dataSourcesArray;

@end
#pragma mark -
/** 集合视图 */
@interface WRCollectionView : UIView
/** 集合视图 */
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
/** 初始化
 @note 单一section，单一cell样式的集合视图
 */
- (instancetype)initSingleSectionSingleCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                  cellIdentifier:(NSString *)cellIdentifier
                                   cellClassName:(NSString *)cellClassName
                                        cellSize:(CGFloat)cellSize
                                       cellCount:(NSInteger)cellCount;
/** 初始化
 @note 单一section，单一cell样式的集合视图
 */
- (instancetype)initSingleSectionSingleCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                  cellIdentifier:(NSString *)cellIdentifier
                                   cellClassName:(NSString *)cellClassName
                                        cellSize:(CGFloat)cellSize
                                       cellCount:(NSInteger)cellCount
                                headerIdentifier:(nullable NSString *)headerIdentifier
                                      headerSize:(CGFloat)headerSize
                                footerIdentifier:(nullable NSString *)footerIdentifier
                                      footerSize:(CGFloat)footerSize;
/** 初始化
 @note 单一section多种cell样式的集合视图
 */
- (instancetype)initSingleSectionMultiCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                cellIdentifiers:(NSArray <NSString *> *)cellIdentifiers
                                  cellClassNames:(NSArray <NSString *> *)cellClassNames
                                      cellSizes:(NSArray <NSNumber *> *)cellSizes
                               headerIdentifier:(nullable NSString *)headerIdentifier
                                     headerSize:(CGFloat)headerSize
                               footerIdentifier:(nullable NSString *)footerIdentifier
                                     footerSize:(CGFloat)footerSize;
/** 初始化
 @note 深度定制，每个section的cell可以不用类型
 @param collectionViewStyle     集合视图样式
 @param cellIdentifiers         cell 的标识数组，区分section
 @param cellClassNames          cell 类数组，区分section
 @param cellSizes               cell 的尺寸数组，区分section
 @param headerIdentifiers       头的标识数组，区分section
 @param headerSizes             头的尺寸数组，区分section
 @param footerIdentifiers       尾的标识数组，区分section
 @param footerSizes             尾的尺寸数组，区分section
*/
- (instancetype)initWithCollectionViewStyle:(WRCollectionViewStyle)collectionViewStyle
                            cellIdentifiers:(NSArray <NSArray <NSString *>*> *)cellIdentifiers
                             cellClassNames:(NSArray <NSArray <NSString *>*> *)cellClassNames
                                  cellSizes:(NSArray <NSArray <NSNumber *>*> *)cellSizes
                          headerIdentifiers:(nullable NSArray <NSString *> *)headerIdentifiers
                                headerSizes:(nullable NSArray <NSNumber *> *)headerSizes
                          footerIdentifiers:(nullable NSArray <NSString *> *)footerIdentifiers
                                footerSizes:(nullable NSArray <NSNumber *> *)footerSizes;
/** 加载cell block
 @param collectionView 集合视图
 @param cell cell
 @param indexPath 索引
 */
@property (copy, nonatomic) void (^loadedCellBlock)(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath);
/** 集合视图选中回调block
 @param collectionView 集合试图
 @param indexPath 选中索引
 */
@property (copy, nonatomic) void (^collectionViewCellDidSelectedBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);

NS_ASSUME_NONNULL_END
@end
