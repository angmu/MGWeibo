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

    MGSearchBar *searchBar = [MGSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 200, 30);
    // 设置中间标题内容
    self.navigationItem.titleView = searchBar;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(test) icon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted"];
}

#pragma mark - 测试
- (void)test
{
    // 弹出下拉菜单
    UIImageView *dropDownMenu = [[UIImageView alloc] init];
    dropDownMenu.image = [UIImage imageNamed:@"popover_background"];
    dropDownMenu.y = 100;
    dropDownMenu.width = 217;
    dropDownMenu.height = 300;
    
    // 添加到view上，它能动--> 添加到当前控制器的window上
    // self.view.window == [UIApplication sharedApplication].keyWindow
    // 左边可能没有值，当左边控制器view 还未添加到窗口上时，是空的
    // 添加到最上层的window上,不会被遮盖住
    
    [[[UIApplication sharedApplication].windows lastObject] addSubview:dropDownMenu];
    
    
    LxDBAnyVar([UIApplication sharedApplication].windows);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;
}

@end
