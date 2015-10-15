//
//  NSDate+MG.h
//  MGWeibo
//
//  Created by 穆良 on 15/10/9.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MG)
/**
 *  是否是今天
 */
- (BOOL)isToday;
/**
 *  是否是昨天
 */
- (BOOL)isYesterday;

/**
 *  是否是今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end
