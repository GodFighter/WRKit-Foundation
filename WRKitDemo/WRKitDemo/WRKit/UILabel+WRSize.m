//
//  UILabel+WRSize.m
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "UILabel+WRSize.h"

@implementation UILabel (WRSize)

- (CGFloat)wr_width {
    CGSize size = CGSizeMake(MAXFLOAT, self.font.lineHeight);
    NSDictionary * attributes = @{ NSFontAttributeName : self.font };
    size = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                attributes:attributes
                                   context:nil].size;
    return size.width;
}
- (CGFloat)wr_height {
    CGSize size = CGSizeMake(self.frame.size.width, MAXFLOAT);
    NSDictionary * attributes = @{ NSFontAttributeName : self.font };
    size =[self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attributes context:nil].size;
    return size.height;
}

@end
