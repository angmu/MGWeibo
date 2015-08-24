//
//  MgBadgeBttin.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/29.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGBadgeButton.h"


@implementation MGBadgeButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        // 按钮的背景图片,用拉伸的
        [self setBackgroundImage:[UIImage resizeimageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    }
    
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
#warning copy类型，只能用copy给他赋值
    _badgeValue = [badgeValue copy];
    
    // 设置提醒数字
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:self.badgeValue forState:UIControlStateNormal];
        
        // 设置frame,要搞个高度和x
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字尺寸
            CGSize badgeTitleSize = [self.badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeTitleSize.width + 10;
        }
        
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        
    } else {
        self.hidden = YES;
    }
}
@end
