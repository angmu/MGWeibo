//
//  MGAccount.h
//  MGWeibo
//
//  Created by 穆良 on 15/8/14.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;
// 账号的过期时间
@property (nonatomic, strong) NSDate *expiresTime;
// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

// 字典转模型的方法
+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
