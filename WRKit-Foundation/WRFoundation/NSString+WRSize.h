//
//  NSString+WRSize.h
//  WRKitDemo
//
//  Created by xianghui on 2017/10/20.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 字符串的尺寸 */
@interface NSString (WRSize)
/** 指定字体和宽度时获取字符串高度 */
- (CGFloat)wr_heightWithFont:(UIFont *)font
                       width:(CGFloat)width;
/** 指定字体和宽度,字符串属性时获取字符串高度 */
- (CGFloat)wr_heightWithFont:(UIFont *)font
                       width:(CGFloat)width
              paragraphStyle:(nullable NSMutableParagraphStyle *)paragraphStyle;
/** 指定字体和高度时获取字符串宽度 */
- (CGFloat)wr_widthWithFont:(UIFont *)font
                     height:(CGFloat)height;
/** 指定字体和高度,字符串属性时获取字符串宽度 */
- (CGFloat)wr_widthWithFont:(UIFont *)font
                     height:(CGFloat)height
             paragraphStyle:(nullable NSMutableParagraphStyle *)paragraphStyle;

NS_ASSUME_NONNULL_END
@end
