//
//  MgTabBarButton.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/28.
//  Copyright (c) 2015年 穆良. All rights reserved.
//
// 图标的比例
#define MgTabBarButtonImageRatio 0.6

// 按钮默认文字颜色
#define MgtabBarbuttonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])
// 按钮选中文字颜色
#define MgtabBarbuttonTitleSelectedColor (iOS7 ? [UIColor orangeColor] : MGColor(284,139, 0))

#import "MgTabBarButton.h"
#import "MGBadgeButton.h"


@interface MgTabBarButton()
/**
 *  提醒数字
 */
@property (nonatomic, weak) MGBadgeButton *badgeButton;

@end
@implementation MgTabBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self setTitleColor:MgtabBarbuttonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:MgtabBarbuttonTitleSelectedColor forState:UIControlStateSelected];
        
        // 有些设置操作只需做一次
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
        // 添加提醒数字按钮
        MGBadgeButton *badgeButton = [[MGBadgeButton alloc] init];
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * MgTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * MgTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

// 设置item
- (void)setItem:(UITabBarItem *)item
{
//    NSLog(@"------setItem"); // 只会设置一次的，下次改变是它里面的属性
    _item = item;
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    // 初始化一下
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 *  监听到某个对象的属性改变了,就调用
 *
 *  @param keyPath 属性名
 *  @param object  那个对象的被改变了
 *  @param change  属性发生的改变
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    NSLog(@"-----%@----%@", object, keyPath);
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;

    // 设置提醒数字位置
    CGFloat badgeY = 0;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 3;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}
@end
