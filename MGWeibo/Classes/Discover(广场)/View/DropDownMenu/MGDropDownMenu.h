//
//  MGDropDownMenu.h
//  MGWeibo
//
//  Created by 穆良 on 2017/7/1.
//  Copyright © 2017年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGDropDownMenu : UIView

/// 快速创建menu
+ (instancetype)dropDownMenu;


/**
 显示
 */
- (void)show;

/**
 销毁
 */
- (void)dismiss;
@end
