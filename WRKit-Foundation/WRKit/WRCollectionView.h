//
//  WRCollectionView.h
//  WRKitDemo
//
//  Created by xianghui on 2017/9/27.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/** 集合视图样式类型 */
typedef NS_ENUM(NSInteger, WRCollectionViewStyle) {
    /** 横向 */
    WRCollectionViewStyle_Landscape = 1,
    /** 竖向 */
    WRCollectionViewStyle_Portrait,
    /** 横向一半 */
    WRCollectionViewStyle_LandscapeHalf,
    /** 竖向一半 */
    WRCollectionViewStyle_PortraitHalf
};
/** 集合视图对象类型 */
typedef NS_ENUM(NSInteger, WRCollectionViewObjectType) {
    /** cell */
    WRCollectionViewObjectType_Cell = 0,
    /** 头 */
    WRCollectionViewObjectType_Header,
    /** 尾 */
    WRCollectionViewObjectType_Footer,
};
#pragma mark - WRCollectionViewObject
/** 集合视图对象 */
@interface WRCollectionViewObject : NSObject
/** 集合视图对象类型 */
@property (assign, nonatomic) WRCollectionViewObjectType type;
/** 尺寸
 @note 默认44
 */
@property (assign, nonatomic) CGFloat size;
/** 标识 */
@property (copy, nonatomic) NSString *identifier;
/** cell 类名 */
@property (copy, nonatomic) NSString *cellClassName;
@end
#pragma mark - WRCollectionViewDataSource
/** 集合视图数据源 */
@interface WRCollectionViewDataSource : NSObject
/** 属性数组 */
@property (strong, nonatomic) NSMutableArray <WRCollectionViewObject *> *objectsArray;
/** header对象 */
@property (strong, nonatomic, readonly) WRCollectionViewObject *headerObject;
/** footer对象 */
@property (strong, nonatomic, readonly) WRCollectionViewObject *footerObject;
/** cell对象数组 */
@property (strong, nonatomic, readonly) NSArray *cellObjectsArray;
/** 集合视图样式 */
@property (assign, nonatomic) WRCollectionViewStyle collectionViewStyle;
@end
#pragma mark - WRCollectionView
/** 集合视图 */
@interface WRCollectionView : UIView
/** 集合视图 */
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
/** 显示水平滚动指示 */
@property (assign, nonatomic) BOOL wr_showsHorizontalScrollIndicator;
/** 显示垂直滚动指示 */
@property (assign, nonatomic) BOOL wr_showsVerticalScrollIndicator;
/** 数据源数组 */
@property (strong, nonatomic) NSMutableArray *dataSource;;
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
/** 滚动停止block */
@property (copy, nonatomic) void (^wr_scrollViewDidEndDeceleratingBlock)(UIScrollView *scrollView);
/** @note 单一section，单一cell样式的集合视图,无头尾视图
 */
- (instancetype)initSingleSectionSingleCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                  cellIdentifier:(NSString *)cellIdentifier
                                   cellClassName:(NSString *)cellClassName
                                        cellSize:(CGFloat)cellSize
                                       cellCount:(NSInteger)cellCount;
/** @note 单一section，单一cell样式的集合视图
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
/** @note 单一section，多种cell样式的集合视图
 */
- (instancetype)initSingleSectionMultiCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                cellIdentifiers:(NSArray <NSString *> *)cellIdentifiers
                                 cellClassNames:(NSArray <NSString *> *)cellClassNames
                                      cellSizes:(NSArray <NSNumber *> *)cellSizes
                               headerIdentifier:(nullable NSString *)headerIdentifier
                                     headerSize:(CGFloat)headerSize
                               footerIdentifier:(nullable NSString *)footerIdentifier
                                     footerSize:(CGFloat)footerSize;
/** @note 多个section同一个cell的
 */
- (instancetype)initMultiSectionsSingleCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                  cellIdentifier:(NSString *)cellIdentifier
                                   cellClassName:(NSString *)cellClassName
                                        cellSize:(CGFloat)cellSize
                                       cellCount:(NSArray <NSNumber *> * )cellCounts
                                headerIdentifier:(nullable NSString *)headerIdentifier
                                      headerSize:(CGFloat)headerSize
                                footerIdentifier:(nullable NSString *)footerIdentifier
                                      footerSize:(CGFloat)footerSize;
/** @note 多个section,每个section的cell可以不同,无header和footer
 */
- (instancetype)initMultiSectionsMultiCellStyles:(NSArray <NSNumber *>*)collectionViewStyles
                                 cellIdentifiers:(NSArray <NSString *> *)cellIdentifiers
                                  cellClassNames:(NSArray <NSString *> *)cellClassNames
                                       cellSizes:(NSArray <NSNumber *> *)cellSizes
                                      cellCounts:(NSArray <NSNumber *> *)cellCounts;
/** @note 多个section,每个section的cell可以不同,有相同的header和footer
 */
- (instancetype)initMultiSectionsMultiCellStyles:(NSArray <NSNumber *>*)collectionViewStyles
                                 cellIdentifiers:(NSArray <NSString *> *)cellIdentifiers
                                  cellClassNames:(NSArray <NSString *> *)cellClassNames
                                       cellSizes:(NSArray <NSNumber *> *)cellSizes
                                      cellCounts:(NSArray <NSNumber *> *)cellCounts
                                      sameHeader:(nullable NSString *)sameHeaderIdentifier
                                 sameHeaderSizes:(nullable NSNumber *)sameHeaderSize
                                      sameFooter:(nullable NSString *)sameFooterIdentifier
                                 sameFooterSizes:(nullable NSNumber *)sameFooterSize;
/** @note 多个section,每个section的cell可以不同,有不同的header和footer
 */
- (instancetype)initMultiSectionsMultiCellStyles:(NSArray <NSNumber *>*)collectionViewStyles
                                 cellIdentifiers:(NSArray <NSString *> *)cellIdentifiers
                                  cellClassNames:(NSArray <NSString *> *)cellClassNames
                                       cellSizes:(NSArray <NSNumber *> *)cellSizes
                                      cellCounts:(NSArray <NSNumber *> *)cellCounts
                               headerIdentifiers:(nullable NSArray <NSString *> *)headerIdentifiers
                                     headerSizes:(nullable NSArray <NSNumber *> *)headerSizes
                               footerIdentifiers:(nullable NSArray <NSString *> *)footerIdentifiers
                                     footerSizes:(nullable NSArray <NSNumber *> *)footerSizes;

/** 初始化
 @note 深度定制，每个section的cell可以不同类型
 @param collectionViewStyles     集合视图样式数组
 @param cellIdentifiers         cell 的标识数组，区分section
 @param cellClassNames          cell 类数组，区分section
 @param cellSizes               cell 的尺寸数组，区分section
 @param headerIdentifiers       头的标识数组，区分section
 @param headerSizes             头的尺寸数组，区分section
 @param footerIdentifiers       尾的标识数组，区分section
 @param footerSizes             尾的尺寸数组，区分section
 */
- (instancetype)initWithCollectionViewStyles:(NSArray <NSNumber *>*)collectionViewStyles
                             cellIdentifiers:(NSArray <NSArray <NSString *>*> *)cellIdentifiers
                              cellClassNames:(NSArray <NSArray <NSString *>*> *)cellClassNames
                                   cellSizes:(NSArray <NSArray <NSNumber *>*> *)cellSizes
                           headerIdentifiers:(nullable NSArray <NSString *> *)headerIdentifiers
                                 headerSizes:(nullable NSArray <NSNumber *> *)headerSizes
                           footerIdentifiers:(nullable NSArray <NSString *> *)footerIdentifiers
                                 footerSizes:(nullable NSArray <NSNumber *> *)footerSizes;
/** 刷新 */
- (void)wr_reload;
NS_ASSUME_NONNULL_END
@end

