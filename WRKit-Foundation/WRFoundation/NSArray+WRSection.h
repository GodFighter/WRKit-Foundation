//
//  NSArray+WRSection.h
//  DelehiLivingStream
//
//  Created by xianghui on 2018/3/21.
//  Copyright © 2018年 xianghui. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/** 集合视图样式类型 */
typedef NS_ENUM(NSInteger, WRCollectionViewStyle22) {
    /** 横向展示，竖向滚动 */
    WRCollectionViewStyle22_Landscape = 1,
    /** 竖向展示，横向滚动 */
    WRCollectionViewStyle22_Portrait,
    /** 横向一半 */
    WRCollectionViewStyle22_LandscapeHalf,
    /** 竖向一半 */
    WRCollectionViewStyle22_PortraitHalf
};

/** 数组 section 类目 */
@interface NSArray (WRSection)
/** section header尺寸 */
@property (assign, nonatomic) CGFloat wr_sectionHeaderSize;
/** section footer尺寸 */
@property (assign, nonatomic) CGFloat wr_sectionFooterSize;
/** section 头视图类 */
@property (assign, nonatomic) Class wr_sectionHeaderClass;
/** section 尾视图类 */
@property (assign, nonatomic) Class wr_sectionFooterClass;
/** section header重用id */
@property (copy, nonatomic) NSString *wr_headerReuseIdentifier;
/** section footer重用id */
@property (copy, nonatomic) NSString *wr_footerReuseIdentifier;
#pragma mark - WRCollectionView
/** 集合视图样式 */
@property (assign, nonatomic) WRCollectionViewStyle22 wr_collectionViewStyle;

@end
