//
//  WRTableView.m
//  WRTableView
//
//  Created by xianghui on 2017/11/30.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRTableView.h"

@interface WRTableView () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) WRTableViewDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@end
@implementation WRTableView

- (instancetype)initWithDataSource:(WRTableViewDataSource *)dataSource {
    if (self = [super init]) {
        self.dataSource = dataSource;
    }
    return self;
}
#pragma mark - public
- (void)update {
    [self.tableView reloadData];
}
- (void)updateDataSource {
    [self registerTableView];
    [self.tableView reloadData];
}
#pragma mark - view
- (void)didMoveToSuperview {
    if (self.superview != nil) {
        self.tableView.hidden = NO;
    }
}
#pragma mark - private
- (void)setDataSource:(WRTableViewDataSource *)dataSource {
    _dataSource = dataSource;
    [self registerTableView];
}
// 注册表视图
- (void)registerTableView {
    NSMutableSet *headerIdSet = [NSMutableSet set];
    NSMutableDictionary *headerClassDic = [NSMutableDictionary dictionaryWithCapacity:2];
    NSMutableSet *footerIdSet = [NSMutableSet set];
    NSMutableDictionary *footerClassDic = [NSMutableDictionary dictionaryWithCapacity:2];
    NSMutableSet *cellIdSet = [NSMutableSet set];
    NSMutableDictionary *cellClassDic = [NSMutableDictionary dictionaryWithCapacity:2];

    // 查找所有需要注册的头尾和cell
    for (WRTableViewSection *section in self.dataSource.sectionsArray) {
        [headerIdSet addObject:section.headerIdentifier];
        [headerClassDic setObject:section.headerClass forKey:section.headerIdentifier];
        [footerIdSet addObject:section.footerIdentifier];
        [footerClassDic setObject:section.footerClass forKey:section.footerIdentifier];
        for (WRTableViewItem *item in section.itemsArray) {
            [cellIdSet addObject:item.identifier];
            [cellClassDic setObject:item.cellClass forKey:item.identifier];
        }
    }
    // cell注册
    for (NSInteger i = 0; i < cellIdSet.count; i++) {
        NSString *cellId = cellIdSet.allObjects[i];
        [self.tableView registerClass:cellClassDic[cellId] forCellReuseIdentifier:cellId];
    }
    // 注册头
    for (NSInteger i = 0; i < headerIdSet.count; i++) {
        NSString *headerId = headerIdSet.allObjects[i];
        [self.tableView registerClass:headerClassDic[headerId] forHeaderFooterViewReuseIdentifier:headerId];
    }
    // 注册尾
    for (NSInteger i = 0; i < footerIdSet.count; i++) {
        NSString *footerId = footerIdSet.allObjects[i];
        [self.tableView registerClass:footerClassDic[footerId] forHeaderFooterViewReuseIdentifier:footerId];
    }
}
#pragma mark - UITableView 委托
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    WRTableViewSection *sectionObject = self.dataSource.sectionsArray[section];
    return sectionObject.headerHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WRTableViewSection *sectionObject = self.dataSource.sectionsArray[section];
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionObject.headerIdentifier];
    view.contentView.backgroundColor = [UIColor clearColor];
    if (self.loadedHeaderBlock) {
        self.loadedHeaderBlock(tableView, view, section);
    }
   return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    WRTableViewSection *sectionObject = self.dataSource.sectionsArray[section];
    return sectionObject.footerHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WRTableViewSection *sectionObject = self.dataSource.sectionsArray[section];
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionObject.footerIdentifier];
    view.contentView.backgroundColor = [UIColor clearColor];
    if (self.loadedFooterBlock) {
        self.loadedFooterBlock(tableView, view, section);
    }
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionsArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WRTableViewSection *sectionObject = self.dataSource.sectionsArray[section];
    return sectionObject.itemsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WRTableViewSection *section = self.dataSource.sectionsArray[indexPath.section];
    WRTableViewItem *item = section.itemsArray[indexPath.item];
    return item.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WRTableViewSection *section = self.dataSource.sectionsArray[indexPath.section];
    WRTableViewItem *item = section.itemsArray[indexPath.item];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.identifier];
    cell.backgroundColor = [UIColor clearColor];
    if (self.loadedCellBlock) {
        self.loadedCellBlock(tableView, cell, indexPath, item.object);
    }
    return cell;
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = tableView;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_tableView];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
