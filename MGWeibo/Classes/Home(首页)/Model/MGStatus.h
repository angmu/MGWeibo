//
//  MGStatus.h
//  MGWeibo
//
//  Created by 穆良 on 15/8/24.
//  Copyright (c) 2015年 穆良. All rights reserved.
// 微博模型(一个MGStatus对象就代表一条微博)

#import <Foundation/Foundation.h>
@class MGUser;

@interface MGStatus : NSObject
/** 微博的内容(文字) */
@property (nonatomic, copy) NSString *text;
/** 微博的来源 */
@property (nonatomic, copy) NSString *source;
/** 微博的ID */
@property (nonatomic, copy) NSString *idstr;
/** 微博的转发数 */
@property (nonatomic, assign) int reposts_count;
/** 微博的评论数 */
@property (nonatomic, assign) int comments_count;
/** 微博的表态数(被点赞数) */
@property (nonatomic, assign) int attitudes_count;

/** 微博的作者 */
@property (nonatomic, strong) MGUser *user;

/** 微博的单张配图 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/** 微博的创建时间 */
@property (nonatomic, copy) NSString *created_at;
/** 被转发的微博 */
@property (nonatomic, strong) MGStatus *retweeted_status;

@end
