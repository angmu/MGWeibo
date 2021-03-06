//
//  MGRetweetStatusView.m
//  MGWeibo
//
//  Created by 穆良 on 15/10/13.
//  Copyright © 2015年 穆良. All rights reserved.
//转发微博

#import "MGRetweetStatusView.h"
#import "MGStatusFrame.h"
#import "MGStatus.h"
#import "MGUser.h"
#import "UIImageView+WebCache.h"
#import "MGPhoto.h"
#import "MGStatusPhotosView.h"

@interface MGRetweetStatusView ()
/** 被转发微博的作者昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) MGStatusPhotosView *retweetPhotoView;

@end


@implementation MGRetweetStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizeimageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        /** 2.被转发微博的作者昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = MGRetweetStatusNameFont;
        retweetNameLabel.textColor = MGColor(95, 157, 213);
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 3.被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = MGRetweetStatusContentFont;
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 4.被转发微博的配图 */
        MGStatusPhotosView *retweetPhotoView = [[MGStatusPhotosView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(MGStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    MGStatus *retweetStatus = statusFrame.status.retweeted_status;
    MGUser *user = retweetStatus.user;
        
    // 2.昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.retweetNameLabel.frame = statusFrame.retweetNameLabelF;
        
    // 3.正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
    // 4.配图
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
        //给转发微博 设置图片
        self.retweetPhotoView.photos = retweetStatus.pic_urls;
    } else {
        self.retweetPhotoView.hidden = YES;
    }
}


@end
