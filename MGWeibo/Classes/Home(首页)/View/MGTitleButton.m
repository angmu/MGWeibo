//
//  MGTitleButton.m
//  MgWeibo
//
//  Created by 穆良 on 15/7/1.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#define MGTitleButtonImageW 20

#import "MGTitleButton.h"

@implementation MGTitleButton

+ (instancetype)titleButton
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 高亮时不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        // 图片文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 设置字体
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        // 背景
        [self setBackgroundImage:[UIImage resizeimageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = MGTitleButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - MGTitleButtonImageW;;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
