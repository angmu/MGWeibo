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
/**
 *  自定义tabBar
 */
@property (nonatomic, weak) MGTabBar *customTabBar;
@end

@implementation MGTabBarController

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
/**
 *  监听加号按钮的点击
 */
- (void)tabBarDidClickedPlusBtton:(MGTabBar *)tabBar
{
    //modal出一个控制器
    MGComposeViewController *composeVC = [[MGComposeViewController alloc] init];
    //包装一个导航控制器
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  初始化所有控制器
 */
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
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置完控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中时的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    
//    if (iOS7) {
//        childVc.tabBarItem.selectedImage = selectedImage;
//        //        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    } else { // iOS6没有渲染图片的方法
//        
//    }

    
    // 2.包装一个导航控制器
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabBar内部的按钮
    [self.customTabBar addTabBarbuttonWithItem:childVc.tabBarItem];
}
@end
