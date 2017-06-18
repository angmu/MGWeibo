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
    if (self = [super initWithFrame:frame]) {
        // 背景
        self.background = [UIImage resizeimageWithName:@"searchbar_textfield_background"];
        // 左边放大镜
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.frame = CGRectMake(0, 0, 30, 30);
        
        searchIcon.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // placehoder颜色
//        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搜索条件" attributes:attrs];
        self.placeholder = @"请输入搜索条件";
        
        // 设置键盘右下角按钮样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

@end
