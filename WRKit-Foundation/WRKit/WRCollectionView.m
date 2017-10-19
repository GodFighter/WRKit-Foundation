//
//  WRCollectionView.m
//  WRKitDemo
//
//  Created by xianghui on 2017/9/27.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSObject+WRJudge.h"
#import "WRCollectionView.h"

static NSString * const kWRCollectionViewCellIdentifier = @"kWRCollectionViewCellIdentifier";

#pragma mark -
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
@implementation WRCollectionViewObject

- (instancetype)init {
    if (self = [super init]) {
        self.type = WRCollectionViewObjectType_Cell;
        self.size = 44;
        self.cellClassName = NSStringFromClass(UICollectionViewCell.class);
        self.identifier = kWRCollectionViewCellIdentifier;
    }
    return self;
}
- (void)setType:(WRCollectionViewObjectType)type {
    _type = type;
    if (_type != WRCollectionViewObjectType_Cell) {
        self.cellClassName = NSStringFromClass(UICollectionReusableView.class);
    }
}
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
/** 集合视图样式 */
@property (assign, nonatomic) WRCollectionViewStyle collectionViewStyle;
@end
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

@property (strong, nonatomic, readwrite) NSArray *dataSourcesArray; /// 数据源数组
@property (assign, nonatomic) WRCollectionViewStyle collectionViewStyle; /// 集合视图样式

@property (strong, nonatomic) NSMutableArray *attributesArray; // 属性数组

@end

@implementation WRCollectionViewLayout

- (instancetype)initWithDataSourcesArray:(NSArray *)dataSourcesArray
                     collectionViewStyle:(WRCollectionViewStyle)collectionViewStyle {
    if (self = [super init]) {
        self.dataSourcesArray = dataSourcesArray;
        self.collectionViewStyle = collectionViewStyle;
    }
    return self;
}
- (void)prepareLayout {
    [self parseDataSource];
}
- (CGSize)collectionViewContentSize {
    CGSize contentSize = self.collectionView.frame.size;
    UICollectionViewLayoutAttributes *lastAttributes = self.attributesArray.lastObject;
    if (self.collectionViewStyle == WRCollectionViewStyle_Landscape || self.collectionViewStyle == WRCollectionViewStyle_LandscapeHalf) {
        contentSize = CGSizeMake(self.collectionView.frame.size.width, MAX(lastAttributes.frame.origin.y + lastAttributes.frame.size.height, contentSize.height + 1));
    } else if (self.collectionViewStyle == WRCollectionViewStyle_Portrait || self.collectionViewStyle == WRCollectionViewStyle_PortraitHalf) {
        contentSize = CGSizeMake(MAX(lastAttributes.frame.origin.x + lastAttributes.frame.size.width, contentSize.width + 1), self.collectionView.frame.size.height);
    }
    return contentSize;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.attributesArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

- (void)parseDataSource {
    if (CGRectEqualToRect(self.collectionView.frame, CGRectZero) || ![NSObject wr_isEmtpty:self.attributesArray]) {
        return;
    }
    self.attributesArray = [NSMutableArray arrayWithCapacity:10];
    
    UICollectionViewLayoutAttributes *lastAttributes = nil;
    for (NSInteger section = 0; section < self.dataSourcesArray.count; section++) {
        WRCollectionViewDataSource *dataSource = self.dataSourcesArray[section];
        
        for (NSInteger item = 0; item < dataSource.objectsArray.count; item++) {
            WRCollectionViewObject *object = dataSource.objectsArray[item];
            
            CGRect frame;
            switch (object.type) {
                case WRCollectionViewObjectType_Header: {
                    frame = [self attributesWithCollectionViewObject:object
                                                          dataSource:dataSource
                                                      lastAttributes:lastAttributes
                                                           indexPath:[NSIndexPath indexPathWithIndex:section]];
                    
                    UICollectionViewLayoutAttributes *header = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:section]];
                    header.frame = frame;
                    lastAttributes = header;
                    [self.attributesArray addObject:header];
                }
                    break;
                case WRCollectionViewObjectType_Footer: {
                    frame = [self attributesWithCollectionViewObject:object
                                                          dataSource:dataSource
                                                      lastAttributes:lastAttributes
                                                           indexPath:[NSIndexPath indexPathWithIndex:section]];
                    
                    UICollectionViewLayoutAttributes *footer = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathWithIndex:section]];
                    footer.frame = frame;
                    lastAttributes = footer;
                    [self.attributesArray addObject:footer];
                }
                    break;
                case WRCollectionViewObjectType_Cell: {
                    NSInteger index = [dataSource.cellObjectsArray indexOfObject:object];
                    frame = [self attributesWithCollectionViewObject:object
                                                          dataSource:dataSource
                                                      lastAttributes:lastAttributes
                                                           indexPath:[NSIndexPath indexPathForRow:index inSection:section]];
                    
                    UICollectionViewLayoutAttributes *cell = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
                    cell.frame = frame;
                    lastAttributes = cell;
                    [self.attributesArray addObject:cell];
                }
                    break;
            }
            
        }
    }
}
- (CGRect)attributesWithCollectionViewObject:(WRCollectionViewObject *)object
                                  dataSource:(WRCollectionViewDataSource *)dataSource
                              lastAttributes:(UICollectionViewLayoutAttributes *)lastAttributes
                                   indexPath:(NSIndexPath *)indexPath {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    switch (dataSource.collectionViewStyle) {
        case WRCollectionViewStyle_Landscape:
            width = self.collectionView.frame.size.width;
            height = object.size;
            x = 0;
            y = lastAttributes.frame.origin.y + lastAttributes.frame.size.height;
            break;
        case WRCollectionViewStyle_Portrait:
            width = object.size;
            height = self.collectionView.frame.size.height;
            y = 0;
            x = lastAttributes.frame.origin.x + lastAttributes.frame.size.width;
            break;
        case WRCollectionViewStyle_LandscapeHalf:{
            width = self.collectionView.frame.size.width / 2.0;
            height = object.size;
            BOOL isCell = object.type != WRCollectionViewObjectType_Header && object.type != WRCollectionViewObjectType_Footer;
            if (isCell == NO) {
                width = self.collectionView.frame.size.width;
            }
            x = (indexPath.item % 2 == 1 && isCell) ? self.collectionView.frame.size.width / 2.0 : 0;
            y = (indexPath.item % 2 == 1 && isCell) ? lastAttributes.frame.origin.y : lastAttributes.frame.origin.y + lastAttributes.frame.size.height;
        }
            break;
        case WRCollectionViewStyle_PortraitHalf:{
            width = object.size;
            height = self.collectionView.frame.size.height / 2.0;
            BOOL isCell = object.type != WRCollectionViewObjectType_Header && object.type != WRCollectionViewObjectType_Footer;
            if (isCell == NO) {
                height = self.collectionView.frame.size.height;
            }
            x = (indexPath.item % 2 == 1 && isCell) ? lastAttributes.frame.origin.x : lastAttributes.frame.origin.x + lastAttributes.frame.size.width;
            y = (indexPath.item % 2 == 1 && isCell) ? self.collectionView.frame.size.height / 2.0 : 0;
        }
            break;
    }
    return CGRectMake(x, y, width, height);
}
@end
#pragma mark -
@interface WRCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) WRCollectionViewLayout *layout; // 布局
@property (strong, nonatomic, readwrite) UICollectionView *collectionView;

@end

@implementation WRCollectionView

- (instancetype)initSingleSectionSingleCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                  cellIdentifier:(NSString *)cellIdentifier
                                   cellClassName:(NSString *)cellClassName
                                        cellSize:(CGFloat)cellSize
                                       cellCount:(NSInteger)cellCount {
    return [[self.class alloc] initSingleSectionSingleCellStyle:collectionViewStyle
                                                 cellIdentifier:cellIdentifier
                                                  cellClassName:cellClassName
                                                       cellSize:cellSize
                                                      cellCount:cellCount
                                               headerIdentifier:nil
                                                     headerSize:0
                                               footerIdentifier:nil
                                                     footerSize:0];
}
- (instancetype)initSingleSectionSingleCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                  cellIdentifier:(NSString *)cellIdentifier
                                   cellClassName:(NSString *)cellClassName
                                        cellSize:(CGFloat)cellSize
                                       cellCount:(NSInteger)cellCount
                                headerIdentifier:(nullable NSString *)headerIdentifier
                                      headerSize:(CGFloat)headerSize
                                footerIdentifier:(nullable NSString *)footerIdentifier
                                      footerSize:(CGFloat)footerSize {
    NSMutableArray *cellIdentifirtsArray = [NSMutableArray arrayWithCapacity:cellCount];
    NSMutableArray *cellClassNamesArray = [NSMutableArray arrayWithCapacity:cellCount];
    NSMutableArray *cellSizesArray = [NSMutableArray arrayWithCapacity:cellCount];
    
    for (NSInteger i = 0; i < cellCount; i++) {
        [cellIdentifirtsArray addObject:cellIdentifier];
        [cellClassNamesArray addObject:cellClassName];
        [cellSizesArray addObject:@(cellSize)];
    }
    return [[self.class alloc] initWithCollectionViewStyle:collectionViewStyle
                                           cellIdentifiers:@[cellIdentifirtsArray]
                                            cellClassNames:@[cellClassNamesArray]
                                                 cellSizes:@[cellSizesArray]
                                         headerIdentifiers:[NSObject wr_isEmtpty:headerIdentifier] ? nil : @[headerIdentifier]
                                               headerSizes:@[@(headerSize)]
                                         footerIdentifiers:[NSObject wr_isEmtpty:footerIdentifier] ? nil : @[footerIdentifier]
                                               footerSizes:@[@(footerSize)]];
}
- (instancetype)initSingleSectionMultiCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                cellIdentifiers:(NSArray <NSString *> *)cellIdentifiers
                                 cellClassNames:(NSArray <NSString *> *)cellClassNames
                                      cellSizes:(NSArray <NSNumber *> *)cellSizes
                               headerIdentifier:(nullable NSString *)headerIdentifier
                                     headerSize:(CGFloat)headerSize
                               footerIdentifier:(nullable NSString *)footerIdentifier
                                     footerSize:(CGFloat)footerSize {
    return [[self.class alloc] initWithCollectionViewStyle:collectionViewStyle
                                           cellIdentifiers:@[cellIdentifiers]
                                            cellClassNames:@[cellClassNames]
                                                 cellSizes:@[cellSizes]
                                         headerIdentifiers:[NSObject wr_isEmtpty:headerIdentifier] ? nil : @[headerIdentifier]
                                               headerSizes:@[@(headerSize)]
                                         footerIdentifiers:[NSObject wr_isEmtpty:footerIdentifier] ? nil : @[footerIdentifier]
                                               footerSizes:@[@(footerSize)]];
}
- (instancetype)initWithCollectionViewStyle:(WRCollectionViewStyle)collectionViewStyle
                            cellIdentifiers:(NSArray <NSArray <NSString *>*> *)cellIdentifiers
                             cellClassNames:(NSArray <NSArray <NSString *>*> *)cellClassNames
                                  cellSizes:(NSArray <NSArray <NSNumber *>*> *)cellSizes
                          headerIdentifiers:(nullable NSArray <NSString *> *)headerIdentifiers
                                headerSizes:(nullable NSArray <NSNumber *> *)headerSizes
                          footerIdentifiers:(nullable NSArray <NSString *> *)footerIdentifiers
                                footerSizes:(nullable NSArray <NSNumber *> *)footerSizes {
    if (self = [super init]) {
        
        NSMutableArray *dataSourceArray = [NSMutableArray arrayWithCapacity:10];
        
        for (NSInteger section = 0; section < cellIdentifiers.count; section++) {
            WRCollectionViewDataSource *dataSource = [WRCollectionViewDataSource new];
            dataSource.collectionViewStyle = collectionViewStyle;
            
            NSMutableArray *objectsArray = [NSMutableArray arrayWithCapacity:10];
            
            NSString *headerIdentifier = headerIdentifiers[section];
            if (![NSObject wr_isEmtpty:headerIdentifier]) {
                WRCollectionViewObject *header = [WRCollectionViewObject new];
                header.type = WRCollectionViewObjectType_Header;
                header.identifier = headerIdentifier;
                header.size = headerSizes[section].integerValue;
                [objectsArray addObject:header];
            }
            for (NSInteger item = 0; item < cellIdentifiers[section].count; item++) {
                WRCollectionViewObject *cell = [WRCollectionViewObject new];
                cell.type = WRCollectionViewObjectType_Cell;
                cell.identifier = cellIdentifiers[section][item];
                cell.cellClassName = cellClassNames[section][item];
                cell.size = cellSizes[section][item].integerValue;
                [objectsArray addObject:cell];
            }
            NSString *footerIdentifier = footerIdentifiers[section];
            if (![NSObject wr_isEmtpty:footerIdentifier]) {
                WRCollectionViewObject *footer = [WRCollectionViewObject new];
                footer.type = WRCollectionViewObjectType_Footer;
                footer.identifier = footerIdentifier;
                footer.size = footerSizes[section].integerValue;
                [objectsArray addObject:footer];
            }
            dataSource.objectsArray = objectsArray;
            [dataSourceArray addObject:dataSource];
        }
        self.layout = [[WRCollectionViewLayout alloc] initWithDataSourcesArray:dataSourceArray
                                                           collectionViewStyle:collectionViewStyle];
    }
    return self;
}
- (instancetype)initWithCollectionViewStyles:(NSArray <NSNumber *>*)collectionViewStyles
                             cellIdentifiers:(NSArray <NSString *> *)cellIdentifiers
                              cellClassNames:(NSArray <NSString *> *)cellClassNames
                                   cellSizes:(NSArray <NSNumber *> *)cellSizes
                                  cellCounts:(NSArray <NSNumber *> *)cellCounts
                           headerIdentifiers:(nullable NSArray <NSString *> *)headerIdentifiers
                                 headerSizes:(nullable NSArray <NSNumber *> *)headerSizes
                           footerIdentifiers:(nullable NSArray <NSString *> *)footerIdentifiers
                                 footerSizes:(nullable NSArray <NSNumber *> *)footerSizes {
    NSMutableArray *cellIdentifiersArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *cellClassNamesArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *cellSizesArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    for (NSInteger section = 0; section < cellCounts.count; section++) {
        NSInteger sectionCellCount = cellCounts[section].integerValue;
        
        NSMutableArray *sectionIdentifiersArray = [NSMutableArray arrayWithCapacity:sectionCellCount];
        NSMutableArray *sectionClassNamesArray = [NSMutableArray arrayWithCapacity:sectionCellCount];
        NSMutableArray *sectionSizesArray = [NSMutableArray arrayWithCapacity:sectionCellCount];
        
        for (NSInteger item = 0; item < sectionCellCount; item++) {
            [sectionIdentifiersArray addObject:cellIdentifiers[section]];
            [sectionClassNamesArray addObject:cellClassNames[section]];
            [sectionSizesArray addObject:cellSizes[section]];
        }
        [cellIdentifiersArray addObject:sectionIdentifiersArray];
        [cellClassNamesArray addObject:sectionClassNamesArray];
        [cellSizesArray addObject:sectionSizesArray];
        
    }
    return [[self.class alloc] initWithCollectionViewStyles:collectionViewStyles
                                            cellIdentifiers:cellIdentifiersArray
                                             cellClassNames:cellClassNamesArray
                                                  cellSizes:cellSizesArray
                                          headerIdentifiers:headerIdentifiers
                                                headerSizes:headerSizes
                                          footerIdentifiers:footerIdentifiers
                                                footerSizes:footerSizes];
}
- (instancetype)initWithMultiSectionsSingleCellStyle:(WRCollectionViewStyle)collectionViewStyle
                                      cellIdentifier:(NSString *)cellIdentifier
                                       cellClassName:(NSString *)cellClassName
                                            cellSize:(CGFloat)cellSize
                                           cellCount:(NSArray <NSNumber *> * )cellCounts
                                    headerIdentifier:(nullable NSString *)headerIdentifier
                                          headerSize:(CGFloat)headerSize
                                    footerIdentifier:(nullable NSString *)footerIdentifier
                                          footerSize:(CGFloat)footerSize {
    NSMutableArray *collectionViewStyles = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *headerIdentifiers = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *headerSizes = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *footerIdentifiers = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *footerSizes = [NSMutableArray arrayWithCapacity:cellCounts.count];
    
    NSMutableArray *cellIdentifiersArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *cellClassNamesArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *cellSizesArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    for (NSInteger section = 0; section < cellCounts.count; section++) {
        [collectionViewStyles addObject:@(collectionViewStyle)];
        [headerIdentifiers addObject:headerIdentifier];
        [headerSizes addObject:@(headerSize)];
        [footerIdentifiers addObject:footerIdentifier];
        [footerSizes addObject:@(footerSize)];
        
        NSMutableArray *sectionIdentifiersArray = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *sectionClassNamesArray = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *sectionSizesArray = [NSMutableArray arrayWithCapacity:1];
        for (NSInteger index = 0; index < cellCounts[section].integerValue; index++) {
            [sectionIdentifiersArray addObject:cellIdentifier];
            [sectionClassNamesArray addObject:cellClassName];
            [sectionSizesArray addObject:@(cellSize)];
        }
        [cellIdentifiersArray addObject:sectionIdentifiersArray];
        [cellClassNamesArray addObject:sectionClassNamesArray];
        [cellSizesArray addObject:sectionSizesArray];
    }
    return [[self.class alloc] initWithCollectionViewStyles:collectionViewStyles
                                            cellIdentifiers:cellIdentifiersArray
                                             cellClassNames:cellClassNamesArray
                                                  cellSizes:cellSizesArray
                                          headerIdentifiers:headerIdentifiers
                                                headerSizes:headerSizes
                                          footerIdentifiers:footerIdentifiers
                                                footerSizes:footerSizes];
}
- (instancetype)initWithCollectionViewStyles:(NSArray <NSNumber *>*)collectionViewStyles
                             cellIdentifiers:(NSArray <NSArray <NSString *>*> *)cellIdentifiers
                              cellClassNames:(NSArray <NSArray <NSString *>*> *)cellClassNames
                                   cellSizes:(NSArray <NSArray <NSNumber *>*> *)cellSizes
                           headerIdentifiers:(nullable NSArray <NSString *> *)headerIdentifiers
                                 headerSizes:(nullable NSArray <NSNumber *> *)headerSizes
                           footerIdentifiers:(nullable NSArray <NSString *> *)footerIdentifiers
                                 footerSizes:(nullable NSArray <NSNumber *> *)footerSizes {
    if (self = [super init]) {
        NSMutableArray *dataSourceArray = [NSMutableArray arrayWithCapacity:10];
        for (NSInteger section = 0; section < cellIdentifiers.count; section++) {
            WRCollectionViewDataSource *dataSource = [WRCollectionViewDataSource new];
            dataSource.collectionViewStyle = collectionViewStyles[section].integerValue;
            NSMutableArray *objectsArray = [NSMutableArray arrayWithCapacity:10];
            NSString *headerIdentifier = headerIdentifiers[section];
            if (![NSObject wr_isEmtpty:headerIdentifier]) {
                WRCollectionViewObject *header = [WRCollectionViewObject new];
                header.type = WRCollectionViewObjectType_Header;
                header.identifier = headerIdentifier;
                header.size = headerSizes[section].integerValue;
                [objectsArray addObject:header];
            }
            for (NSInteger item = 0; item < cellIdentifiers[section].count; item++) {
                WRCollectionViewObject *cell = [WRCollectionViewObject new];
                cell.type = WRCollectionViewObjectType_Cell;
                cell.identifier = cellIdentifiers[section][item];
                cell.cellClassName = cellClassNames[section][item];
                cell.size = cellSizes[section][item].integerValue;
                [objectsArray addObject:cell];
            }
            NSString *footerIdentifier = footerIdentifiers[section];
            if (![NSObject wr_isEmtpty:footerIdentifier]) {
                WRCollectionViewObject *footer = [WRCollectionViewObject new];
                footer.type = WRCollectionViewObjectType_Footer;
                footer.identifier = footerIdentifier;
                footer.size = footerSizes[section].integerValue;
                [objectsArray addObject:footer];
            }
            dataSource.objectsArray = objectsArray;
            [dataSourceArray addObject:dataSource];
        }
        self.layout = [[WRCollectionViewLayout alloc] initWithDataSourcesArray:dataSourceArray
                                                           collectionViewStyle:collectionViewStyles.firstObject.integerValue];
    }
    return self;
}
- (void)didMoveToSuperview {
    if (self.superview != nil) {
        self.collectionView.hidden = NO;
    }
}
#pragma mark - UICollectionView委托
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.layout.dataSourcesArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    WRCollectionViewDataSource *dataSource = self.layout.dataSourcesArray[section];
    return dataSource.cellObjectsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WRCollectionViewDataSource *dataSource = self.layout.dataSourcesArray[indexPath.section];
    WRCollectionViewObject *object = dataSource.cellObjectsArray[indexPath.item];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:object.identifier forIndexPath:indexPath];
    if (self.loadedCellBlock) {
        self.loadedCellBlock(collectionView, cell, indexPath);
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WRCollectionViewDataSource *dataSource = self.layout.dataSourcesArray[indexPath.section];
    UICollectionReusableView *view;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        WRCollectionViewObject *headerObject = dataSource.headerObject;
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                  withReuseIdentifier:headerObject.identifier
                                                         forIndexPath:indexPath];
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        WRCollectionViewObject *footerObject = dataSource.footerObject;
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                  withReuseIdentifier:footerObject.identifier
                                                         forIndexPath:indexPath];
    }
    return view;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionViewCellDidSelectedBlock) {
        self.collectionViewCellDidSelectedBlock(collectionView, indexPath);
    }
}
#pragma mark - UIScrollView委托
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.wr_scrollViewDidEndDeceleratingBlock) {
        self.wr_scrollViewDidEndDeceleratingBlock(scrollView);
    }
}
#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = self.wr_showsHorizontalScrollIndicator;
        _collectionView.showsVerticalScrollIndicator = self.wr_showsVerticalScrollIndicator;
        
        NSMutableSet *cellIdentifierSet = [NSMutableSet setWithCapacity:2];
        NSMutableDictionary *cellClassNameDic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        NSMutableSet *headerIdentifierSet = [NSMutableSet setWithCapacity:1];
        NSMutableDictionary *headerClassNameDic = [NSMutableDictionary dictionaryWithCapacity:1];
        
        NSMutableSet *footerIdentifierSet = [NSMutableSet setWithCapacity:1];
        NSMutableDictionary *footerClassNameDic = [NSMutableDictionary dictionaryWithCapacity:1];
        
        for (WRCollectionViewDataSource *dataSource in self.layout.dataSourcesArray) {
            for (WRCollectionViewObject *object in dataSource.objectsArray) {
                switch (object.type) {
                    case WRCollectionViewObjectType_Cell:
                        [cellIdentifierSet addObject:object.identifier];
                        [cellClassNameDic setObject:object.cellClassName forKey:object.identifier];
                        break;
                    case WRCollectionViewObjectType_Header:
                        [headerIdentifierSet addObject:object.identifier];
                        headerClassNameDic[object.identifier] = object.cellClassName;
                        break;
                    case WRCollectionViewObjectType_Footer:
                        [footerIdentifierSet addObject:object.identifier];
                        footerClassNameDic[object.identifier] = object.cellClassName;
                        break;
                }
            }
        }
        
        for (NSInteger i = 0; i < cellIdentifierSet.count; i++) {
            NSString *cellIdentifier = cellIdentifierSet.allObjects[i];
            NSString *cellClassName = cellClassNameDic[cellIdentifier];
            [_collectionView registerClass:NSClassFromString(cellClassName) forCellWithReuseIdentifier:cellIdentifier];
        }
        for (NSInteger i = 0; i < headerIdentifierSet.count; i++) {
            NSString *headerIdentifier = headerIdentifierSet.allObjects[i];
            NSString *headerClassName = headerClassNameDic[headerIdentifier];
            [_collectionView registerClass:NSClassFromString(headerClassName)
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:headerIdentifier];
        }
        for (NSInteger i = 0; i < footerIdentifierSet.count; i++) {
            NSString *footerIdentifier = footerIdentifierSet.allObjects[i];
            NSString *footerClassName = footerClassNameDic[footerIdentifier];
            [_collectionView registerClass:NSClassFromString(footerClassName)
                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                       withReuseIdentifier:footerIdentifier];
        }
        
        [self addSubview:_collectionView];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem: _collectionView
                                                                          attribute: NSLayoutAttributeLeft
                                                                          relatedBy: NSLayoutRelationEqual
                                                                             toItem: self
                                                                          attribute: NSLayoutAttributeLeft
                                                                         multiplier: 1.0
                                                                           constant: 0];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem: _collectionView
                                                                         attribute: NSLayoutAttributeTop
                                                                         relatedBy: NSLayoutRelationEqual
                                                                            toItem: self
                                                                         attribute: NSLayoutAttributeTop
                                                                        multiplier: 1.0
                                                                          constant: 0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem: _collectionView
                                                                           attribute: NSLayoutAttributeRight
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: self
                                                                           attribute: NSLayoutAttributeRight
                                                                          multiplier: 1.0
                                                                            constant: 0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem: _collectionView
                                                                            attribute: NSLayoutAttributeBottom
                                                                            relatedBy: NSLayoutRelationEqual
                                                                               toItem: self
                                                                            attribute: NSLayoutAttributeBottom
                                                                           multiplier: 1.0
                                                                             constant: 0];
        [self addConstraints:@[
                               leftConstraint,
                               topConstraint,
                               rightConstraint,
                               bottomConstraint
                               ]
         ];
        
    }
    return _collectionView;
}

@end

