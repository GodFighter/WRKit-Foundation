//
//  NSObject+WRCell.h
//  DelehiLivingStream
//
//  Created by xianghui on 2018/3/21.
//  Copyright © 2018年 xianghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/** cell 类类目 */
@interface NSObject (WRCell)
/** cell重用id */
@property (copy, nonatomic) NSString *wr_reuseIdentifier;
/** cell 尺寸 */
@property (assign, nonatomic) CGFloat wr_cellSize;
/** cell 类 */
@property (assign, nonatomic) Class wr_cellClass;

@end
