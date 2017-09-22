//
//  ViewController.m
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "WRKit.h"
#import "WRFoundation.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *string = @"12948200508";
    NSLog(@"%d",string.wr_isPhoneNumber);
    ;
    NSLog(@"%ld==%ld==%ld",(long)[NSDate date].day, (long)[NSDate date].month, (long)[NSDate date].weekday);
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
