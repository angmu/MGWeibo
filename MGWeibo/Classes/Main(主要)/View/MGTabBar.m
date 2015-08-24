//
//  MgTabBar.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/28.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGTabBar.h"
#import "MgTabBarButton.h"

@interface MGTabBar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) MgTabBarButton *selectedButton;
@property (nonatomic, weak) UIButton *plusButton;
@end

@implementation MGTabBar

// 用懒加载只生成一次
- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        if (!iOS7){
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        // 添加加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        
        [self addSubview:plusButton];
        self.plusButton = plusButton;
        
    }
    return self;
}

- (void)addTabBarbuttonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    MgTabBarButton *button = [[MgTabBarButton alloc] init];
    [self addSubview:button];
    
    // 添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
  
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(MgTabBarButton *)button
{
    // 1.通知代理,一般写在前面
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    // NSLog(@"------layoutSubviews");
    
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    CGFloat buttonH = h;
    
    for (int index=0; index<self.tabBarButtons.count; index++) {
        // 1.取出按钮
        MgTabBarButton *button  = self.tabBarButtons[index];
        
        // 2.设置frame
        CGFloat buttonX = buttonW * index;
        if (index > 1) {
            buttonX += buttonW;
        }
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}
@end
