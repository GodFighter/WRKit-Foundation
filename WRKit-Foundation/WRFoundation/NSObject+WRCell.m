//
//  NSObject+WRCell.m
//  DelehiLivingStream
//
//  Created by xianghui on 2018/3/21.
//  Copyright © 2018年 xianghui. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+WRCell.h"

static char wrCellSizeKey;
static char wrCellReuseIdentifierKey;
static char wrCellClassKey;

@implementation NSObject (WRCell)

@dynamic wr_reuseIdentifier;
@dynamic wr_cellSize;
@dynamic wr_cellClass;

- (void)setWr_reuseIdentifier:(NSString *)wr_reuseIdentifier {
    objc_setAssociatedObject(self, &wrCellReuseIdentifierKey, wr_reuseIdentifier, OBJC_ASSOCIATION_COPY);
}
- (NSString *)wr_reuseIdentifier {
    return objc_getAssociatedObject(self, &wrCellReuseIdentifierKey);
}
- (void)setWr_cellSize:(CGFloat)wr_cellSize {
    objc_setAssociatedObject(self, &wrCellSizeKey, [NSNumber numberWithFloat:wr_cellSize], OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)wr_cellSize {
    return [objc_getAssociatedObject(self, &wrCellSizeKey) floatValue];
}
- (void)setWr_cellClass:(Class)wr_cellClass {
    objc_setAssociatedObject(self, &wrCellClassKey, wr_cellClass, OBJC_ASSOCIATION_ASSIGN);
}
- (Class)wr_cellClass {
    return objc_getAssociatedObject(self, &wrCellClassKey);
}
@end
