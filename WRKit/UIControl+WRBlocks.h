//
//  UIControl+WRBlocks.h
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 添加blocks */
@interface UIControl (WRBlocks)

/** 添加blocks
 @param handler block
 @param controlEvents UIControlEvents枚举
 */
- (void)wr_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@end
