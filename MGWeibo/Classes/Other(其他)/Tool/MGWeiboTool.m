//
//  MGWeiboTool.m
//  MGWeibo
//
//  Created by 穆良 on 15/8/23.
//  Copyright (c) 2015年 穆良. All rights reserved.
// 微博项目的工具类

#import "MGWeiboTool.h"
#import "MGTabBarController.h"
#import "MGNewfeatureViewController.h"

@implementation MGWeiboTool
+ (void)chooseRootController
{
    // 取出沙盒中上一次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:@"lastVersion"];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MGTabBarController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MGNewfeatureViewController alloc] init];
        
        // 存储新版本
        [defaults setObject:currentVersion forKey:@"lastVersion"];
    }
}
@end
