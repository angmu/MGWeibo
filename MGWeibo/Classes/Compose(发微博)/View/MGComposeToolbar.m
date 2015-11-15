//
//  MGComposeToolbar.m
//  MGWeibo
//
//  Created by 穆良 on 15/11/14.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "MGComposeToolbar.h"

@implementation MGComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {

        //1、设置工具条背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        //2、添加按钮compose_toolbar_picture_highlighted
        [self addButtonWithIcon:@"compose_camerabutton_background" hight:@"compose_camerabutton_background_highlighted" tag:MGComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" hight:@"compose_toolbar_picture_highlighted" tag:MGComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" hight:@"compose_mentionbutton_background_highlighted" tag:MGComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" hight:@"compose_trendbutton_background_highlighted" tag:MGComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" hight:@"compose_emoticonbutton_background_highlighted" tag:MGComposeToolbarButtonTypeEmotion];
    }
    
    return self;
}

/**
 *  添加一个按钮
 */
- (void)addButtonWithIcon:(NSString *)icon hight:(NSString *)hightIcon tag:(int)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:hightIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];

}

/**
 *  监听按钮点击 通知代理
 */
- (void)buttonClick:(UIButton *)btn
{
    if ([_delagate respondsToSelector:@selector(composeToolbar:didClickedButton:)]) {
        
        [self.delagate composeToolbar:self didClickedButton:(int)btn.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}

@end
