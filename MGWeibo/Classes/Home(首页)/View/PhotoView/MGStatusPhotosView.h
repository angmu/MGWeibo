//
//  MGStatusPhotosView.h
//  MGWeibo
//
//  Created by 穆良 on 15/10/18.
//  Copyright © 2015年 穆良. All rights reserved.
//cell上的配图 里面会显示1-9张图片

#import <UIKit/UIKit.h>

@interface MGStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;
/** 根据图片个数计算相册的尺寸 */
+ (CGSize)sizeWithCount:(int)count;
@end
