//
//  UITextField+WRConvenience.h
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/** 便利构造 */
@interface UITextField (WRConvenience)

/** 初始化文本框
 @param textColor 文本颜色
 @param placeholder 占位符
 @param font 字体
 @param leftIndent 左缩进
 @return 文本框
 */
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                                leftIndent:(CGFloat)leftIndent;
/** 初始化文本框
 @param textColor 文本颜色
 @param placeholderColor 占位符颜色
 @param borderColor 边框颜色
 @param placeholder 占位符
 @param font 字体
 @param borderWidth 边框宽
 @param radius 圆角
 @param showBorder 是否显示边框
 @param leftIndent 左缩进
 @return 文本框
 */
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               borderColor:(nullable UIColor *)borderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                               borderWidth:(CGFloat)borderWidth
                                    radius:(CGFloat)radius
                                showBorder:(BOOL)showBorder
                                leftIndent:(CGFloat)leftIndent;
/** 初始化文本框
 @param textColor 文本颜色
 @param placeholderColor 占位符颜色
 @param placeholder 占位符
 @param font 字体
 @param leftIndent 左缩进
 @return 文本框
 */
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                                leftIndent:(CGFloat)leftIndent;
/** 初始化文本框
 @param textColor 文本颜色
 @param placeholderColor 占位符颜色
 @param placeholder 占位符
 @param font 字体
 @param leftIndent 左缩进
 @param clearButtonMode 清空按钮样式
 @param secureTextEntry 密码输入
 @return 文本框
 */
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                                leftIndent:(CGFloat)leftIndent
                           clearButtonMode:(UITextFieldViewMode)clearButtonMode
                           secureTextEntry:(BOOL)secureTextEntry;
/** 初始化文本框
 @param textColor 文本颜色
 @param placeholderColor 占位符颜色
 @param borderColor 边框颜色
 @param placeholder 占位符
 @param font 字体
 @param borderWidth 边框宽
 @param radius 圆角
 @param showBorder 是否显示边框
 @param leftIndent 左缩进
 @param clearButtonMode 清空按钮样式
 @param secureTextEntry 密码输入
 @return 文本框
 */
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               borderColor:(nullable UIColor *)borderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                               borderWidth:(CGFloat)borderWidth
                                    radius:(CGFloat)radius
                                showBorder:(BOOL)showBorder
                                leftIndent:(CGFloat)leftIndent
                           clearButtonMode:(UITextFieldViewMode)clearButtonMode
                           secureTextEntry:(BOOL)secureTextEntry;

NS_ASSUME_NONNULL_END
@end
