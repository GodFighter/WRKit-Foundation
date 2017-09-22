//
//  UIImage+WRConvenience.m
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "UIImage+WRConvenience.h"

@implementation UIImage (WRConvenience)

+ (UIImage*)wr_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (nullable UIImageView *)wr_imageViewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    if (image == nil) {
        return nil;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.userInteractionEnabled = YES;
    return imageView;
}
@end
