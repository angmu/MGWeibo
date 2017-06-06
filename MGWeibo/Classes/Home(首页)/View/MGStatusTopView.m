//
//  MGStatusTopView.m
//  MGWeibo
//
//  Created by 穆良 on 15/10/13.
//  Copyright © 2015年 穆良. All rights reserved.
//微博顶部的view

#import "MGStatusTopView.h"
#import "MGStatusFrame.h"
#import "MGStatus.h"
#import "MGUser.h"
#import "UIImageView+WebCache.h"
#import "MGRetweetStatusView.h"
#import "MGPhoto.h"
#import "MGStatusPhotosView.h"

@interface MGStatusTopView ()
/** 图像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) MGStatusPhotosView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) MGRetweetStatusView *retweetView;

@end

@implementation MGStatusTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizeimageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizeimageWithName:@"timeline_card_top_background_highlighted"];
        
        /** 2.图像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 4.配图 */
        MGStatusPhotosView *photoView = [[MGStatusPhotosView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        /** 5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font =  MGStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 6.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font =  MGStatusTimeFont;
        timeLabel.textColor = MGColor(245, 156, 51);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 7.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = MGStatusSourceFont;
        sourceLabel.textColor = MGColor(176, 176, 176);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 8.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = MGStatusContentFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 1.被转发微博的view(父控件) */
        MGRetweetStatusView *retweetView = [[MGRetweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(MGStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    MGStatus *status = statusFrame.status;
    MGUser *user = status.user;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.会员图标
    if (user.mbrank > 2) {
        self.vipView.hidden = NO;
        //        self.vipView.image = [UIImage imageWithName:@"common_icon_membership"];
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        
        self.nameLabel.textColor = [UIColor orangeColor];
        
    } else {
        
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.nameLabel.frame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.nameLabel.frame) + MGStatusCellBorder*0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:MGStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + MGStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:MGStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    //    NSLog(@"%@", status.source);
    
    // 7.正文\微博内容
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
//        MGPhoto *photo = status.pic_urls[0];
    //        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    #warning TODO 设置图片
        self.photoView.photos = status.pic_urls;
        
    } else {
        self.photoView.hidden = YES;
    }

    
    MGStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    //转发微博父控件是否显示
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        //设置retweetView自身的尺寸
        self.retweetView.frame = self.statusFrame.retweetViewF;
        //传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
        
    } else {
        self.retweetView.hidden = YES;
    }
}

@end
