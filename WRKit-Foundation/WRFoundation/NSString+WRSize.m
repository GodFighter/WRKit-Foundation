//
//  NSString+WRSize.m
//  WRKitDemo
//
//  Created by xianghui on 2017/10/20.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSString+WRSize.h"

@implementation NSString (WRSize)

- (CGFloat)wr_heightWithFont:(UIFont *)font
                       width:(CGFloat)width {
    return [self wr_heightWithFont:font width:width paragraphStyle:nil];
}
- (CGFloat)wr_heightWithFont:(UIFont *)font
                       width:(CGFloat)width
              paragraphStyle:(nullable NSMutableParagraphStyle *)paragraphStyle {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary * attributes;
    if (paragraphStyle != nil) {
        attributes = @{ NSFontAttributeName : font , NSParagraphStyleAttributeName : paragraphStyle};
    } else {
        attributes = @{ NSFontAttributeName : font };
    }
    size = [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:attributes context:nil].size;
    return size.height;
}
- (CGFloat)wr_widthWithFont:(UIFont *)font
                     height:(CGFloat)height {
    return [self wr_widthWithFont:font height:height paragraphStyle:nil];
}
- (CGFloat)wr_widthWithFont:(UIFont *)font
                     height:(CGFloat)height
             paragraphStyle:(nullable NSMutableParagraphStyle *)paragraphStyle {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSDictionary * attributes;
    if (paragraphStyle != nil) {
        attributes = @{ NSFontAttributeName : font , NSParagraphStyleAttributeName : paragraphStyle};
    } else {
        attributes = @{ NSFontAttributeName : font };
    }
    size = [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:attributes context:nil].size;
    return size.width + 1;
}


@end
