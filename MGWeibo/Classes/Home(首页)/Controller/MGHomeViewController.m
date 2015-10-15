//
//  MgHomeViewController.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#define MGTitleButtonDown 0
#define MGTitleButtonUp -1

#import "MGHomeViewController.h"
#import "MGBadgeButton.h"
#import "UIBarButtonItem+MG.h"
#import "MGTitleButton.h"
#import "AFNetworking.h"
#import "MGAccountTool.h"
#import "MGAccount.h"
#import "UIImageView+WebCache.h"
#import "MGStatus.h"
#import "MGUser.h"
#import "MJExtension.h"
#import "MGStatusFrame.h"
#import "MGStatusCell.h"


@interface MGHomeViewController ()
@property (nonatomic, strong) NSArray *statusFrames;
@end

@implementation MGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.加载微博数据
    [self setupStatusData];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MGAccountTool account].access_token;
//    params[@"count"] = @80;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 将字典数组转化为模型数组(里面放的就是MGStatus模型)
         NSArray *statues = [MGStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         
         for (NSDictionary *dict in responseObject[@"statuses"]) {
             MGLog(@"%@", dict[@"pic_urls"]);
             // dict[@"pic_urls"] ----> MGStatus.pic_urls
             // 里面装着字典 ----> 里面装着模型
         }
         
         // 创建frame模型对象
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         for (MGStatus *status in statues) {
             
             MGLog(@"%@", [[status.pic_urls lastObject] class]);
             
             MGStatusFrame *statusFrame = [[MGStatusFrame alloc] init];
             // 传递微博数据模型
             statusFrame.status = status;
             [statusFrameArray addObject:statusFrame];
         }
         // 赋值
         self.statusFrames = statusFrameArray;
         
         // 异步加载(1-2s后才有结果)，重新刷新表格，否则看不见
         [self.tableView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   
    }];
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    
    
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch"highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    MGTitleButton *titleBtn = [MGTitleButton titleButton];
    // 图标
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleBtn setTitle:@"iangmu" forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(0, 0, 100, 40);
    titleBtn.tag = MGTitleButtonDown;
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
    self.tableView.backgroundColor = MGColor(226, 226, 226);
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, MGStatusTableBorder, 0);
    //设置cell分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

/**
 *  翻转操作
 */
- (void)titleClick:(MGTitleButton *)titleBtn
{
    if (titleBtn.tag == MGTitleButtonDown) {
        [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleBtn.tag = MGTitleButtonUp;
    } else {
        [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleBtn.tag = MGTitleButtonDown;
    }

//    MGLog(@"titleBtn.currentImage-----%@", titleBtn.currentImage);
}

- (void)findFriend
{
//    MGLog(@"找朋友...");
}

- (void)pop
{
//    MGLog(@"扫描一下...");
}


//- (void)btnClick
//{
//    self.tabBarItem.badgeValue = @"103";
//}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    MGStatusCell *cell = [MGStatusCell cellWithTableView:tableView];

    // 2.设置cell的数据,传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
////    vc.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end
