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
    //选中时的背景图片
    self.selectedBackgroundView = [[UIView alloc] init];
    
    /** 1.顶部的view */
    MGStatusTopView *topView = [[MGStatusTopView alloc] init];
    
    [self.contentView addSubview:topView];
    self.topView = topView;
    
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
    
    //1.设置顶部View的数据
    [self setupTopViewData];
    
    // 2.微博工具条
    [self setupstatusToolBarData];
}

/**
 *  原创微博数据
 */
- (void)setupTopViewData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    //传递模型数据
    self.topView.statusFrame = self.statusFrame;
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
