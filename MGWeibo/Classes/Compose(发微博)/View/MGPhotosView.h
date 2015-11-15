//
//  MGPhotosView.h
//  MGWeibo
//
//  Created by 穆良 on 15/11/15.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPhotosView : UIView

/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 */
- (NSArray *)totalImages;
@end