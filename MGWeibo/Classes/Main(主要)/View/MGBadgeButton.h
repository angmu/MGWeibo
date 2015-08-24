//
//  MgBadgeBttin.h
//  MgWeibo
//
//  Created by 穆良 on 15/6/29.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGBadgeButton : UIButton
// 外面给我传一个copy字符串
@property (nonatomic, copy) NSString *badgeValue;
@end
