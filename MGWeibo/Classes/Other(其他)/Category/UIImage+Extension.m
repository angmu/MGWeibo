//
//  UIImage+Mg.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizeimageWithName:(NSString *)name
{
    return [UIImage resizeimageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizeimageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)resizedImage:(NSString *)imageName
{
    return [UIImage resizeimageWithName:imageName left:0.5 top:0.5];
}

@end
