//
//  WRTableViewCell.m
//  WRKitDemo
//
//  Created by xianghui-iMac on 2017/9/26.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRTableViewCell.h"

@implementation WRTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
