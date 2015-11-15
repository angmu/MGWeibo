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
    
//    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止下载所有图片 获得它的单例对象
    [[SDWebImageManager sharedManager] cancelAll];
    
    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
