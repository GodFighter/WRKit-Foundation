//
//  UITextField+WRConvenience.m
//  WRKitDemo
//
//  Created by 项辉 on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRFoundation.h"
#import "UITextField+WRConvenience.h"

@implementation UITextField (WRConvenience)

+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                                leftIndent:(CGFloat)leftIndent {
    UITextField *textField = [self wr_textFieldWithTextColor:textColor
                                            placeholderColor:nil
                                                 borderColor:nil
                                                 placeholder:placeholder
                                                        font:font
                                                 borderWidth:0
                                                      radius:0
                                                  showBorder:NO
                                                  leftIndent:leftIndent
                                             clearButtonMode:UITextFieldViewModeNever
                                             secureTextEntry:NO];
    return textField;
}
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               borderColor:(nullable UIColor *)borderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                               borderWidth:(CGFloat)borderWidth
                                    radius:(CGFloat)radius
                                showBorder:(BOOL)showBorder
                                leftIndent:(CGFloat)leftIndent {
    UITextField *textField = [self wr_textFieldWithTextColor:textColor
                                            placeholderColor:placeholderColor
                                                 borderColor:borderColor
                                                 placeholder:placeholder
                                                        font:font
                                                 borderWidth:0
                                                      radius:0
                                                  showBorder:NO
                                                  leftIndent:leftIndent
                                             clearButtonMode:UITextFieldViewModeNever
                                             secureTextEntry:NO];
    return textField;
}
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                                leftIndent:(CGFloat)leftIndent {
    UITextField *textField = [self wr_textFieldWithTextColor:textColor
                                            placeholderColor:placeholderColor
                                                 borderColor:nil
                                                 placeholder:placeholder
                                                        font:font
                                                 borderWidth:0
                                                      radius:0
                                                  showBorder:NO
                                                  leftIndent:leftIndent
                                             clearButtonMode:UITextFieldViewModeNever
                                             secureTextEntry:NO];
    return textField;
}
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                                leftIndent:(CGFloat)leftIndent
                           clearButtonMode:(UITextFieldViewMode)clearButtonMode
                           secureTextEntry:(BOOL)secureTextEntry {
    UITextField *textField = [self wr_textFieldWithTextColor:textColor
                                            placeholderColor:placeholderColor
                                                 borderColor:nil
                                                 placeholder:placeholder
                                                        font:font
                                                 borderWidth:0
                                                      radius:0
                                                  showBorder:NO
                                                  leftIndent:leftIndent
                                             clearButtonMode:clearButtonMode
                                             secureTextEntry:secureTextEntry];
    return textField;
}
+ (UITextField *)wr_textFieldWithTextColor:(nullable UIColor *)textColor
                          placeholderColor:(nullable UIColor *)placeholderColor
                               borderColor:(nullable UIColor *)borderColor
                               placeholder:(nullable NSString *)placeholder
                                      font:(nullable UIFont *)font
                               borderWidth:(CGFloat)borderWidth
                                    radius:(CGFloat)radius
                                showBorder:(BOOL)showBorder
                                leftIndent:(CGFloat)leftIndent
                           clearButtonMode:(UITextFieldViewMode)clearButtonMode
                           secureTextEntry:(BOOL)secureTextEntry {
    UITextField *textField = [UITextField new];
    if (![NSObject wr_isEmtpty:textColor]) {
        textField.textColor = textColor;
    }
    if (![NSString wr_isEmtpty:font]) {
        textField.font = font;
    }
    if (![NSObject wr_isEmtpty:placeholder]) {
        if (![NSObject wr_isEmtpty:placeholderColor]) {
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                              attributes:@{NSForegroundColorAttributeName: placeholderColor}];
        } else {
            textField.placeholder = placeholder;
        }
    }
    textField.secureTextEntry = secureTextEntry;
    if (showBorder) {
        textField.layer.borderColor = borderColor.CGColor;
        textField.layer.borderWidth = borderWidth;
        textField.layer.cornerRadius = radius;
    }
    if (leftIndent > 0) {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftIndent, 1)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    textField.clearButtonMode = clearButtonMode;
    return textField;
}

@end
