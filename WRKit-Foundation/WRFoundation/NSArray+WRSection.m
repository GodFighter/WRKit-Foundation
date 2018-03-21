//
//  NSArray+WRSection.m
//  DelehiLivingStream
//
//  Created by xianghui on 2018/3/21.
//  Copyright © 2018年 xianghui. All rights reserved.
//

#import <objc/runtime.h>
#import "NSArray+WRSection.h"

static char wrSectionHeaderSizeKey;
static char wrSectionFooterSizeKey;
static char wrSectionHeaderClassKey;
static char wrSectionFooterClassKey;
static char wrSectionHeaderReuseIdentifierKey;
static char wrSectionFooterReuseIdentifierKey;
static char wrSectionCollectionViewStyleKey;

@implementation NSArray (WRSection)

@dynamic wr_sectionHeaderSize;
@dynamic wr_sectionFooterSize;
@dynamic wr_sectionHeaderClass;
@dynamic wr_sectionFooterClass;
@dynamic wr_headerReuseIdentifier;
@dynamic wr_footerReuseIdentifier;
@dynamic wr_collectionViewStyle;

- (void)setwr_sectionHeaderSize:(CGFloat)wr_sectionHeaderSize {
    objc_setAssociatedObject(self, &wrSectionHeaderSizeKey, [NSNumber numberWithFloat:wr_sectionHeaderSize], OBJC_ASSOCIATION_ASSIGN);
}
- (void)setWr_sectionFooterSize:(CGFloat)wr_sectionFooterSize {
    objc_setAssociatedObject(self, &wrSectionFooterSizeKey, [NSNumber numberWithFloat:wr_sectionFooterSize], OBJC_ASSOCIATION_ASSIGN);
}
- (void)setwr_sectionHeaderClass:(Class)wr_sectionHeaderClass {
    objc_setAssociatedObject(self, &wrSectionHeaderClassKey, wr_sectionHeaderClass, OBJC_ASSOCIATION_ASSIGN);
}
- (void)setWr_sectionFooterClass:(Class)wr_sectionFooterClass {
    objc_setAssociatedObject(self, &wrSectionFooterClassKey, wr_sectionFooterClass, OBJC_ASSOCIATION_ASSIGN);
}
- (void)setwr_headerReuseIdentifier:(NSString *)wr_headerReuseIdentifier {
    objc_setAssociatedObject(self, &wrSectionHeaderReuseIdentifierKey, wr_headerReuseIdentifier, OBJC_ASSOCIATION_COPY);
}
- (void)setWr_footerReuseIdentifier:(NSString *)wr_footerReuseIdentifier {
    objc_setAssociatedObject(self, &wrSectionFooterReuseIdentifierKey, wr_footerReuseIdentifier, OBJC_ASSOCIATION_COPY);
}
- (void)setWr_collectionViewStyle:(WRCollectionViewStyle22)wr_collectionViewStyle {
    objc_setAssociatedObject(self, &wrSectionCollectionViewStyleKey, [NSNumber numberWithFloat:wr_collectionViewStyle], OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)wr_sectionHeaderSize {
    return [objc_getAssociatedObject(self, &wrSectionHeaderSizeKey) floatValue];
}
- (CGFloat)wr_sectionFooterSize {
    return [objc_getAssociatedObject(self, &wrSectionFooterSizeKey) floatValue];
}
- (Class)wr_sectionHeaderClass {
    return objc_getAssociatedObject(self, &wrSectionHeaderClassKey);;
}
- (Class)wr_sectionFooterClass {
    return objc_getAssociatedObject(self, &wrSectionFooterClassKey);;
}
- (NSString *)wr_headerReuseIdentifier {
    return objc_getAssociatedObject(self, &wrSectionHeaderReuseIdentifierKey);;
}
- (NSString *)wr_footerReuseIdentifier {
    return objc_getAssociatedObject(self, &wrSectionFooterReuseIdentifierKey);;
}
- (NSInteger)isWr_collectionViewStyle {
    return [objc_getAssociatedObject(self, &wrSectionCollectionViewStyleKey) integerValue];
}
@end
