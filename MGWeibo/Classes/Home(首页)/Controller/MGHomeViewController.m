//
//  MGHomeViewController.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//


#import "MGHomeViewController.h"
#import "MGBadgeButton.h"
#import "MGTitleButton.h"

#import "MGAccountTool.h"
#import "MGAccount.h"
#import "UIImageView+WebCache.h"
#import "MGStatus.h"
#import "MGUser.h"
#import "MJExtension.h"
#import "MGStatusFrame.h"
#import "MGStatusCell.h"
#import "MJRefresh.h"

#import "MGHttpTool.h"
//#import "AFNetworking.h"


#define MGTitleButtonDown 0
#define MGTitleButtonUp -1

@interface MGHomeViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, weak) MGTitleButton *titleButton;

@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@end

@implementation MGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //0.继承下拉刷新控件
    [self setupRefreashView];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.加载微博数据
//    [self setupStatusData];
    
    //2.获取用户信息
    [self setupUserData];
}

/**
 *  获取用户信息
 */
- (void)setupUserData
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MGAccountTool account].access_token;
    params[@"uid"] = @([MGAccountTool account].uid);

    //2.发送请求
    [MGHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        
        //字典转模型
        MGUser *user = [MGUser objectWithKeyValues:json];
        //设置标题文字
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        //保存昵称
        MGAccount *account = [MGAccountTool account];
        account.name = user.name;
        [MGAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        
    }];
    
}

/**
 *  集成拉刷新控件
 */
- (void)setupRefreashView
{
    //下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    //一进来就刷新
    [header beginRefreshing];
    self.header = header;
    
    //3.下拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
    
}

/**
 *  当上刷新控件进入开始刷新时调用
 */
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { //上拉刷新
        [self loadMoreData];
    } else { //下拉刷新
        [self loadNewData];
    }
}

/**
 *  加载更多数据
 */
- (void)loadMoreData
{
    //传进来的refreshView就是footerView
    //发送请求 加载更多数据

    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MGAccountTool account].access_token;
    params[@"count"] = @5;
    
    //第一次进入程序 不用设置这个参数
    if (self.statusFrames.count) {
        MGStatusFrame *statusFrame = [self.statusFrames lastObject];
        //加载ID <= max_id 的微博
        long long maxID = [statusFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(maxID);
    }
    
    // 2.发送请求
    [MGHttpTool getWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        
        // 将字典数组转化为模型数组(里面放的就是MGStatus模型)
        NSArray *statues = [MGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (MGStatus *status in statues) {
            
            MGStatusFrame *statusFrame = [[MGStatusFrame alloc] init];
            // 传递微博数据模型
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        //直接 把新数据加到旧数据 后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        // 异步加载(1-2s后才有结果)，重新刷新表格，否则看不见
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
        //显示最新微博数量(给用户一些友善的提示)
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSError *error) {
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    }];
}

/**
 *  监听刷新控件状态的改变(手动进入刷新状态才会调用这个方法)
 */

/**
 *  下拉加载更新的数据
 */
- (void)loadNewData
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MGAccountTool account].access_token;
    params[@"count"] = @5;
    
    //第一次进入程序 不用设置这个参数
    if (self.statusFrames.count) {
        MGStatusFrame *statusFrame = self.statusFrames[0];
        //加载ID比since_id大的微博
        params[@"since_id"] = statusFrame.status.idstr;
    }

    // 2.发送请求
    [MGHttpTool getWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        
        //         MGLog(@"responseObject---%@", responseObject);
        // 将字典数组转化为模型数组(里面放的就是MGStatus模型)
        NSArray *statues = [MGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (MGStatus *status in statues) {
            
            MGStatusFrame *statusFrame = [[MGStatusFrame alloc] init];
            // 传递微博数据模型
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 赋值
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 异步加载(1-2s后才有结果)，重新刷新表格，否则看不见
        [self.tableView reloadData];
        
        //让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
        //显示最新微博数量(给用户一些友善的提示)
        [self showNewStatusCount:statusFrameArray.count];
        
    } failure:^(NSError *error) {
        
        //让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

- (void)dealloc
{
    [self.header free];
    [self.footer free];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MGAccountTool account].access_token;
    params[@"count"] = @5;
    
    // 2.发送请求
    [MGHttpTool getWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        
        // 将字典数组转化为模型数组(里面放的就是MGStatus模型)
        NSArray *statues = [MGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (MGStatus *status in statues) {
            
            //             MGLog(@"%@", [[status.pic_urls lastObject] class]);
            
            MGStatusFrame *statusFrame = [[MGStatusFrame alloc] init];
            // 传递微博数据模型
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        // 赋值
        self.statusFrames = statusFrameArray;
        
        // 异步加载(1-2s后才有结果)，重新刷新表格，否则看不见
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  显示最新微博的数量
 */
- (void)showNewStatusCount:(NSInteger)count
{
    //1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    //btn会藏在导航栏的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar]
    ;
    //2.设置图片和文字
    btn.userInteractionEnabled = NO; //没有点击事件，不高亮调整图片
    [btn setBackgroundImage:[UIImage resizeimageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%zd条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博" forState:UIControlStateNormal];
    }
    // TODO:
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    // 3.设置按钮的frame
    CGFloat btnH = 30;
    CGFloat btnX = 2;
    CGFloat btnY = 64 - btnH;
    CGFloat btnW = self.view.frame.size.width - 2*btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 通过动画移动按钮(向下移动 btnH+1)
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
    } completion:^(BOOL finished) { //向下的动画执行完毕后
        
        // 延迟1s，在执行
        [UIView animateKeyframesWithDuration:0.7 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            // 执行向上移动的动画(清空transform)
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
    }];
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(findFriend) icon:@"navigationbar_friendsearch"highIcon:@"navigationbar_friendsearch_highlighted"];
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) icon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted"];
    
    
    // 中间按钮
    MGTitleButton *titleBtn = [MGTitleButton titleButton];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 设置titleButton的frame一定要放在前面 放在后面计算字体宽度就没用了
    titleBtn.frame = CGRectMake(0, 0, 0, 40);
    MGAccount *account = [MGAccountTool account];
    NSString *title = account.name;
    // 文字
    if (title) {
        [titleBtn setTitle:title forState:UIControlStateNormal];
    } else {
        [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    }
    
    titleBtn.tag = MGTitleButtonDown;
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    self.titleButton = titleBtn;
    
    self.tableView.backgroundColor = MGColor(226, 226, 226);
    // 表格的frame就是屏幕的尺寸
    // 有NAV和TAB默认会增加64和49上下间距
    // 再给表格设置下间距, 会在原基础上增加 MGStatusTableBorder 结果是 53
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
        [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleBtn.tag = MGTitleButtonUp;
    } else {
        [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleBtn.tag = MGTitleButtonDown;
    }
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

#pragma mark - 
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

#pragma mark - 懒加载
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [[NSMutableArray alloc] init];
    }
    
    return _statusFrames;
}

@end
