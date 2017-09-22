//
//  UIButton+WRConvenience.h
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/** 便利构造 */
@interface UIButton (WRConvenience)
/** 根据背景图初始化
 @param bgImageName 背景图
 @return 按钮
 */
+ (UIButton *)wr_buttonWithBGImageName:(NSString *)bgImageName;
/** 根据图片初始化
 @param imageName 图片
 @return 按钮
 */
+ (UIButton *)wr_buttonWithImageName:(NSString *)imageName;
/** 根据背景色标题初始化
 @param bgNormalColor 正常背景色
 @param bgHighlightedColor 高亮背景色
 @param title 标题
 @param normalColor 正常标题颜色
 @param highlightedColor 高亮标题颜色
 @param font 字体
 @return 按钮
 */
+ (UIButton *)wr_buttonWithBgNormalColor:(UIColor *)bgNormalColor
                      bgHighlightedColor:(UIColor *)bgHighlightedColor
                                   title:(nullable NSString *)title
                             normalColor:(nullable UIColor *)normalColor
                        highlightedColor:(nullable UIColor *)highlightedColor
                                    font:(nullable UIFont *)font;
/** 根据标题初始化
 @param title 标题
 @param normalColor 正常文字颜色
 @param highlightedColor 高亮文字颜色
 @param font 字体
 @return 按钮
 */
+ (UIButton *)wr_buttonWithTitle:(nullable NSString *)title
                     normalColor:(nullable UIColor *)normalColor
                highlightedColor:(nullable UIColor *)highlightedColor
                            font:(nullable UIFont *)font;
/** 根据标题初始化
 @param title 标题
 @param normalColor 正常文字颜色
 @param highlightedColor 高亮文字颜色
 @param selectedColor 选中文字颜色
 @param font 字体
 @return 按钮
 */
+ (UIButton *)wr_buttonWithTitle:(nullable NSString *)title
                     normalColor:(nullable UIColor *)normalColor
                highlightedColor:(nullable UIColor *)highlightedColor
                   selectedColor:(nullable UIColor *)selectedColor
                            font:(nullable UIFont *)font;
/** 根据背景图和标题创建button
 @note 图片为背景视图，默认高亮名字+Highlight，选中图片名字+Selected
 
 @param bgImageName 背景图
 @param title 标题
 @param normalColor 正常文字颜色
 @param highlightedColor 高亮文字颜色
 @param font 字体
 @param cornerRadius 圆角，默认0
 
 @return 按钮
 */
+ (UIButton *)wr_buttonWithBGImageName:(nullable NSString *)bgImageName
                                 title:(nullable NSString *)title
                           normalColor:(nullable UIColor *)normalColor
                      highlightedColor:(nullable UIColor *)highlightedColor
                                  font:(nullable UIFont *)font
                          cornerRadius:(CGFloat)cornerRadius;
/** 根据背景图、图片和标题创建button
 @note 图片默认高亮名字+Highlighted，选中图片名字+Selected
 
 @param bgImageName 背景图
 @param imageName 按钮图
 @param title 标题
 @param normalColor 正常文字颜色
 @param highlightedColor 高亮文字颜色
 @param font 字体
 @param cornerRadius 圆角，默认0
 
 @return 按钮
 */
+ (UIButton *)wr_buttonWithBGImageName:(nullable NSString *)bgImageName
                             imageName:(nullable NSString *)imageName
                                 title:(nullable NSString *)title
                           normalColor:(nullable UIColor *)normalColor
                      highlightedColor:(nullable UIColor *)highlightedColor
                                  font:(nullable UIFont *)font
                          cornerRadius:(CGFloat)cornerRadius;
/** 最复杂的按钮创建，可以指定任何属性
 @note 图片默认高亮名字+Highlighted，选中图片名字+Selected
 
 @param bgImageName 背景图
 @param imageName 按钮图
 @param title 标题
 @param normalColor 正常文字颜色
 @param highlightedColor 高亮文字颜色
 @param font 字体
 @param imageIsRight 图片是否在右
 @param offsize 图片和文字的偏移量
 @param cornerRadius 圆角，默认0
 
 @return 按钮
 */
+ (UIButton *)wr_buttonWithBGImageName:(nullable NSString *)bgImageName
                             imageName:(nullable NSString *)imageName
                                 title:(nullable NSString *)title
                           normalColor:(nullable UIColor *)normalColor
                      highlightedColor:(nullable UIColor *)highlightedColor
                         selectedColor:(nullable UIColor *)selectedColor
                                  font:(nullable UIFont *)font
                          imageIsRight:(BOOL)imageIsRight
                               offsize:(CGFloat)offsize
                          cornerRadius:(CGFloat)cornerRadius;
NS_ASSUME_NONNULL_END
@end
