//
//  MgTabBar.h
//  MgWeibo
//
//  Created by 穆良 on 15/6/28.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGTabBar;

@protocol MGTabBarDelegate <NSObject>
@optional
- (void)tabBar:(MGTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
//tabBar点击了加号按钮
- (void)tabBarDidClickedPlusBtton:(MGTabBar *)tabBar;

@end


@interface MGTabBar : UIView
// 添加按钮
- (void)addTabBarbuttonWithItem:(UITabBarItem *)item;
@property (nonatomic, weak) id<MGTabBarDelegate> delegate;

@end


