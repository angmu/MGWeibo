//
//  MGTabBarController.m
//  MGWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGTabBarController.h"

#import "MGHomeViewController.h"
#import "MGMessageViewController.h"
#import "MGDiscoverViewController.h"
#import "MGMineViewController.h"

#import "MGTabBar.h"
#import "MGNavigationController.h"

#import "MGComposeViewController.h"

@interface MGTabBarController ()<MGTabBarDelegate>
/** 自定义tabBar */
@property (nonatomic, weak) MGTabBar *customTabBar;
@end

@implementation MGTabBarController

//+ (void)initialize
//{
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    NSMutableDictionary *selAttrs = [NSMutableDictionary dictionary];
//    selAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    
//    UITabBarItem *tabBarItem = [UITabBarItem appearance];
//    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [tabBarItem setTitleTextAttributes:selAttrs forState:UIControlStateSelected];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tabBar
    [self setupTabBar];

    // 初始化所有子控制器
    [self setupAllChildViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    // 凡是view开头的方法,都先调用super
    [super viewDidAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        // NSLog(@"%@", [child superclass]);
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
//    UITabBarBackgroundView
//    UIImageView
//    UITabBarButton
}

/**
 *  初始化tabBar
 */
- (void)setupTabBar
{
    MGTabBar *customTabBar = [[MGTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    
    self.customTabBar = customTabBar;
}

#pragma mark 通知代理,监听tabBar内部按钮的改变,切换子控制器
- (void)tabBar:(MGTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
//    NSLog(@"---%d----%d",from, to);
    self.selectedIndex = to;
}

/** 监听加号按钮的点击 */
- (void)tabBarDidClickedPlusBtton:(MGTabBar *)tabBar
{
    //modal出一个控制器
    MGComposeViewController *composeVC = [[MGComposeViewController alloc] init];
    //包装一个导航控制器
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
}

/** 初始化所有控制器 */
- (void)setupAllChildViewController
{
    // 1.首页
    MGHomeViewController *home = [[MGHomeViewController alloc] init];
    //    home.tabBarItem.badgeValue = @"10";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    // 2.消息
    MGMessageViewController *message = [[MGMessageViewController alloc] init];
    //    message.tabBarItem.badgeValue = @"new";
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    // 3.广场
    MGDiscoverViewController *discover = [[MGDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 4.我
    MGMineViewController *me = [[MGMineViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
//    MGTabBar *tabBar = [[MGTabBar alloc] init];
//    [self setValue:tabBar forKeyPath:@"_tabBar"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置完控制器的属性
    childVC.title = title;
    // 设置图标,这里tabBar是用UIView实现的,不用担心选中渲染
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    /// viewDidLoad是懒加载,view加载完毕时调用
    /// 弊端1: 提前加载view,可能都用不到,性能问题!
    /// 弊端2: 在viewDidLoad设置导航item不可用, 颜色可能会失效
    /// item状态是在nav控制器的initialize中设置,此时还未创建
    /// 调用顺序问题,系统不同显示效果不一致
//    childVC.view.backgroundColor = [UIColor redColor];
    
    // 2.包装一个导航控制器
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
    
    // 3.添加tabBar内部的按钮
    [self.customTabBar addTabBarbuttonWithItem:childVC.tabBarItem];
}
@end

/// tabBarController里的导航控制器会提前创建,子控制器切换时才会创建
