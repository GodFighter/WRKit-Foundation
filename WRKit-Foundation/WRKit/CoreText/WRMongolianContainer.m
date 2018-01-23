//
//  WRMongolianContainer.m
//  WRKitDemo
//
//  Created by xianghui on 2017/10/16.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSObject+WRJudge.h"
#import "WRMongolianContainer.h"

@implementation WRMongolianContainer

- (instancetype)init {
    if (self = [super init]) {
        _font = [UIFont systemFontOfSize:15];
        _linesArray = [NSMutableArray arrayWithCapacity:10];
        _lineSpacing = 0;
        _textColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setText:(NSString *)text {
    _text = text;
    if (CGSizeEqualToSize(self.displaySize, CGSizeZero)) {
        return;
    }
    [self parseCoreTextContent];
}
- (void)setDisplaySize:(CGSize)displaySize {
    _displaySize = displaySize;
    if ([NSObject wr_isEmtpty:self.text]) {
        return;
    }
    [self parseCoreTextContent];
}
- (void)setFont:(UIFont *)font {
    _font = font;
    if (CGSizeEqualToSize(self.displaySize, CGSizeZero) || [NSObject wr_isEmtpty:self.text]) {
        return;
    }
    [self parseCoreTextContent];
}
- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    if (CGSizeEqualToSize(self.displaySize, CGSizeZero) || [NSObject wr_isEmtpty:self.text]) {
        return;
    }
    [self parseCoreTextContent];
}
- (NSAttributedString *)drawString {
    if (self.linesArray.count == 0) {
        return nil;
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.text
                                                                               attributes:@{
                                                                                            NSFontAttributeName : self.font,
                                                                                            NSForegroundColorAttributeName : self.textColor
                                                                                            }];
    [string addAttributes:@{NSForegroundColorAttributeName : self.highlightColor} range:self.highlightRange];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.displayLineCount >= self.linesArray.count - 1 ? NSLineBreakByWordWrapping :  NSLineBreakByTruncatingTail;
    
    WRLine *line = self.linesArray[MIN(self.displayLineCount, self.linesArray.count - 1)];

    [string addAttributes:@{NSParagraphStyleAttributeName : paragraphStyle} range:line.range];
    return string;
}
#pragma private
- (void)parseCoreTextContent {
    [self.linesArray removeAllObjects];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.text
                                                                              attributes:@{
                                                                                           NSFontAttributeName : self.font
                                                                                           }];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)string);
    CGPathRef pathRef = CGPathCreateWithRect(CGRectMake(0,
                                                        0,
                                                        self.displaySize.width,
                                                        self.displaySize.height),
                                             &CGAffineTransformIdentity);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    
    CFArrayRef lineArray = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lineArray);
    _displayLineCount = lineCount;
    BOOL firstGreater = NO;
    
    CGPoint originArray[lineCount];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), originArray);
    
    CGFloat currentWidth = fabs(self.font.descender);
    for (NSInteger i = 0; i < lineCount; i++) {
        WRLine *line = [WRLine new];
        line.index = i;
        line.ctLine = CFArrayGetValueAtIndex(lineArray, i);
        currentWidth += self.font.lineHeight + self.lineSpacing;
        // 第一次超过绘制边界的行，为最后可以显示的一行
        if (firstGreater == NO && currentWidth > self.displaySize.height) {
            _displayLineCount = i - 1;
            firstGreater = YES;
        }
        line.range = NSMakeRange(CTLineGetStringRange(line.ctLine).location, CTLineGetStringRange(line.ctLine).length);
        line.origin = originArray[i];
        
        [self.linesArray addObject:line];
    }
}
@end
