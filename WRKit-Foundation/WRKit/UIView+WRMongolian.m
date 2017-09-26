//
//  UIView+WRMongolian.m
//  TextDemo2
//
//  Created by xianghui on 2017/9/25.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+WRMongolian.h"

static char wrMongolianTransformKey;

@implementation UIView (WRMongolian)

- (void)wr_mongolian {
    objc_setAssociatedObject(self, &wrMongolianTransformKey, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)layoutSubviews {
    if ([objc_getAssociatedObject(self, &wrMongolianTransformKey) boolValue]) {
        self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
        if ([self.class isEqual:[UILabel class]]) {
            self.transform = CGAffineTransformTranslate(self.transform,
                                                        (self.frame.size.height - self.frame.size.width) / 2,
                                                        (self.frame.size.height - self.frame.size.width) / 2);
        } else {
            CATransform3D transform3d = CATransform3DMakeAffineTransform(self.transform);
            self.layer.transform = CATransform3DRotate(transform3d, M_PI, 1, 0, 0);
            
            self.layer.transform = CATransform3DTranslate(self.layer.transform,
                                                          (self.frame.size.height - self.frame.size.width) / 2,
                                                          (self.frame.size.width - self.frame.size.height) / 2,
                                                          0);
        }

        objc_setAssociatedObject(self, &wrMongolianTransformKey, [NSNumber numberWithBool:NO], OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
}

@end
