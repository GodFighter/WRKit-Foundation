//
//  UITextField+WRContentChanged.h
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 文本发生变化 */
@interface UITextField (WRContentChanged)
/** 文本内容变化回调 */
- (void)wr_addTextChangedBlock:(nullable void (^)())success;

@end
