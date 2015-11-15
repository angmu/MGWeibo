//
//  MGPhotosView.m
//  MGWeibo
//
//  Created by 穆良 on 15/11/15.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "MGPhotosView.h"

@interface MGPhotosView ()
@property (nonatomic, weak) UIImageView *addImageView;

@end

@implementation MGPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        UIImageView *addImageView = [[UIImageView alloc] init];
        _addImageView = addImageView;
        addImageView.image = [UIImage imageWithName:@"compose_pic_add"];
        
        [self addSubview:addImageView];

    }
    
    return self;
}

//- (UIImageView *)addImageView
//{
//    if (!_addImageView) {
//        
//        UIImageView *addImageView = [[UIImageView alloc] init];
//        _addImageView = addImageView;
//        addImageView.image = [UIImage imageWithName:@"compose_pic_add"];
//        
//        [self addSubview:addImageView];
//    }
//    
//    return _addImageView;
//}


- (void)addImage:(UIImage *)image
{
    
    if (self.subviews.count == 10) {
        self.addImageView.hidden = YES;
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    
//    [self addSubview:imageView];
    [self insertSubview:imageView atIndex:0];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat imageViewW = 65;
    CGFloat imageViewH = imageViewW;
    
    int maxCounts = 4; //一行最多显示4行
    CGFloat margin = 10;
    
    for (int i = 0; i < self.subviews.count; i++) {

        UIImageView *imageView = self.subviews[i];
        
        CGFloat imageViewX = margin + (i % maxCounts) * (imageViewW + margin); //贴膜
        CGFloat imageViewY = (i / maxCounts) * (imageViewH +margin);
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }

}

- (NSArray *)totalImages
{
    NSMutableArray *imageViews = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews) {
        
        [imageViews addObject:imageView.image];
    }
    //删除最后一张
    [imageViews removeLastObject];
    return imageViews;
}

@end
