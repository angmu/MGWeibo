//
//  MGDropDownMenu.m
//  MGWeibo
//
//  Created by 穆良 on 2017/7/1.
//  Copyright © 2017年 穆良. All rights reserved.
//

#import "MGDropDownMenu.h"

@implementation MGDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

+ (instancetype)dropDownMenu
{
    return [[self alloc] init];
}

/**
 显示
 */
- (void)show
{
    // 1.获得最上层window
    
    // 2.添加自己到敞口
    
    // 3.
}

/**
 销毁
 */
- (void)dismiss
{
    [self removeFromSuperview];
}
@end
