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
#import "WRTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *string = @"12948200508";
    NSLog(@"%d",string.wr_isPhoneNumber);
    ;
    NSLog(@"%ld==%ld==%ld",(long)[NSDate date].day, (long)[NSDate date].month, (long)[NSDate date].weekday);
    
    self.view.backgroundColor = [UIColor redColor];
    WRTableViewDataSource *dataSource = [WRTableViewDataSource new];
    dataSource.dataSourceArray = [NSMutableArray arrayWithArray:@[@"1", @"2"]];
    dataSource.cellHeightArray = [NSMutableArray arrayWithArray:@[@"100", @"30"]];
    dataSource.cellClassName = NSStringFromClass(WRTableViewCell.class);
    
    WRTableView *tableView = [[WRTableView alloc] init];
    tableView.dataSource = dataSource;
    
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    tableView.tableViewCellDidSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {

    };
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
