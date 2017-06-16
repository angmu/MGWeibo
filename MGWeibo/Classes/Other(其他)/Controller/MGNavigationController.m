//
//  MGNavigationController.m
//  MgWeibo
//
//  Created by 穆良 on 15/7/1.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@implementation MGNavigationController


/** 第一次使用这个类的时调用(只会调用1次) */
+ (void)initialize
{
    // 只需要设置一次
//    LxDBAnyVar(@"initialize");
    // 1.取出appearance对象,拿到它能改导航栏里所有东西
    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:textAttrs];
    
    // 2.设置导航Item主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    // 设置不能点击时，按钮的颜色
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}


/**
 *  重写目的：拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 这时push进来的控制器viewController，不是根控制器时
    if (self.viewControllers.count >= 1) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) icon:@"navigationbar_back" highIcon:@"navigationbar_back_highlighted"];
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) icon:@"navigationbar_more" highIcon:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
}

/// 返回
- (void)back
{
#warning 这里要用self，
    // self.navigationController == nil
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

/// 更多
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
