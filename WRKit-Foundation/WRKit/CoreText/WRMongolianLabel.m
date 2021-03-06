//
//  WR MongolianLabel.m
//  WRKitDemo
//
//  Created by xianghui on 2017/10/16.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSString+WRSize.h"
#import "WRMongolianContainer.h"

#import "WRMongolianLabel.h"

@interface WRMongolianLabel ()
@property (strong, nonatomic) WRMongolianContainer *container; // 绘制内容容器

@end

@implementation WRMongolianLabel
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setText:(NSString *)text {
    _text = text;
    if (CGSizeEqualToSize(self.container.displaySize, CGSizeZero)) {
        self.container.displaySize = CGSizeMake(self.frame.size.height, self.frame.size.width);
        if (CGSizeEqualToSize(self.container.displaySize, CGSizeZero)) {
            self.container.displaySize = CGSizeMake([text wr_widthWithFont:_font height:_font.lineHeight], ceil(_font.lineHeight));
        }
    }
    self.container.text = text;
    [self setNeedsDisplay];
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.container.displaySize = CGSizeMake(frame.size.height, frame.size.width);
    [self setNeedsDisplay];
//    NSLog(@"%@--%@",[NSValue valueWithCGSize:self.container.displaySize], [NSValue valueWithCGRect:frame]);
}
- (void)layoutSubviews {
    self.container.displaySize = CGSizeMake(self.frame.size.height, self.frame.size.width);
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font {
    _font = font;
    self.container.font = font;
    [self setNeedsDisplay];
}
- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    self.container.lineSpacing = lineSpacing;
    [self setNeedsDisplay];
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.container.textColor = textColor;
    [self setNeedsDisplay];
}
- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
    self.container.highlightColor = highlightColor;
    [self setNeedsLayout];
}
- (void)setHighlightRange:(NSRange)highlightRange {
    _highlightRange = highlightRange;
    self.container.highlightRange = highlightRange;
    [self setNeedsLayout];
}
#pragma mark - 懒加载
- (WRMongolianContainer *)container {
    if (_container == nil) {
        _container = [WRMongolianContainer new];
    }
    return _container;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.text == nil) {
        return;
    }
    [self wr_drawRect];
}
- (void)wr_drawRect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    
    NSAttributedString *string = self.container.drawString;

    if (string == nil) {
        return;
    }
    
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)string);
    CGPathRef pathRef = CGPathCreateWithRect(CGRectMake(0,
                                                        0,
                                                        self.container.displaySize.width,
                                                        self.container.displaySize.height),
                                             &CGAffineTransformIdentity);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    
    CFArrayRef lineArray = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lineArray);

    CGContextSaveGState(context); {
        for (CFIndex i = 0; i < lineCount; ++i) {
            WRLine *line = self.container.linesArray[i];
            CTLineRef ctLine = CFArrayGetValueAtIndex(lineArray, i);
            
            CFArrayRef runArray = CTLineGetGlyphRuns(ctLine);
            CFIndex runCount = CFArrayGetCount(runArray);
            for (CFIndex j = 0; j < runCount; ++j) {
                CTRunRef run = CFArrayGetValueAtIndex(runArray, j);
                CGContextSetTextPosition(context, line.origin.x, line.origin.y);
                if (i > self.container.displayLineCount) {
                    return;
                }
                CATransform3D transform3d = CATransform3DMakeAffineTransform(CGAffineTransformIdentity);
                transform3d = CATransform3DRotate(transform3d, M_PI_2 * 3, 0, 0, 1);
                CGAffineTransform transform = CATransform3DGetAffineTransform(transform3d);
                CGContextSetTextMatrix(context, transform);
                CGContextSetTextPosition(context, fabs(self.container.font.descender) + i * (self.container.font.lineHeight + self.container.lineSpacing), 0);
                CTRunDraw(run, context, CFRangeMake(0, 0));

            }
        }
    } CGContextRestoreGState(context);
}
@end
