//
//  WRCollectionView.m
//  WRKitDemo
//
//  Created by xianghui on 2017/9/27.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSObject+WRJudge.h"
#import "WRCollectionView.h"

#pragma mark -
@implementation WRCollectionViewObject

- (instancetype)init {
    if (self = [super init]) {
        self.type = WRCollectionViewObjectType_Cell;
        self.headerSize = 0;
        self.footerSize = 0;
    }
    return self;
}

@end
#pragma mark -
@implementation WRCollectionViewDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.objectsArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}
- (WRCollectionViewObject *)headerObject {
    for (WRCollectionViewObject *cellObject in self.objectsArray) {
        if (cellObject.type == WRCollectionViewObjectType_Header) {
            return cellObject;
        }
    }
    return nil;
}
- (WRCollectionViewObject *)footerObject {
    for (WRCollectionViewObject *cellObject in self.objectsArray) {
        if (cellObject.type == WRCollectionViewObjectType_Footer) {
            return cellObject;
        }
    }
    return nil;
}
- (NSArray *)cellObjectsArray {
    NSMutableArray *cellObjectsArray = nil;
    for (NSInteger i = 0; i < self.objectsArray.count; i++) {
        WRCollectionViewObject *cellObject = self.objectsArray[i];
        if (cellObject.type != WRCollectionViewObjectType_Header && cellObject.type != WRCollectionViewObjectType_Footer) {
            if (cellObjectsArray == nil) {
                cellObjectsArray = [NSMutableArray arrayWithCapacity:10];
            }
            [cellObjectsArray addObject:cellObject];
        }
    }
    return cellObjectsArray;
}
@end
#pragma mark -
@interface WRCollectionViewLayout ()

@property (strong, nonatomic) NSArray *dataSourcesArray; /// 数据源数组
@property (assign, nonatomic) WRCollectionViewOrientation orientation; /// 滚动方向

@end

@implementation WRCollectionViewLayout

- (instancetype)initWithDataSource:(NSArray *)dataSourcesArray
                       orientation:(WRCollectionViewOrientation)orientation {
    if (self = [super init]) {
        self.dataSourcesArray = dataSourcesArray;
        self.orientation = orientation;
        [self parseDataSource];
    }
    return self;
}
- (void)parseDataSource {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    for (NSInteger section = 0; section < self.dataSourcesArray.count; section++) {
        WRCollectionViewDataSource *dataSource = self.dataSourcesArray[section];
        if (dataSource.headerObject != nil) {
            UICollectionViewLayoutAttributes *header = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:section]];

            
            header.frame = CGRectMake(x, y, width, height);
        }
        
    }
}
- (CGFloat)

@end
#pragma mark -
@interface WRCollectionView ()

@end

@implementation WRCollectionView

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {

    }
    return _collectionView;
}

@end
