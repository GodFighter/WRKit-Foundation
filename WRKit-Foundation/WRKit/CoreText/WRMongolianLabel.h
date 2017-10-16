//
//  WR MongolianLabel.h
//  WRKitDemo
//
//  Created by xianghui on 2017/10/16.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 蒙文标签 */
@interface WRMongolianLabel : UIView
/** 文本 */
@property (strong, nonatomic) NSString *text;
/** 字体 */
@property (strong, nonatomic) UIFont *font;
/** 行间距 */
@property (assign, nonatomic) CGFloat lineSpacing;

@end
