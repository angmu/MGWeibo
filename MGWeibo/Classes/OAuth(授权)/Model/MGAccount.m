//
//  MGAccount.m
//  MGWeibo
//
//  Created by 穆良 on 15/8/14.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGAccount.h"

@implementation MGAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
/**
 *  从文件中解析对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
    }
    return self;
}
/**
 *  将对象写入文件时候调用
 */
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [enCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [enCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [enCoder encodeInt64:self.uid forKey:@"uid"];
}
@end
