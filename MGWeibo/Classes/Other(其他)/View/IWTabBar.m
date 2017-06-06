//
//  IWTabBar.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"

@interface IWTabBar()
@property (strong, nonatomic) NSMutableArray *tabBarButtons;
@property (weak, nonatomic) IWTabBarButton *selectedButton;
@property (weak, nonatomic) UIButton *plusButton;
@end

@implementation IWTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        [self addPlusBtn];
    }
    return self;
}

/**
 *  添加+号按钮
 */
- (void)addPlusBtn
{
    // 1.创建按钮
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置背景图片
    UIImage *bg = [UIImage imageWithName:@"tabbar_compose_button"];
    [plusButton setBackgroundImage:bg forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置顶部的+号图片
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    // 4.监听按钮点击
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

/**
 *  监听加号点击
 */
- (void)plusClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

/**
 *  添加按钮
 *
 *  @param item 模型数据
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    IWTabBarButton *button = [[IWTabBarButton alloc] init];
    
    // 2.传递模型数据
    button.item = item;
    
    // 3.添加按钮
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
    
    // 4.默认选中
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听IWTabBarButton点击
 *
 *  @param button 被点击的tabbarButton
 */
- (void)buttonClick:(IWTabBarButton *)button
{
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 1.控制器选中按钮
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.4个按钮
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        IWTabBarButton *button = self.tabBarButtons[index];
        button.tag = index;
        CGFloat buttonX = index * buttonW;
        if (index >= 2) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
    
    // 2.中间的+按钮
    self.plusButton.bounds = (CGRect){CGPointZero, self.plusButton.currentBackgroundImage.size};
    self.plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

@end
