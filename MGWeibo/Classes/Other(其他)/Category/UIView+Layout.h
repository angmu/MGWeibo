//
//  UIView+Layout.h
//  MGWeibo
//
//  Created by 穆良 on 15/10/18.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

/** 顶部y值 */
@property (assign, nonatomic) CGFloat top;
/** 底部y值 */
@property (assign, nonatomic) CGFloat bottom;
/** 最左边x值 */
@property (assign, nonatomic) CGFloat left;
/** 最右边x值 */
@property (assign, nonatomic) CGFloat right;

/** 坐标x值 */
@property (assign, nonatomic) CGFloat x;
/** 坐标y值 */
@property (assign, nonatomic) CGFloat y;
/** 坐标点 */
@property (assign, nonatomic) CGPoint origin;

/** 中心x值 */
@property (assign, nonatomic) CGFloat centerX;
/** 中心y值 */
@property (assign, nonatomic) CGFloat centerY;

/** 宽度 */
@property (assign, nonatomic) CGFloat width;
/** 高度 */
@property (assign, nonatomic) CGFloat height;
/** 尺寸 */
@property (assign, nonatomic) CGSize size;

@end
