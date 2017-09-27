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
    
//    [self installTableView];
}
- (void)installCollectionView {
    WRCollectionViewObject *obj0 = [WRCollectionViewObject new];
    obj0.type = WRCollectionViewObjectType_Header;
    obj0.identifier = @"header";
    obj0.headerSize = 50;
    
    WRCollectionViewObject *obj1 = [WRCollectionViewObject new];
    obj1.type = WRCollectionViewObjectType_Footer;
    obj1.identifier = @"footer";
    obj1.footerSize = 50;

    
    
}
- (void)installTableView {
    WRTableViewCellObject *object1 = [WRTableViewCellObject new];
    object1.identifier = @"1";
    object1.cellClassName = NSStringFromClass(WRTableViewCell.class);
    object1.height = 50;
    
    WRTableViewCellObject *object2 = [WRTableViewCellObject new];
    object2.identifier = @"1";
    object2.cellClassName = NSStringFromClass(WRTableViewCell.class);
    object2.height = 50;
    
    WRTableViewDataSource *dataSource = [WRTableViewDataSource new];
    dataSource.objectsArray = [NSMutableArray arrayWithArray:@[@[
                                                                   object1,
                                                                   object2
                                                                   ]
                                                               ]];
    dataSource.tableViewHeaderViewHeight = 100;
    
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
