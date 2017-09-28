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
#import "WRCollectionViewCell.h"

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
    [self installCollectionView];
}
- (void)installCollectionView {
    WRCollectionView *collectionView = [[WRCollectionView alloc] initSingleSectionMultiCellStyle:WRCollectionViewStyle_Portrait
                                                                                 cellIdentifiers:@[
                                                                                                   @"cell1",
                                                                                                   @"cell2",
                                                                                                   @"cell3",
                                                                                                   @"cell4"
                                                                                                   ]
                                                                                  cellClassNames:@[
                                                                                                 NSStringFromClass(WRCollectionViewCell.class),
                                                                                                 NSStringFromClass(UICollectionViewCell.class),
                                                                                                 NSStringFromClass(UICollectionViewCell.class),
                                                                                                 NSStringFromClass(UICollectionViewCell.class),
                                                                                                 ]
                                                                                       cellSizes:@[
                                                                                                   @(50),
                                                                                                   @(100),
                                                                                                   @(30),
                                                                                                   @(50)
                                                                                                   ]
                                                                                headerIdentifier:@"header"
                                                                                      headerSize:50
                                                                                footerIdentifier:@"footer"
                                                                                      footerSize:50];
    
    [self.view addSubview:collectionView];
    collectionView.loadedCellBlock = ^(UICollectionView * _Nonnull collectionView, UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
//        cell.backgroundColor = [UIColor redColor];
    };
    collectionView.collectionViewCellDidSelectedBlock = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
    };
    collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
- (void)installTableView {
//    WRTableViewCellObject *object1 = [WRTableViewCellObject new];
//    object1.identifier = @"1";
//    object1.cellClassName = NSStringFromClass(WRTableViewCell.class);
//    object1.height = 50;
//
//    WRTableViewCellObject *object2 = [WRTableViewCellObject new];
//    object2.identifier = @"1";
//    object2.cellClassName = NSStringFromClass(WRTableViewCell.class);
//    object2.height = 50;
//
//    WRTableViewDataSource *dataSource = [WRTableViewDataSource new];
//    dataSource.objectsArray = [NSMutableArray arrayWithArray:@[@[
//                                                                   object1,
//                                                                   object2
//                                                                   ]
//                                                               ]];
//    dataSource.tableViewHeaderViewHeight = 100;
//
//    WRTableView *tableView = [[WRTableView alloc] init];
//    tableView.dataSource = dataSource;
    
    
    /*
    WRTableView *tableView = [[WRTableView alloc] initWithCellIdentifiers:@[
                                                                            @[
                                                                                @"cell",
                                                                                @"cell",
                                                                                @"cell"],
                                                                            @[
                                                                                @"cell",
                                                                                @"cell",
                                                                                @"cell"]
                                                                            ]
                                                           cellClassNames:@[
                                                                            @[
                                                                                NSStringFromClass(WRTableViewCell.class),
                                                                                NSStringFromClass(WRTableViewCell.class),
                                                                                NSStringFromClass(WRTableViewCell.class)
                                                                                ],
                                                                            @[
                                                                                NSStringFromClass(WRTableViewCell.class),
                                                                                NSStringFromClass(WRTableViewCell.class),
                                                                                NSStringFromClass(WRTableViewCell.class)
                                                                                ]
                                                                            ]
                                                               cellHeight:@[
                                                                            @[
                                                                                @(50),
                                                                                @(50),
                                                                                @(50)
                                                                                ],
                                                                            @[
                                                                                @(50),
                                                                                @(50),
                                                                                @(50)
                                                                                ]
                                                                            ]
                                                            headerHeights:@[@(100), @(100)]
                                                            footerHeights:@[@(100)]];
     */
    WRTableView *tableView = [[WRTableView alloc] initSingleSectionSingleCellIdentifier:@"cell"
                                                                          cellClassName:NSStringFromClass(WRTableViewCell.class)
                                                                             cellHeight:50
                                                                              cellCount:4
                              headerHeight:50 footerHeight:30];
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
