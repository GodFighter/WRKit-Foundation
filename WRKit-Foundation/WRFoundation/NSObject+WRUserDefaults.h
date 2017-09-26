//
//  NSObject+WRUserDefault.h
//  WRKitDemo
//
//  Created by xianghui on 2017/9/26.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/** NSUserDefaults 存取 */
@interface NSObject (WRUserDefaults)
/**  存储的值
 * @param key key
 * @return 存储的值
 */
+ (nullable id)objectWithKey:(NSString *)key;
/** 存储
 * @param object 存储对象
 * @param key key
 */
+ (void)saveObject:(nullable id)object forKey:(NSString *)key;
NS_ASSUME_NONNULL_END
@end
