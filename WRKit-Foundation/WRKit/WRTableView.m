//
//  WRTableView.m
//  WRKitDemo
//
//  Created by xianghui on 2017/9/26.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSObject+WRJudge.h"
#import "WRTableView.h"

static NSString * const kWRTableViewCellIdentifier = @"kWRTableViewCellIdentifier";

#pragma mark -
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
@implementation WRTableViewCellObject

- (instancetype)init {
    if (self = [super init]) {
        self.identifier = kWRTableViewCellIdentifier;
        self.height = 44;
        self.cellClassName = NSStringFromClass(UITableViewCell.class);
    }
    return self;
}

@end

#pragma mark -
@interface WRTableViewDataSource : NSObject
/** 对象数组
 @note 包含 WRTableViewCellObject 实例的数组
 */
@property (strong, nonatomic) NSArray <NSArray <WRTableViewCellObject *> *> *objectsArray;
/** 表视图头视图高度数组 */
@property (strong, nonatomic) NSArray <NSNumber *>* headerHeightsArray;
/** 表视图尾视图高度数组 */
@property (strong, nonatomic) NSArray <NSNumber *>* footerHeightsArray;

@end
@implementation WRTableViewDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.objectsArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}
@end

#pragma mark -
@interface WRTableView () <UITableViewDelegate, UITableViewDataSource>
/** 数据源 */
@property (strong, nonatomic) WRTableViewDataSource *dataSource;
@end

@implementation WRTableView

- (instancetype)initSingleSectionSingleCellIdentifier:(NSString *)cellIdentifier
                                        cellClassName:(nullable NSString *)cellClassName
                                           cellHeight:(CGFloat)cellHeight
                                            cellCount:(NSInteger)cellCount {
    return [[self.class alloc] initSingleSectionSingleCellIdentifier:cellIdentifier
                                                       cellClassName:cellClassName
                                                          cellHeight:cellHeight
                                                           cellCount:cellCount
                                                        headerHeight:0
                                                        footerHeight:0];
    
}
- (instancetype)initSingleSectionSingleCellIdentifier:(NSString *)cellIdentifier
                                        cellClassName:(nullable NSString *)cellClassName
                                           cellHeight:(CGFloat)cellHeight
                                            cellCount:(NSInteger)cellCount
                                         headerHeight:(CGFloat)headerHeight
                                         footerHeight:(CGFloat)footerHeight {
    NSMutableArray *identifiersArray = [NSMutableArray arrayWithCapacity:cellCount];
    NSMutableArray *classNamesArray = [NSMutableArray arrayWithCapacity:cellCount];
    NSMutableArray *heightsArray = [NSMutableArray arrayWithCapacity:cellCount];
    for (NSInteger index = 0; index < cellCount; index++) {
        [identifiersArray addObject:cellIdentifier];
        [classNamesArray addObject:[NSObject wr_isEmtpty:cellClassName] ? NSStringFromClass(UITableViewCell.class) : cellClassName];
        [heightsArray addObject:cellHeight == 0 ? @(44) : @(cellHeight)];
    }
    return [[self.class alloc] initWithCellIdentifiers:@[identifiersArray]
                                        cellClassNames:@[classNamesArray]
                                            cellHeight:@[heightsArray]
                                         headerHeights:@[@(headerHeight)]
                                         footerHeights:@[@(footerHeight)]];
}
- (instancetype)initMultiSectionSingleCellIdentifier:(NSString *)cellIdentifier
                                       cellClassName:(nullable NSString *)cellClassName
                                          cellHeight:(CGFloat)cellHeight
                                           cellCount:(NSArray <NSNumber *> *)cellCounts
                                       headerHeights:(nullable NSArray <NSNumber *>*)headerHeights
                                       footerHeights:(nullable NSArray <NSNumber *>*)footerHeights {
    NSMutableArray *identifiersArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *classNamesArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    NSMutableArray *heightsArray = [NSMutableArray arrayWithCapacity:cellCounts.count];
    
    for (NSInteger section = 0; section < cellCounts.count; section++) {
        NSMutableArray *sectionIdentifiers = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *sectionClassNames = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *sectionHeights = [NSMutableArray arrayWithCapacity:1];
        for (NSInteger index = 0; index < cellCounts[section].integerValue; index++) {
            [sectionIdentifiers addObject:cellIdentifier];
            [sectionClassNames addObject:[NSObject wr_isEmtpty:cellClassName] ? NSStringFromClass(UITableViewCell.class) : cellClassName];
            [sectionHeights addObject:cellHeight == 0 ? @(44) : @(cellHeight)];
        }
        [identifiersArray addObject:sectionIdentifiers];
        [classNamesArray addObject:sectionClassNames];
        [heightsArray addObject:sectionHeights];
    }
    return [[self.class alloc] initWithCellIdentifiers:identifiersArray
                                        cellClassNames:classNamesArray
                                            cellHeight:heightsArray
                                         headerHeights:headerHeights
                                         footerHeights:footerHeights];
}
- (instancetype)initWithCellIdentifiers:(NSArray <NSArray <NSString *>*>*)cellIdentifiers
                         cellClassNames:(NSArray <NSArray <NSString *>*>*)cellClassNames
                             cellHeight:(NSArray <NSArray <NSNumber *>*>*)cellHeights
                          headerHeights:(nullable NSArray <NSNumber *>*)headerHeights
                          footerHeights:(nullable NSArray <NSNumber *>*)footerHeights {
    if (self = [super init]) {
        WRTableViewDataSource *dataSource = [WRTableViewDataSource new];
        NSMutableArray *objectsArray = [NSMutableArray arrayWithCapacity:cellIdentifiers.count];
        for (NSInteger section = 0; section < cellIdentifiers.count; section++) {
            NSMutableArray *sectionsArray = [NSMutableArray arrayWithCapacity:cellIdentifiers[section].count];
            for (NSInteger item = 0; item < cellIdentifiers[section].count; item++) {
                WRTableViewCellObject *cellObject = [WRTableViewCellObject new];
                cellObject.identifier = cellIdentifiers[section][item];
                cellObject.cellClassName = cellClassNames[section][item];
                cellObject.height = cellHeights[section][item].floatValue;
                [sectionsArray addObject:cellObject];
            }
            [objectsArray addObject:sectionsArray];
        }
        dataSource.objectsArray = objectsArray;
        dataSource.headerHeightsArray = headerHeights;
        dataSource.footerHeightsArray = footerHeights;
        self.dataSource = dataSource;
    }
    return self;
}
- (void)didMoveToSuperview {
    if (self.superview != nil) {
        self.tableView.hidden = NO;
    }
}
- (nullable WRTableViewCellObject *)objectForIndexpath:(NSIndexPath *)indexPath {
    if (self.dataSource.objectsArray.count <= indexPath.section ||
        [self.dataSource.objectsArray[indexPath.section] count] < indexPath.item) {
        return nil;
    }
    NSArray *sectionArray = self.dataSource.objectsArray[indexPath.section];
    WRTableViewCellObject *cellObject = sectionArray[indexPath.item];
    return cellObject;
}
- (void)setHeaderViewIdentifier:(NSArray<NSString *> *)headerViewIdentifier {
    _headerViewIdentifier = headerViewIdentifier;
    if (_headerViewIdentifier.count == self.headerViewClassName.count) {
        for (NSInteger i = 0; i < headerViewIdentifier.count; i++) {
            [_tableView registerClass:NSClassFromString(self.headerViewClassName[i]) forHeaderFooterViewReuseIdentifier:_headerViewIdentifier[i]];
        }
    }
}
- (void)setHeaderViewClassName:(NSArray<NSString *> *)headerViewClassName {
    _headerViewClassName = headerViewClassName;
    if (_headerViewClassName.count == self.headerViewIdentifier.count) {
        for (NSInteger i = 0; i < _headerViewClassName.count; i++) {
            [_tableView registerClass:NSClassFromString(_headerViewClassName[i]) forHeaderFooterViewReuseIdentifier:self.headerViewIdentifier[i]];
        }
    }
}
- (void)setFooterViewIdentifier:(NSArray<NSString *> *)footerViewIdentifier {
    _footerViewIdentifier = footerViewIdentifier;
    if (_footerViewIdentifier.count == self.footerViewClassName.count) {
        for (NSInteger i = 0; i < _footerViewIdentifier.count; i++) {
            [_tableView registerClass:NSClassFromString(self.footerViewClassName[i]) forHeaderFooterViewReuseIdentifier:self.footerViewIdentifier[i]];
        }
    }
}
- (void)setFooterViewClassName:(NSArray<NSString *> *)footerViewClassName {
    _footerViewClassName = footerViewClassName;
    if (_footerViewClassName.count == self.footerViewIdentifier.count) {
        for (NSInteger i = 0; i < _footerViewClassName.count; i++) {
            [_tableView registerClass:NSClassFromString(_footerViewClassName[i]) forHeaderFooterViewReuseIdentifier:self.footerViewIdentifier[i]];
        }
    }
}
#pragma mark - UITableView 委托
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < self.dataSource.headerHeightsArray.count) {
        CGFloat sectionHeaderheight = self.dataSource.headerHeightsArray[section].floatValue;
        return sectionHeaderheight <= 0 ? 0.1 : sectionHeaderheight;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section < self.dataSource.footerHeightsArray.count) {
        CGFloat sectionFooterheight = self.dataSource.footerHeightsArray[section].floatValue;
        return sectionFooterheight <= 0 ? 0.1 : sectionFooterheight;
    }
    return 0.1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.headerViewIdentifier.count > section) {
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerViewIdentifier[section]];
        if (self.loadedHeaderBlock) {
            self.loadedHeaderBlock(tableView, view, section);
        }
        return view;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.footerViewIdentifier.count > section) {
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerViewIdentifier[section]];
        if (self.loadedFooterBlock) {
            self.loadedFooterBlock(tableView, view, section);
        }
        return view;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.objectsArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.dataSource.objectsArray[section];
    return sectionArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WRTableViewCellObject *cellObject = [self objectForIndexpath:indexPath];
    if ([NSObject wr_isEmtpty:cellObject]) {
        return 44;
    }
    return cellObject.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WRTableViewCellObject *cellObject = [self objectForIndexpath:indexPath];
    NSString *identifier = kWRTableViewCellIdentifier;
    if (![NSObject wr_isEmtpty:cellObject]) {
        identifier = cellObject.identifier;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.loadedCellBlock) {
        self.loadedCellBlock(tableView, cell, indexPath);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewCellDidSelectedBlock) {
        self.tableViewCellDidSelectedBlock(tableView, indexPath);
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}
#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = contentTableView;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        NSMutableSet *cellIdentifierSet = [NSMutableSet setWithCapacity:2];
        NSMutableDictionary *cellClassNameDic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        for (NSArray *objectsArray in self.dataSource.objectsArray) {
            for (WRTableViewCellObject *cellObject in objectsArray) {
                [cellIdentifierSet addObject:cellObject.identifier];
                [cellClassNameDic setObject:cellObject.cellClassName forKey:cellObject.identifier];
            }
        }
        for (NSInteger i = 0; i < cellIdentifierSet.count; i++) {
            NSString *cellIdentifier = cellIdentifierSet.allObjects[i];
            NSString *cellClassName = cellClassNameDic[cellIdentifier];
            [_tableView registerClass:NSClassFromString(cellClassName) forCellReuseIdentifier:cellIdentifier];
        }
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];

        [self addSubview:_tableView];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem: _tableView
                                                                          attribute: NSLayoutAttributeLeft
                                                                          relatedBy: NSLayoutRelationEqual
                                                                             toItem: self
                                                                          attribute: NSLayoutAttributeLeft
                                                                         multiplier: 1.0
                                                                           constant: 0];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem: _tableView
                                                                          attribute: NSLayoutAttributeTop
                                                                          relatedBy: NSLayoutRelationEqual
                                                                             toItem: self
                                                                          attribute: NSLayoutAttributeTop
                                                                         multiplier: 1.0
                                                                           constant: 0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem: _tableView
                                                                         attribute: NSLayoutAttributeRight
                                                                         relatedBy: NSLayoutRelationEqual
                                                                            toItem: self
                                                                         attribute: NSLayoutAttributeRight
                                                                        multiplier: 1.0
                                                                          constant: 0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem: _tableView
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
    return _tableView;
}
- (WRTableViewDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [WRTableViewDataSource new];
    }
    return _dataSource;
}
@end
