//
//  MGSearchBar.m
//  MgWeibo
//
//  Created by 穆良 on 15/7/1.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGSearchBar.h"

@implementation MGSearchBar

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景
        self.background = [UIImage resizeimageWithName:@"searchbar_textfield_background"];
        // 左边放大镜
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
//        iconView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
//        self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
        
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        // 设置键盘右下角按钮样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
//        NSLog(@"initWithFrame-----%@", NSStringFromCGRect(self.leftView.frame));
    }
    
    return self;
}


- (void)layoutSubviews
{
    //把它放在最后是好的
//    [super layoutSubviews];
    
    // 设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    
    
//    NSLog(@"layoutSubviews-----%@", NSStringFromCGRect(self.leftView.frame));
    
    [super layoutSubviews];
}
@end

/*
 2015-10-17 10:20:41.030 MGWeibo[908:36831] initWithFrame-----{{0, 0}, {15, 15}}
 2015-10-17 10:20:41.037 MGWeibo[908:36831] layoutSubviews-----{{0, 0}, {30, 30}}
 */