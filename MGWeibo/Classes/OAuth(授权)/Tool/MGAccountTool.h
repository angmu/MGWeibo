//
//  MGAccountTool.h
//  MGWeibo
//
//  Created by 穆良 on 15/8/23.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MGAccount;

@interface MGAccountTool : NSObject
/**
*  存储账号
*  @param account 需要存储的账号
*/
+ (void)saveAccount:(MGAccount *)account;

/**
 *  读取账号方法
 */
+ (MGAccount *)account;
@end
