//
//  NSObject+WRJudge.m
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSObject+WRJudge.h"

@implementation NSObject (WRJudge)

+ (BOOL)wr_isEmtpty:(NSObject *)object {
    if (object == nil ||
        [object isEqual:nil] ||
        [object isEqual:Nil] ||
        object == NULL ||
        [object isEqual:@"NULL"] ||
        [object isKindOfClass:[NSNull class]] ||
        [object isEqual:NULL] ||
        [[object class] isSubclassOfClass:[NSNull class]] ||
        [object isEqual:[NSNull null]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 ||
            [string isEqualToString:@"<null>"] ||
            [string isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    if ([object isKindOfClass:[NSData class]]) {
        NSData *data = (NSData *)object;
        return data.length <= 0;
    }
    if ([object isKindOfClass:[NSDictionary class]] ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSSet class]]) {
        return [(NSArray *)object count] <= 0;
    }
    return NO;
}
@end
