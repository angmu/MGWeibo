//
//  MGStatusPhotoView.m
//  MGWeibo
//
//  Created by 穆良 on 15/10/19.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "MGStatusPhotoView.h"
#import "MGPhoto.h"
#import "UIImageView+WebCache.h"


@interface MGStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end


@implementation MGStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        //图片的尺寸 就是gifView的尺寸
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        
        _gifView = gifView;
        
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        self.backgroundColor = [UIColor redColor];
        //设置内容模式 不被拉伸，按原来的宽高比 就显示中间一部分
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出边框的都剪掉
        self.clipsToBounds = YES;
        
    }
    
    return self;
}
/**
 *  设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

-(void)setPhoto:(MGPhoto *)photo
{
    _photo = photo;
    
    //设置图片 用SDImage设置
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    //显示\隐藏gif控件
//    if ([photo.thumbnail_pic hasSuffix:@"gif"]) { //判断后缀名
//        //拿到gif控件 不是每张图片都用得着 懒加载 不要加在init里
//        self.gifView.hidden = NO;
//    } else {
//        self.gifView.hidden = YES;
//    }
    //判断是否以gif\GIF结尾 先转成小写
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

@end
