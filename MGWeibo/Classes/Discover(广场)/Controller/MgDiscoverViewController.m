//
//  MgDiscoverViewController.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MgDiscoverViewController.h"
#import "MGSearchBar.h"

@interface MgDiscoverViewController ()

@end

@implementation MgDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MGSearchBar *searchBar = [MGSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    // 设置中间标题内容
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

@end
