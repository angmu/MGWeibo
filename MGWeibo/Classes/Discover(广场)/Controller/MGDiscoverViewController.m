//
//  MgDiscoverViewController.m
//  MGWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGDiscoverViewController.h"
#import "MGSearchBar.h"

@interface MGDiscoverViewController ()

@end

@implementation MGDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    LxDBAnyVar([self class]);

    MGSearchBar *searchBar = [MGSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    // 设置中间标题内容
    self.navigationItem.titleView = searchBar;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
