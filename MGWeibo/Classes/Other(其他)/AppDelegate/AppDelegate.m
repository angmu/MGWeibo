//
//  AppDelegate.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/26.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "AppDelegate.h"
#import "MGOAuthViewController.h"
#import "MGAccount.h"
#import "MGWeiboTool.h"
#import "MGAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

UIWindow *window2;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 先判断有无账号信息
    MGAccount *account = [MGAccountTool account];
    
    if (account) { // 之前登陆成功
//        MGLog(@"MGWeiboTool chooseRootController----");
        [MGWeiboTool chooseRootController];
    } else { // 之前没有登陆成功
        self.window.rootViewController = [[MGOAuthViewController alloc] init];
    }

    
    // 添加window
//    window2 = [[UIWindow alloc] init];
//    window2.y = 100;
//    window2.width = 120;
//    window2.height = 200;
//    window2.backgroundColor = [UIColor yellowColor];
//    window2.hidden = NO;
//    window2.rootViewController = [[UIViewController alloc] init];
    
    return YES;
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止下载所有图片 获得它的单例对象
    [[SDWebImageManager sharedManager] cancelAll];
    
    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
