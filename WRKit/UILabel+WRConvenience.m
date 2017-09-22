//
//  UILabel+WRConvenience.m
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRFoundation.h"
#import "UILabel+WRConvenience.h"

@implementation UILabel (WRConvenience)

+ (UILabel *)wr_labelWithTextColor:(nullable UIColor *)textColor
                              font:(nullable UIFont *)font {
    return [self wr_labelWithTextColor:textColor textAlignment:NSTextAlignmentLeft font:font];
}
+ (UILabel *)wr_labelWithTextColor:(nullable UIColor *)textColor
                     textAlignment:(NSTextAlignment)textAlignment
                              font:(nullable UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    if (![NSObject wr_isEmtpty:textColor]) {
        label.textColor = textColor;
    }
    if (![NSObject wr_isEmtpty:font]) {
        label.font = font;
    }
    label.textAlignment = textAlignment;
    
    return label;
}
@end
