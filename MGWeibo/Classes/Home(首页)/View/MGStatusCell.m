//
//  MGStatusCell.m
//  MGWeibo
//
//  Created by 穆良 on 15/8/24.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGStatusCell.h"
#import "MGStatusFrame.h"
#import "MGStatus.h"
#import "MGUser.h"

@interface MGStatusCell ()
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 图像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博的作者昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 添加微博的工具条 */
@property (nonatomic, weak) UIImageView *statusToolbar;
@end

@implementation MGStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    /** 1.顶部的view */
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 2.图像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 4.配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 7.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加被转发微博的子控件
 */
- (void)setupRetweetSubviews
{
    /** 1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;

    /** 2.被转发微博的作者昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 3.被转发微博的正文\内容 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 4.被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    /** 添加微博的工具条 */
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(MGStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.转发微博
    [self setupRetweetData];
    
    // 3.工具条
    
    
    
    
}

/**
 *  原创微博数据
 */
- (void)setupOriginalData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.头像
    
    
    
    // 3.
}

/**
 *  转发微博数据
 */
- (void)setupRetweetData
{
    
}

@end
