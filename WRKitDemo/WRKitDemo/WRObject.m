//
//  WRObject.m
//  WRKitDemo
//
//  Created by xianghui on 2017/11/3.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRObject.h"
#import "WRTableViewCell.h"

@interface WRObject () {
    CGFloat _height;
    NSString *_identifier;
    Class _cellClass;
}

@end

@implementation WRObject

- (void)setHeight:(CGFloat)height {
    _height = height;
}
- (CGFloat)height {
    return 10;
}
- (void)setIdentifier:(NSString *)identifier {
    _identifier = identifier;
}
- (NSString *)identifier {
    return @"header2";
}
- (void)setCellClass:(Class)cellClass {
    _cellClass = cellClass;
}
- (Class)cellClass {
    return WRTableViewCell.class;
}

@end
