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
@implementation WRTableViewDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.dataSourceArray = [NSMutableArray arrayWithCapacity:10];
        self.cellIdentiferArray = [NSMutableArray arrayWithObject:kWRTableViewCellIdentifier];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    if (self.dataSource.cellHeightArray.count > 0) {
        height = [self.dataSource.cellHeightArray.firstObject floatValue];
        if (self.dataSource.cellHeightArray.count > indexPath.item) {
            height = [self.dataSource.cellHeightArray[indexPath.item] floatValue];
        }
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWRTableViewCellIdentifier];
//    cell.backgroundColor = [UIColor blueColor];
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
        [_tableView registerClass:[NSObject wr_isEmtpty:self.dataSource.cellClassName] ? [UITableViewCell class] : NSClassFromString(self.dataSource.cellClassName)
           forCellReuseIdentifier:kWRTableViewCellIdentifier];
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
- (nonnull NSString *)cellIdentifierWiithIndexPath:(NSIndexPath *)indexPath {
    return kWRTableViewCellIdentifier;
}
@end
