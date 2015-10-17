//
//  MGAccountTool.m
//  MGWeibo
//
//  Created by 穆良 on 15/8/23.
//  Copyright (c) 2015年 穆良. All rights reserved.
// 账号管理工具类

#import "MGAccount.h"
#import "MGAccountTool.h"
#define MGAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation MGAccountTool

+ (void)saveAccount:(MGAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
                           
    [NSKeyedArchiver archiveRootObject:account toFile:MGAccountFile];

}


+(MGAccount *)account
{
    // 取出账号
    MGAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:MGAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    if ([now compare:account.expiresTime] == NSOrderedAscending) { // 还没过期
        return account;
    } else { // 过期
        return nil;
    }
}
@end
