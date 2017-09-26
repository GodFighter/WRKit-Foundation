//
//  UIButton+WRConvenience.m
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRFoundation.h"
#import "UIButton+WRConvenience.h"
#import "UILabel+WRSize.h"
#import "UIImage+WRConvenience.h"

@implementation UIButton (WRConvenience)

+ (UIButton *)wr_buttonWithBGImageName:(NSString *)bgImageName {
    UIButton *button = [self wr_buttonWithBGImageName:bgImageName
                                            imageName:nil
                                                title:nil
                                          normalColor:nil
                                     highlightedColor:nil
                                        selectedColor:nil
                                                 font:nil
                                         imageIsRight:NO
                                              offsize:0
                                         cornerRadius:0];
    return button;
}
+ (UIButton *)wr_buttonWithImageName:(NSString *)imageName {
    UIButton *button = [self wr_buttonWithBGImageName:nil
                                            imageName:imageName
                                                title:nil
                                          normalColor:nil
                                     highlightedColor:nil
                                        selectedColor:nil
                                                 font:nil
                                         imageIsRight:NO
                                              offsize:0
                                         cornerRadius:0];
    return button;
}
+ (UIButton *)wr_buttonWithBgNormalColor:(UIColor *)bgNormalColor
                      bgHighlightedColor:(UIColor *)bgHighlightedColor
                                   title:(nullable NSString *)title
                             normalColor:(nullable UIColor *)normalColor
                        highlightedColor:(nullable UIColor *)highlightedColor
                                    font:(nullable UIFont *)font {
    UIImage *bgNormalImage = [UIImage wr_imageWithColor:bgNormalColor];
    UIImage *bgHighlightImage = [UIImage wr_imageWithColor:bgHighlightedColor];
    
    UIButton *button = [self wr_buttonWithBGImageName:nil
                                            imageName:nil
                                                title:title
                                          normalColor:normalColor
                                     highlightedColor:highlightedColor
                                        selectedColor:nil
                                                 font:font
                                         imageIsRight:NO
                                              offsize:0
                                         cornerRadius:0];
    [button setBackgroundImage:[bgNormalImage stretchableImageWithLeftCapWidth:bgNormalImage.size.width / 2
                                                                  topCapHeight:bgNormalImage.size.height / 2]
                      forState:UIControlStateNormal];
    [button setBackgroundImage:[bgHighlightImage stretchableImageWithLeftCapWidth:bgHighlightImage.size.width / 2
                                                                     topCapHeight:bgHighlightImage.size.height / 2]
                      forState:UIControlStateHighlighted];
    return button;
}
+ (UIButton *)wr_buttonWithTitle:(nullable NSString *)title
                     normalColor:(nullable UIColor *)normalColor
                highlightedColor:(nullable UIColor *)highlightedColor
                            font:(nullable UIFont *)font {
    UIButton *button = [self wr_buttonWithBGImageName:nil
                                            imageName:nil
                                                title:title
                                          normalColor:normalColor
                                     highlightedColor:highlightedColor
                                        selectedColor:nil
                                                 font:font
                                         imageIsRight:NO
                                              offsize:0
                                         cornerRadius:0];
    return button;
}
+ (UIButton *)wr_buttonWithTitle:(nullable NSString *)title
                     normalColor:(nullable UIColor *)normalColor
                highlightedColor:(nullable UIColor *)highlightedColor
                   selectedColor:(nullable UIColor *)selectedColor
                            font:(nullable UIFont *)font {
    UIButton *button = [self wr_buttonWithBGImageName:nil
                                            imageName:nil
                                                title:title
                                          normalColor:normalColor
                                     highlightedColor:highlightedColor
                                        selectedColor:selectedColor
                                                 font:font
                                         imageIsRight:NO
                                              offsize:0
                                         cornerRadius:0];
    return button;
}
+ (UIButton *)wr_buttonWithBGImageName:(nullable NSString *)bgImageName
                                 title:(nullable NSString *)title
                           normalColor:(nullable UIColor *)normalColor
                      highlightedColor:(nullable UIColor *)highlightedColor
                                  font:(nullable UIFont *)font
                          cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [self wr_buttonWithBGImageName:bgImageName
                                            imageName:nil
                                                title:title
                                          normalColor:normalColor
                                     highlightedColor:highlightedColor
                                        selectedColor:nil
                                                 font:font
                                         imageIsRight:NO
                                              offsize:0
                                         cornerRadius:cornerRadius];
    return button;
}
+ (UIButton *)wr_buttonWithBGImageName:(NSString *)bgImageName
                             imageName:(NSString *)imageName
                                 title:(NSString *)title
                           normalColor:(UIColor *)normalColor
                      highlightedColor:(UIColor *)highlightedColor
                                  font:(UIFont *)font
                          cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [self wr_buttonWithBGImageName:bgImageName
                                            imageName:imageName
                                                title:title
                                          normalColor:normalColor
                                     highlightedColor:highlightedColor
                                        selectedColor:nil
                                                 font:font
                                         imageIsRight:NO
                                              offsize:0
                                         cornerRadius:cornerRadius];
    
    return button;
}

+ (UIButton *)wr_buttonWithBGImageName:(nullable NSString *)bgImageName
                             imageName:(nullable NSString *)imageName
                                 title:(nullable NSString *)title
                           normalColor:(nullable UIColor *)normalColor
                      highlightedColor:(nullable UIColor *)highlightedColor
                         selectedColor:(nullable UIColor *)selectedColor
                                  font:(nullable UIFont *)font
                          imageIsRight:(BOOL)imageIsRight
                               offsize:(CGFloat)offsize
                          cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (![NSObject wr_isEmtpty:bgImageName]) {
        UIImage *normalBGImage = [UIImage imageNamed:bgImageName];
        if (normalBGImage != nil) {
            [button setBackgroundImage:normalBGImage forState:UIControlStateNormal];
        }
        NSString *highlightedBGImageName = [bgImageName stringByAppendingString:@"Highlighted"];
        UIImage *highlightedBGImage = [UIImage imageNamed:highlightedBGImageName];
        if (highlightedBGImage != nil) {
            [button setBackgroundImage:highlightedBGImage forState:UIControlStateHighlighted];
        }
        NSString *selectedBGImageName = [bgImageName stringByAppendingString:@"Selected"];
        UIImage *selectedBGImage = [UIImage imageNamed:selectedBGImageName];
        if (selectedBGImage != nil) {
            [button setBackgroundImage:selectedBGImage forState:UIControlStateSelected];
        }
    }
    if (![NSObject wr_isEmtpty:imageName]) {
        UIImage *normalImage = [UIImage imageNamed:imageName];
        if (normalImage != nil) {
            [button setImage:normalImage forState:UIControlStateNormal];
        }
        NSString *highlightedImageName = [imageName stringByAppendingString:@"Highlighted"];
        UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
        if (highlightedImage != nil) {
            [button setImage:highlightedImage forState:UIControlStateHighlighted];
        }
        NSString *selectedImageName = [imageName stringByAppendingString:@"Selected"];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        if (selectedImage != nil) {
            [button setImage:selectedImage forState:UIControlStateSelected];
        }
    }
    if (![NSObject wr_isEmtpty:title]) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (![NSObject wr_isEmtpty:normalColor]) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (![NSObject wr_isEmtpty:highlightedColor]) {
        [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    }
    if (![NSObject wr_isEmtpty:font]) {
        button.titleLabel.font = font;
    }
    if (![NSObject wr_isEmtpty:selectedColor]) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (cornerRadius > 0) {
        button.clipsToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    // 只有同时存在图片和文字时，才存在交换,如果offsize==0，并且图片在左，也没必要执行交换方法
    if (button.currentImage != nil && ![NSObject wr_isEmtpty:button.titleLabel.text] && (offsize > 0 || imageIsRight)) {
        if (imageIsRight) {
            CGFloat titleWidth = button.titleLabel.wr_width;
            CGFloat imageWidth = button.currentImage.size.width;
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth + offsize, 0, -titleWidth - offsize)];
        } else {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, offsize, 0, 0)];
        }
    }
    
    return button;
}
@end
