//
//  IWTabBar.h
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>

@optional
/**
 *  IWTabBar上面的按钮被选中了
 *
 *  @param tabBar 被点击的IWTabBar
 *  @param from   原来按钮的位置
 *  @param to     新选中按钮的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

/**
 *  IWTabBar中间的加号按钮被点击了
 */
- (void)tabBarDidClickedPlusButton:(IWTabBar *)tabBar;
@end

@interface IWTabBar : UIView
/**
 *  添加按钮
 *
 *  @param item 模型数据
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

/**
 *  代理
 */
@property (nonatomic, weak) id<IWTabBarDelegate> delegate;
@end
