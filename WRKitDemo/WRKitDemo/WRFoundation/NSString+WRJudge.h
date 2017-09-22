//
//  NSString+WRJudge.h
//  WRKitDemo
//
//  Created by xianghui on 2017/8/18.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 字符串判断 */
@interface NSString (WRJudge)
/** 判断是否为电话号码 */
- (BOOL)wr_isPhoneNumber;
/** 判断是否为邮箱 */
- (BOOL)wr_isEmailAddress;

@end
