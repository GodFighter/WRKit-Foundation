//
//  UITextField+WRContentChanged.m
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "UIControl+WRBlocks.h"
#import "UITextField+WRContentChanged.h"

@implementation UITextField (WRContentChanged)

- (void)wr_addTextChangedBlock:(nullable void (^)(void))success {
    [self wr_addEventHandler:^(id sender) {
        if (self.markedTextRange == nil) {
            success();
        }
    } forControlEvents:UIControlEventEditingChanged];
}

@end
