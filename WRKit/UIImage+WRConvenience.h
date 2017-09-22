//
//  UIImage+WRConvenience.h
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/** 便利构造图片 */
@interface UIImage (WRConvenience)
/** 根据颜色构造图片 */
+ (UIImage*)wr_imageWithColor:(UIColor *)color;
/** 根据图片名初始化 */
+ (nullable UIImageView *)wr_imageViewWithImageName:(NSString *)imageName;
NS_ASSUME_NONNULL_END
@end
