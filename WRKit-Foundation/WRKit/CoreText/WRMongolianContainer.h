//
//  WRMongolianContainer.h
//  WRKitDemo
//
//  Created by xianghui on 2017/10/16.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WRLine.h"

/** 蒙文绘制容器 */
@interface WRMongolianContainer : NSObject
/** 行数组 */
@property (strong, nonatomic) NSMutableArray *linesArray;
/** 字体 */
@property (strong, nonatomic) UIFont *font;
/** 文本 */
@property (strong, nonatomic) NSString *text;
/** 显示范围 */
@property (assign, nonatomic) CGSize displaySize;
/** 行间距 默认 0 */
@property (assign, nonatomic) CGFloat lineSpacing;
/** 绘制的字符串 */
@property (strong, nonatomic, readonly) NSAttributedString *drawString;
/** 显示的行数 */
@property (assign, nonatomic, readonly) NSUInteger displayLineCount;

@end
