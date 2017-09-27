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

@end

@implementation WRTableView

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
#pragma mark - UITableView 委托
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
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
        _tableView.backgroundColor = [UIColor orangeColor];
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
