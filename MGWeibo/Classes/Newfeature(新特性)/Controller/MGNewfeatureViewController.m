//
//  MGNewfeatureViewController.m
//  MgWeibo
//
//  Created by 穆良 on 15/7/3.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#define MGNewfeatureCount 3
#import "MGNewfeatureViewController.h"
#import "MGTabBarController.h"

@interface MGNewfeatureViewController() <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end


@implementation MGNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 0.设置背景UIScrollView的背景
    self.view.backgroundColor = MGColor(246, 246, 246);
    
    // 1.添加UIScrollView
    [self setupScrollView];
    
    // 2.设置pageControl
    [self setupPageControl];
}

/**
 *  设置pageControl
 */
- (void)setupPageControl
{
    // 1.增加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = MGNewfeatureCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30); // 不用frame,这样又会把x\y給抵消掉
    pageControl.userInteractionEnabled = NO;
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 设置小圆点的颜色
    pageControl.currentPageIndicatorTintColor = MGColor(250, 99, 42);
    pageControl.pageIndicatorTintColor = MGColor(189, 189, 189);
}

/**
 *  添加UIScrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
    // 添加背景图片
    for (int index = 0; index < MGNewfeatureCount; index++) {
        UIImageView *imageView = [[UIImageView alloc ] init];
        // 设置图片
        NSString *name = nil;
        //根据尺寸判断
        if (is4Inch) {
            name = [NSString stringWithFormat:@"new_feature_%d-568h", index+1];
        } else {
            name = [NSString stringWithFormat:@"new_feature_%d", index+1];
        }
        imageView.image = [UIImage imageNamed:name];
        
        // 设置frame
        CGFloat imageX = imageW * index;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 在最后一个图片上面添加按钮
        if (index == MGNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 设置scrollView滚动的属性
    scrollView.contentSize = CGSizeMake(MGNewfeatureCount * imageW, imageH);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
}

/**
 *  添加内容到最后一张图片上
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage resizeimageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage resizeimageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];

    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6 ;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 3.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    
    // 4.添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.selected = YES;
     
    // 设置frame
    checkbox.bounds = CGRectMake(0, 0, 200, 30);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    
    [checkbox setTitle:@"分享给大家"  forState:UIControlStateNormal];
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 9);
    [imageView addSubview:checkbox];
}

- (void)checkboxClick:(UIButton *)checkbox
{
    // 选中状态取反
    checkbox.selected = !checkbox.selected;
}

- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    // 拿到窗口的根控制器
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[MGTabBarController alloc] init];
    self.view.window.rootViewController = [[MGTabBarController alloc] init];
    
}

- (void)dealloc
{
//    MGLog(@"dealloc---------");
}

#pragma mark scrollView的控制器
/**
 *  只要UIScrollView滚动了,就自动调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    double offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
//    MGLog(@"------%f-----%d", pageDouble, pageInt);
 
    self.pageControl.currentPage = pageInt;
}

@end
