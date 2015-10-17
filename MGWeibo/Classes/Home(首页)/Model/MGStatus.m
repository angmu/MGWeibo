//
//  MGStatus.m
//  MGWeibo
//
//  Created by 穆良 on 15/8/24.
//  Copyright (c) 2015年 穆良. All rights reserved.

#import "MGStatus.h"
#import "MGUser.h"
#import "NSDate+MG.h"
#import "MJExtension.h"
#import "MGPhoto.h"

@implementation MGStatus

//数组中装对象的类型
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [MGPhoto class]};
}

- (NSString *)created_at
{
    //Thu Oct 08 22:30:15 +0800 2015
    //EEE MMM d HH:mm:ss Z yyyy

    //1.获得微博发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    #warning 真机调试，必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //把一个字符串以这种格式解析成一个日期对象
    NSDate *createdDate = [fmt dateFromString:_created_at];

    //2.判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { //今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { //昨天
        fmt.dateFormat =@"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { //今年(至少是前天)
        fmt.dateFormat =@"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { //非今年
        fmt.dateFormat =@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

- (void)setSource:(NSString *)source
{
    //_source == <a href="http://app.weibo.com/t/feed/4y9rz1" rel="nofollow">魅族 MX4 Pro</a>
    NSUInteger loc = [source rangeOfString:@">"].location + 1;
    NSUInteger len = [source rangeOfString:@"</"].location - loc;
    source = [source substringWithRange:NSMakeRange(loc, len)];
    
    _source = [NSString stringWithFormat:@"来自 %@", source];
}

//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
//
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
////        [self setValuesForKeysWithDictionary:dict];
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.idstr = dict[@"idstr"];
//        self.reposts_count = [dict[@"reposts_count"] intValue ];
//        self.comments_count = [dict[@"comments_count"] intValue];
//        
//        self.user = [MGUser userWithDict:dict[@"user"]];
//    }
//    return self;
//}
@end
