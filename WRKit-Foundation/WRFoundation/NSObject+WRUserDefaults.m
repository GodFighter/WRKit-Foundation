//
//  NSObject+WRUserDefault.m
//  WRKitDemo
//
//  Created by xianghui on 2017/9/26.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSObject+WRUserDefaults.h"

@implementation NSObject (WRUserDefaults)

+ (nullable id)wr_objectWithKey:(NSString *)key {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] != nil) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return nil;
}
+ (void)wr_saveObject:(nullable id)object forKey:(NSString *)key {
    if (object != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
