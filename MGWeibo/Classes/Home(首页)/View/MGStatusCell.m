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
#import "UIImageView+WebCache.h"
#import "MGStatusToolBar.h"
#import "MGRetweetStatusView.h"
#import "MGStatusTopView.h"

@interface MGStatusCell ()
/** 顶部的view */
@property (nonatomic, weak) MGStatusTopView *topView;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) MGRetweetStatusView *retweetView;

/** 添加微博的工具条 */
@property (nonatomic, weak) MGStatusToolBar *statusToolBar;
@end

@implementation MGStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    MGStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MGStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 一次性初始化，添加控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博的子控件
        [self setupRetweetSubviews];
        
        //微博顶部控件
        [self setupTopView];
        
        //2.添加微博的工具条
        [self setupstatusToolBar];
    }
    return self;
}

- (void)setupTopView
{
    /** 0.设置cell的背景颜色 */
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] init];
    //    self.backgroundView = [[UIView alloc] init];
    //    UIImageView *bgView = [[UIImage alloc] init];
    //    bgView.image = [UIImage resizeimageWithName:@"common_card_background_highlighted_os7"];
    //    self.selectedBackgroundView = bgView;
    
    /** 1.顶部的view */
    MGStatusTopView *topView = [[MGStatusTopView alloc] init];
    
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    
    
}

/**
 *  添加被转发微博的子控件
 */
- (void)setupRetweetSubviews
{
    /** 1.被转发微博的view(父控件) */
    MGRetweetStatusView *retweetView = [[MGRetweetStatusView alloc] init];
    
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
}

/**
 *  添加微博的工具条
 */
- (void)setupstatusToolBar
{
    /** 添加微博的工具条 */
    MGStatusToolBar *statusToolBar = [[MGStatusToolBar alloc] init];
    
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}

# pragma mark - 重写cell的setFrame方法
/**
 *  拦截frame的设置
 *  只要tableView设置cell的frame,就把它改掉
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += MGStatusTableBorder;
    frame.origin.x = MGStatusTableBorder;
    frame.size.width -= 2 * MGStatusTableBorder;
    frame.size.height -= MGStatusTableBorder;
    [super setFrame:frame];
}

#pragma mark - 设置控件数据
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
    
    // 3.微博工具条
    [self setupstatusToolBarData];
}

/**
 *  原创微博数据
 */
- (void)setupOriginalData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    //传递模型数据
    self.topView.statusFrame = self.statusFrame;
}

/**
 *  转发微博数据
 */
- (void)setupRetweetData
{
    MGStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    
    //父控件是否显示
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

/**
 *  设置工具条数据
 */
- (void)setupstatusToolBarData
{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.status = self.statusFrame.status;
}


@end
