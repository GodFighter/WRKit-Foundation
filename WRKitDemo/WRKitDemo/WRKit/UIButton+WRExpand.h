//
//  UIButton+WRExpand.h
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 按钮响应范围扩展 */
@interface UIButton (WRExpand)

/** 扩展宽 */
- (void)wr_expandWidth:(CGFloat)width;
/** 扩展高 */
- (void)wr_expandHeight:(CGFloat)height;
/** 扩展宽高 */
- (void)wr_expandSize:(CGFloat)size;

@end
