//
//  UIBarButtonItem+MG.h
//  MgWeibo
//
//  Created by 穆良 on 15/7/1.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  快速创建一个显示图片的item
 */
+ (instancetype)itemWithTarget:(id)target action:(SEL)action icon:(NSString *)icon highIcon:(NSString *)highIcon;
@end
