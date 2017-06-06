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
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
