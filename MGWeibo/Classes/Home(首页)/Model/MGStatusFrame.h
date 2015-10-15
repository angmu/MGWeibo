//
//  MGStatusFrame.h
//  MGWeibo
//
//  Created by 穆良 on 15/8/24.
//  Copyright (c) 2015年 穆良. All rights reserved.
// 一个cell对应一个MGStatusFrame对象

#import <Foundation/Foundation.h>

/** 昵称的字体 */
#define MGStatusNameFont [UIFont systemFontOfSize:14]
/** 被转发微博的昵称的字体 */
#define MGRetweetStatusNameFont MGStatusNameFont
/** 时间的字体 */
#define MGStatusTimeFont [UIFont systemFontOfSize:13]
/** 来源的字体 */
#define MGStatusSourceFont MGStatusTimeFont
/** 正文的字体 */
#define MGStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博的正文的字体 */
#define MGRetweetStatusContentFont MGStatusContentFont

/** cell的边框宽度 */
#define MGStatusCellBorder 7
/** 表格的边框宽度 */
#define MGStatusTableBorder 4

@class MGStatus;


@interface MGStatusFrame : NSObject
/** 微博数据模型 */
@property (nonatomic, strong) MGStatus *status;

// CGRect描叙所有子控件的frame
/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 图像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博的作者昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

/** 添加微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolBarF;

/** 微博cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
