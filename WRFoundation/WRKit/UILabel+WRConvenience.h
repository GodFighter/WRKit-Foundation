//
//  UILabel+WRConvenience.h
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/** 便利构造 */
@interface UILabel (WRConvenience)

/** 初始化标签
 @param textColor 文本颜色
 @param font 文本字体
 @return 按钮
 */
+ (UILabel *)wr_labelWithTextColor:(nullable UIColor *)textColor
                              font:(nullable UIFont *)font;
/** 初始化标签
 @param textColor 文本颜色
 @param textAlignment 对齐方式
 @param font 文本字体
 @return 按钮
 */
+ (UILabel *)wr_labelWithTextColor:(nullable UIColor *)textColor
                     textAlignment:(NSTextAlignment)textAlignment
                              font:(nullable UIFont *)font;


NS_ASSUME_NONNULL_END
@end
