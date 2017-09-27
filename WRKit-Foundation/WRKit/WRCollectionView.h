//
//  WRCollectionView.h
//  WRKitDemo
//
//  Created by xianghui on 2017/9/27.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/** 集合视图滚动方向 */
typedef NS_ENUM(NSInteger, WRCollectionViewOrientation) {
    /** 竖向 */
    WRCollectionViewOrientation_Portrait = 0,
    /** 横向 */
    WRCollectionViewOrientation_Landscape,
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
/** 集合视图对象 */
@interface WRCollectionViewObject : NSObject
/** 集合视图对象类型 */
@property (assign, nonatomic) WRCollectionViewObjectType type;
/** 头尺寸
 @note 默认0
 */
@property (assign, nonatomic) CGFloat headerSize;
/** 尾尺寸
 @note 默认0
*/
@property (assign, nonatomic) CGFloat footerSize;
/** 标识 */
@property (copy, nonatomic) NSString *identifier;
/** cell 类名 */
@property (copy, nonatomic) NSString *cellClassName;
@end
#pragma mark -
/** 集合视图数据源 */
@interface WRCollectionViewDataSource : NSObject
/** 属性数组 */
@property (strong, nonatomic) NSArray <WRCollectionViewObject *> *objectsArray;
/** header对象 */
@property (strong, nonatomic, readonly) WRCollectionViewObject *headerObject;
/** footer对象 */
@property (strong, nonatomic, readonly) WRCollectionViewObject *footerObject;
/** cell对象数组 */
@property (strong, nonatomic, readonly) NSArray *cellObjectsArray;


///** 属性数组 */
//@property (strong, nonatomic) NSMutableArray <NSArray <WRCollectionViewObject *> *> *objectsArray;
///** section对象数组
// @note 除header和footer外的 WRCollectionViewObject
// */
//- (nullable NSArray *)wr_objectsInSection:(NSInteger)section;
///** 获取指定section中的header对象
// @param section 指定section
// @return 可能为nil的header对象
// */
//- (nullable WRCollectionViewObject *)wr_headerObjectInSection:(NSInteger)section;
///** 获取指定section中的footer对象
// @param section 指定section
// @return 可能为nil的footer对象
// */
//- (nullable WRCollectionViewObject *)wr_footerObjectInSection:(NSInteger)section;
@end
#pragma mark -
/** 集合视图布局 */
@interface WRCollectionViewLayout : UICollectionViewLayout
/** 根据数据源初始化
 @param dataSourcesArray 数据源数组
 @param orientation 滚动方向
 */
- (instancetype)initWithDataSource:(NSArray *)dataSourcesArray
                       orientation:(WRCollectionViewOrientation)orientation;
@end
#pragma mark -
/** 集合视图 */
@interface WRCollectionView : UIView
/** 集合视图 */
@property (strong, nonatomic) UICollectionView *collectionView;

NS_ASSUME_NONNULL_END
@end
