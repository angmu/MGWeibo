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

@interface MGHomeViewController ()
@property (nonatomic, strong) NSArray *statues;
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
//    params[@"count"] = @2;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         self.statues = [MGStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
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
    return self.statues.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 2.设置cell的数据
    // 微博的文字(内容)
    MGStatus *status = self.statues[indexPath.row];
    cell.textLabel.text = status.text;
    
    // 微博作者的昵称
    MGUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 微博作者的图像
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"tabbar_compose_button"]];
    
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


@end
