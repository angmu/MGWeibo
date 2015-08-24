//
//  MGTabBarViewController.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGTabBarViewController.h"
#import "MGHomeViewController.h"
#import "MgMessageViewController.h"
#import "MgDiscoverViewController.h"
#import "MgMeViewController.h"
#import "UIImage+MG.h"
#import "MGTabBar.h"
#import "MGNavigationController.h"

@interface MGTabBarViewController () <MGTabBarDelegate>
/**
 *  自定义tabBar
 */
@property (nonatomic, weak) MGTabBar *customTabBar;
@end

@implementation MGTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tabBar
    [self setupTabBar];

    // 初始化所有子控制器
    [self setupAllChildViewControllers];
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
 *  初始化所有控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    MGHomeViewController *home = [[MGHomeViewController alloc] init];
    
//    if (iOS7){
//        [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home_os7" selectedImageName:@"tabbar_home_selected_os7"];
//    } else {
//        [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
//    }
//    home.tabBarItem.badgeValue = @"10";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    
    // 2.消息
    MgMessageViewController *message = [[MgMessageViewController alloc] init];
//    message.tabBarItem.badgeValue = @"new";
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    
    // 3.广场
    MgDiscoverViewController *discover = [[MgDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 4.我
    MgMeViewController *me = [[MgMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
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
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置选中时的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = selectedImage;
//        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else { // iOS6没有渲染图片的方法
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabBar内部的按钮
    [self.customTabBar addTabBarbuttonWithItem:childVc.tabBarItem];
}
@end
