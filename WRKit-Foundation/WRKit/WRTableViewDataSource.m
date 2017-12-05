//
//  WRTableViewDataSource.m
//  WRTableView
//
//  Created by xianghui on 2017/11/30.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRTableViewDataSource.h"

static NSString * const kWRTableViewCellIdentifier = @"kWRTableViewCellIdentifier";
static NSString * const kWRTableViewHeaderIdentifier = @"kWRTableViewHeaderIdentifier";
static NSString * const kWRTableViewFooterIdentifier = @"kWRTableViewFooterIdentifier";

#pragma mark - WRTableViewItem
@implementation WRTableViewItem
- (instancetype)init {
    if (self = [super init]) {
        self.identifier = kWRTableViewCellIdentifier;
        self.cellClass = [UITableViewCell class];
        self.height = 44;
    }
    return self;
}
@end
#pragma mark - WRTableViewSection
@implementation WRTableViewSection
- (instancetype)initWithItems:(NSArray <WRTableViewItem *> *)items {
    if (self = [self init]) {
        _itemsArray = items;
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        self.headerClass = [UITableViewHeaderFooterView class];
        self.footerClass = [UITableViewHeaderFooterView class];
        self.headerHeight = 0.1;
        self.footerHeight = 0.1;
        self.headerIdentifier = kWRTableViewHeaderIdentifier;
        self.footerIdentifier = kWRTableViewFooterIdentifier;
   }
    return self;
}
@end
#pragma mark - WRTableViewDataSource
@implementation WRTableViewDataSource

- (instancetype)initWithSections:(NSArray <WRTableViewSection *> *)sections {
    if (self = [super init]) {
        _sectionsArray = sections;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
