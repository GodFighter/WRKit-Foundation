//
//  NSObject+WRJudge.h
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 判断 */
@interface NSObject (WRJudge)

/** 判断对象是否为空
 @param object 判空对象
 @return 是否为空
 */
+ (BOOL)wr_isEmtpty:(NSObject *)object;

@end
