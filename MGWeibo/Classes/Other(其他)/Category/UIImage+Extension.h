//
//  UIImage+Mg.h
//  MgWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizeimageWithName:(NSString *)name;
+ (UIImage *)resizeimageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)resizedImage:(NSString *)imageName;
@end
