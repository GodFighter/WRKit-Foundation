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

#define WR_COLOR_RGB(r, g, b)           [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define WR_COLOR_RANDOM                WR_COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self installTableView];
//    [self installCollectionView];
//    [self installMongolianLabel];
}
- (void)installMongolianLabel {
    WRMongolianLabel *label = [WRMongolianLabel new];
    label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    label.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200);
    
    label.text = @"ᠪᠠᠭᠰᠢᠨᠠᠷ ᠤᠨ ᠮᠡᠳᠡᠭᠡ ᠵᠠᠩᠭᠢ ᠶᠢᠨ ᠲᠧᠭᠨᠢᠭ ᠤᠨ ᠬᠡᠷᠡᠭᠯᠡᠭᠡᠨ ᠤ ᠴᠢᠳᠠᠪᠤᠷᠢ ᠶᠢ ᠳᠡᠭᠡᠭᠰᠢᠯᠡᠭᠦᠯᠵᠤ᠂ ᠮᠡᠳᠡᠭᠡ ᠵᠠᠩᠭᠢ ᠮᠡᠷᠭᠡᠵᠢᠯ  ᠤᠨ ᠦᠢᠯᠡᠳᠦᠯ ᠢ ᠰᠤᠷᠭᠠᠨ ᠬᠦᠮᠦᠵᠢᠯ ᠤᠨ ᠬᠦᠭᠵᠢᠯᠲᠡ ᠳ᠋ᠤ ᠭᠦᠢᠴᠡᠳ ᠪᠠᠳᠠᠷᠠᠭᠤᠯᠬᠤ ᠶᠢᠨ ᠲᠦᠯᠦᠭᠡ ᠦᠪᠡᠷᠲᠡᠭᠡᠨ ᠵᠠᠰᠠᠬᠤ ᠣᠷᠤᠨ ᠤ ᠰᠤᠷᠭᠠᠨ ᠬᠦᠮᠦᠵᠢᠯ ᠤᠨ ᠲᠢᠩᠬᠢᠮ ᠭᠣᠯᠯᠠᠨ ᠡᠷᠬᠢᠯᠡᠵᠤ᠂ ᠲᠦᠩᠯᠢᠶᠣᠣ ᠬᠣᠲᠠ ᠶᠢᠨ ᠰᠤᠷᠭᠠᠨ ᠬᠦᠮᠦᠵᠢᠯ ᠤᠨ ᠲᠣᠪᠴᠢᠶ᠎ᠠ 《ᠪᠦᠬᠦ ᠣᠷᠤᠨ ᠤ ᠮᠤᠩᠭ᠋ᠤᠯ ᠢᠶᠡᠷ ᠬᠢᠴᠢᠶᠡᠯᠯᠡᠬᠦ ᠳᠤᠮᠳᠠᠳᠤ ᠰᠤᠷᠭᠠᠭᠤᠯᠢ ᠶᠢᠨ ᠪᠠᠢᠭᠠᠯᠢ ᠶᠢᠨ ᠬᠢᠴᠢᠶᠡᠯ ᠲᠦᠷᠥᠯ ᠤᠨ ᠪᠠᠭᠰᠢ ᠶᠢᠨ ᠮᠡᠳᠡᠭᠡ ᠵᠠᠩᠭᠢ ᠶᠢᠨ ᠲᠧᠭᠨᠢᠭ ᠤᠨ ᠬᠡᠷᠡᠭᠯᠡᠭᠡᠨ ᠤ ᠴᠢᠳᠠᠪᠤᠷᠢ ᠶᠢᠨ ᠪᠣᠯᠪᠠᠰᠤᠷᠠᠯ》 ᠢ ᠢ ᠦᠪᠡᠷᠲᠡᠭᠡᠨ ᠵᠠᠰᠠᠬᠤ ᠣᠷᠤᠨ ᠤ ᠵᠢᠭᠠᠨ ᠰᠤᠷᠭᠠᠬᠤ ᠲᠠᠰᠤᠭ ᠤᠨ ᠡᠷᠬᠢᠯᠡᠭᠴᠢ ᠪᠢᠯᠢᠭᠲᠦ ᠪᠠᠭᠰᠢ ᠡᠷᠬᠢᠯᠡᠨ᠂ ᠦᠨᠳᠦᠰᠦᠲᠡᠨ ᠤ ᠰᠤᠷᠭᠠᠨ ᠬᠦᠮᠦᠵᠢᠯ ᠳ᠋ᠤ ᠣᠷᠤᠰᠢᠵᠤ ᠪᠠᠢᠭ᠎ᠠ ᠠᠰᠠᠭᠤᠳᠠᠯ ᠵᠢᠴᠢ ᠬᠦᠭᠵᠢᠯᠲᠡ ᠶᠢᠨ ᠬᠠᠨᠳᠤᠰᠢ ᠶᠢᠨ ᠲᠤᠬᠠᠢ ᠨᠠᠷᠢᠨ ᠲᠠᠨᠢᠯᠴᠠᠭᠤᠯᠤᠭᠰᠠᠨ ᠪᠠᠢᠨ᠎ᠠ᠃ ᠦᠪᠡᠷᠲᠡᠭᠡᠨ ᠵᠠᠰᠠᠬᠤ ᠣᠷᠤᠨ ᠤ ᠰᠤᠷᠭᠠᠨ ᠬᠦᠮᠦᠵᠢᠯ ᠤᠨ ᠲᠢᠩᠬᠢᠮ ᠤᠨ ᠦᠨᠳᠦᠰᠦᠲᠡᠨ ᠤ ᠰᠤᠷᠭᠠᠨ ᠬᠦᠮᠦᠵᠢᠯ ᠤᠨ ᠪᠠᠢᠴᠠᠭᠠᠨ ᠰᠤᠳᠤᠯᠤᠭᠴᠢ ᠪᠤᠶᠠᠨᠲᠣᠭᠲᠠᠬᠤ ᠪᠠᠭᠰᠢ ᠡᠴᠡ ᠦᠨᠳᠦᠰᠦᠲᠡᠨ ᠤ ᠰᠤᠷᠭᠠᠨ ᠬᠦᠮᠦᠵᠢᠯ ᠤᠨ ᠦᠢᠯᠡᠰ ᠤᠨ ᠲᠡᠦᠬᠡᠨ ᠶᠠᠪᠤᠴᠠ ᠪᠠ ᠢᠷᠡᠭᠡᠳᠦᠢ ᠶᠢᠨ ᠬᠦᠭᠵᠢᠯᠲᠡ ᠲᠤᠬᠠᠢ ᠪᠦᠬᠦ ᠲᠠᠯ᠎ᠠ ᠪᠡᠷ ᠬᠠᠷᠢᠭᠤ ᠮᠡᠳᠡᠭᠦᠯᠦᠯᠲᠡ ᠬᠢᠭᠰᠡᠨ ᠪᠠᠢᠨ᠎ᠠ᠃ ᠦᠪᠡᠷᠲᠡᠭᠡᠨ ᠵᠠᠰᠠᠬᠤ ᠣᠷᠤᠨ ᠤ ᠵᠢᠭᠠᠨ ";
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 400, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [button wr_addEventHandler:^(id sender) {
//        label.font =[UIFont fontWithName:@"MongolianBaiZheng" size:18];
        label.lineSpacing = 10;
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)installCollectionView {
//    WRCollectionView *collectionView = [[WRCollectionView alloc] initSingleSectionMultiCellStyle:WRCollectionViewStyle_Landscape
//                                                                                 cellIdentifiers:@[
//                                                                                                   @"cell1",
//                                                                                                   @"cell2",
//                                                                                                   @"cell3",
//                                                                                                   @"cell4"
//                                                                                                   ]
//                                                                                  cellClassNames:@[
//                                                                                                 NSStringFromClass(WRCollectionViewCell.class),
//                                                                                                 NSStringFromClass(UICollectionViewCell.class),
//                                                                                                 NSStringFromClass(UICollectionViewCell.class),
//                                                                                                 NSStringFromClass(UICollectionViewCell.class),
//                                                                                                 ]
//                                                                                       cellSizes:@[
//                                                                                                   @(50),
//                                                                                                   @(100),
//                                                                                                   @(30),
//                                                                                                   @(50)
//                                                                                                   ]
//                                                                                headerIdentifier:@"header"
//                                                                                      headerSize:50
//                                                                                footerIdentifier:@"footer"
//                                                                                      footerSize:50];
    WRCollectionView *collectionView = [[WRCollectionView alloc] initMultiSectionsMultiCellStyles:@[
                                                                                                @(WRCollectionViewStyle_LandscapeHalf),
                                                                                                @(WRCollectionViewStyle_Landscape)
                                                                                                ]
                                                                              cellIdentifiers:@[
                                                                                                @"cell1",
                                                                                                @"cell2"
                                                                                                ]
                                                                               cellClassNames:@[
                                                                                                NSStringFromClass(WRCollectionViewCell.class),
                                                                                                NSStringFromClass(WRCollectionViewCell.class)
                                                                                                ]
                                                                                    cellSizes:@[
                                                                                                @(60),
                                                                                                @90
                                                                                                ]
                                                                                   cellCounts:@[
                                                                                                @2,
                                                                                                @3
                                                                                                ]
                                                                            headerIdentifiers:@[
                                                                                                @"header",
                                                                                                @"header"
                                                                                                ]
                                                                                  headerSizes:@[
                                                                                                @(50),
                                                                                                @(50)
                                                                                                ]
                                                                            footerIdentifiers:@[
                                                                                                @"footer",
                                                                                                @"footer"
                                                                                                ]
                                                                                  footerSizes:@[
                                                                                                @(50),
                                                                                                @(50)
                                                                                                ]];
    [self.view addSubview:collectionView];
    
    WRCollectionViewObject *object = [WRCollectionViewObject new];
    object.size = 200;
//    object.identifier = @"cell2";
//    object.cellClassName = NSStringFromClass(WRCollectionViewCell.class);
    
    WRCollectionViewDataSource *dataSource = [WRCollectionViewDataSource new];
    [dataSource.objectsArray addObject:object];
    
    [collectionView.dataSource addObject:dataSource];
    
    [collectionView wr_reload];
    
    collectionView.loadedCellBlock = ^(UICollectionView * _Nonnull collectionView, UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.backgroundColor = WR_COLOR_RANDOM;
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
    tableView.loadedCellBlock = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.backgroundColor = WR_COLOR_RANDOM;
    };
    WRTableViewDataSource *datasource = tableView.dataSource;
    WRTableViewCellObject *object = datasource.objectsArray.firstObject.firstObject;
    object.height = 100;
    [tableView wr_reloadData];
    
    tableView.tableViewCellDidSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
