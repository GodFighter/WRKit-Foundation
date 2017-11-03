//
//  UIButton+WRExpand.m
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <objc/runtime.h>
#import "UIButton+WRExpand.h"

static char wrExpandWidthKey;
static char wrExpandHeightKey;
static char wrExpandSizeKey;

@implementation UIButton (WRExpand)

- (void)wr_expandWidth:(CGFloat)width {
    objc_setAssociatedObject(self, &wrExpandWidthKey, [NSNumber numberWithFloat:width], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)wr_expandHeight:(CGFloat)height {
    objc_setAssociatedObject(self, &wrExpandHeightKey, [NSNumber numberWithFloat:height], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)wr_expandSize:(CGFloat)size {
    objc_setAssociatedObject(self, &wrExpandSizeKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGRect)expandRect {
    NSNumber *expandSize = objc_getAssociatedObject(self, &wrExpandSizeKey);

    if (expandSize) {
        return CGRectMake(self.bounds.origin.x - expandSize.floatValue,
                          self.bounds.origin.y - expandSize.floatValue,
                          self.bounds.size.width + expandSize.floatValue + expandSize.floatValue,
                          self.bounds.size.height + expandSize.floatValue + expandSize.floatValue);
    } else {
        NSNumber *expandWidth = objc_getAssociatedObject(self, &wrExpandWidthKey);
        NSNumber *expandHeight = objc_getAssociatedObject(self, &wrExpandHeightKey);
        if (expandWidth || expandHeight) {
            CGFloat x = self.bounds.origin.x;
            CGFloat y = self.bounds.origin.y;
            CGFloat width = self.bounds.size.width;
            CGFloat height = self.bounds.size.height;
            
            if (expandWidth) {
                x -= expandWidth.floatValue;
                width += (expandWidth.floatValue + expandWidth.floatValue);
            } else if (expandHeight) {
                y -= expandHeight.floatValue;
                height += (expandHeight.floatValue + expandHeight.floatValue);
            }
            return CGRectMake(x, y, width, height);
        } else {
            return self.bounds;
        }
    }
}
//响应用户的点击事件
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect buttonRect = [self expandRect];
    if (CGRectEqualToRect(buttonRect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(buttonRect, point) ? YES : NO;
}

@end
