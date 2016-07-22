//
//  MGStatusFrame.m
//  MGWeibo
//
//  Created by 穆良 on 15/8/24.
//  Copyright (c) 2015年 穆良. All rights reserved.
//


#import "MGStatusFrame.h"
#import "MGStatus.h"
#import "MGUser.h"
#import "MGStatusPhotosView.h"


@implementation MGStatusFrame

/**
 *  获得微博数据模型后
 *  根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(MGStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2*MGStatusTableBorder;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    // 2.图像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = MGStatusCellBorder;
    CGFloat iconViewY = MGStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + MGStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    // 昵称文字尺寸
    CGSize nameLabelSize = [status.user.name sizeWithFont:MGStatusNameFont];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.mbrank > 2) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + MGStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + MGStatusCellBorder*0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:MGStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + MGStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    // 文字尺寸
    CGSize sourceLabelSize = [status.source sizeWithFont:MGStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博的正文
    CGFloat contentLabelX = MGStatusCellBorder;
    CGFloat contentlabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + MGStatusCellBorder * 0.5;
    // 微博文字很长，需要换行
    CGFloat contentLabelMaxW = topViewW - 2 * MGStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:MGStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    
//    CGSize ssLabel =  [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : MGStatusContentFont} context:nil].size;
    //    NSLog(@"%@", NSStringFromCGSize(ssLabel));
    _contentLabelF = (CGRect){{contentLabelX, contentlabelY}, contentLabelSize};
    
    // 8.配图
    if (status.pic_urls.count) {
        
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + MGStatusCellBorder;
        CGSize photoViewSize = [MGStatusPhotosView sizeWithCount:status.pic_urls.count];
        
        _photoViewF = (CGRect){{photoViewX, photoViewY}, photoViewSize};
        
    }
    
    // 9.被转发微博
    MGStatus *retweeted_status = status.retweeted_status;
    if (retweeted_status) {
        
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + MGStatusCellBorder * 0.5;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = MGStatusCellBorder;
        CGFloat retweetNameLabelY = MGStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:MGRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY},retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentlabelY = CGRectGetMaxY(_retweetNameLabelF) + MGStatusCellBorder * 0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * MGStatusCellBorder;
        CGSize retweetContentLabelSize = [retweeted_status.text sizeWithFont:MGRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentlabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
            
            CGFloat retweetPhotoViewX = contentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + MGStatusCellBorder;
            CGSize retweetPhotoViewSize = [MGStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            _retweetPhotoViewF = (CGRect){{retweetPhotoViewX, retweetPhotoViewY}, retweetPhotoViewSize};
            
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += MGStatusCellBorder;
        // 被转发微博的高度
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else { // 没有转发微博
        
        if (status.pic_urls.count) {
            topViewH = CGRectGetMaxY(_photoViewF);
        } else { // 没有配图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
        
    }
    
    // 计算topView的尺寸
    topViewH += MGStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat statusToolX = topViewX;
    CGFloat statusToolY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolW = topViewW;
    CGFloat statusToolH = 35;
    _statusToolBarF = CGRectMake(statusToolX, statusToolY, statusToolW, statusToolH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + MGStatusTableBorder;
}
@end