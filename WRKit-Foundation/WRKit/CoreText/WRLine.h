//
//  WRLine.h
//  WRKitDemo
//
//  Created by xianghui on 2017/10/16.
//  Copyright © 2017年 xianghui. All rights reserved.
//
#import <CoreText/CoreText.h>
#import <Foundation/Foundation.h>
/** 绘制行 */
@interface WRLine : NSObject
/** coreText 行 */
@property (assign, nonatomic) CTLineRef ctLine;
/** 范围 */
@property (assign, nonatomic) NSRange range;
/** 行坐标 */
@property (assign, nonatomic) CGPoint origin;
/** 行索引 */
@property (assign, nonatomic) NSUInteger index;

@end
