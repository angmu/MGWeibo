//
//  MGStatusPhotosView.m
//  MGWeibo
//
//  Created by 穆良 on 15/10/18.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "MGStatusPhotosView.h"
#import "MGPhoto.h"
#import "MGStatusPhotoView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

#import "MGPhoto.h"


#define MGStatusPhotoWH 70
#define MGStatusPhotoMargin 10
#define MGStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation MGStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    //先把成员变量存起来
    _photos = photos;
    
    //很多细节
    NSUInteger photoCount = photos.count;
   
    //创建缺少的imageView
    while (self.subviews.count < photoCount) {
        MGStatusPhotoView *photoView = [[MGStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    //变量图片控件 设置图片
    for (int i=0; i<self.subviews.count; i++) {
        MGStatusPhotoView *photoView = self.subviews[i];
        //这里可能self.subviews.count > photoCount要隐藏
        if (i < photoCount) { //显示
            
            photoView.photo = photos[i];
            photoView.hidden = NO;
            
            //每一张图片 都可以点击
            photoView.tag = i; //知道点击了 那个view
            photoView.userInteractionEnabled = YES;
            
            //添加手势识别器 监听点击的手势
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            
        } else { //隐藏
            photoView.hidden = YES;
        }
    }
}

//轻敲图片  把手势识别器传给我 点击图片做什么事情
- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
//    NSLog(@"点击了图片。。。。%zd", recognizer.view.tag);
    NSUInteger count = self.photos.count;
    
    //1、封装图片数据
    NSMutableArray *mjphotoM = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        
        //创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        MGPhoto *photo = self.photos[i];
        mjphoto.srcImageView = self.subviews[i];
        
        NSString *urlStr = photo.thumbnail_pic;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:urlStr];
        
        [mjphotoM addObject:mjphoto];
    }
    
    //2、显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; //点击图片的位置
    browser.photos = mjphotoM;
    [browser show];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    NSUInteger photoCount = self.photos.count;
    int maxCol = MGStatusPhotoMaxCol(photoCount);
    
    for (int i=0; i< photoCount; i++) {
        MGStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        int row = i / maxCol;
        
        CGFloat photoViewX = col * (MGStatusPhotoWH + MGStatusPhotoMargin);
        CGFloat photoViewY = row * (MGStatusPhotoWH + MGStatusPhotoMargin);
        CGFloat photoViewWH = MGStatusPhotoWH;
        photoView.frame = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
        
    }
    
}

/**
 *  根据配图的个数 确定尺寸
 */
+ (CGSize)sizeWithCount:(int)count
{
    int maxCol = MGStatusPhotoMaxCol(count);
    //count很来到这 可定大于0
    int cols = (count > maxCol)? maxCol :count;
    CGFloat photoViewW = MGStatusPhotoWH * cols + MGStatusPhotoMargin * (cols - 1);
    
    int rows = (count + maxCol -1 ) / maxCol;
    CGFloat photoViewH = MGStatusPhotoWH * rows + MGStatusPhotoMargin * (rows - 1);
    
    return CGSizeMake(photoViewW, photoViewH);
}

@end
