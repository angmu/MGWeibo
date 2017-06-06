//
//  MGStatusToolbar.m
//  MGWeibo
//
//  Created by 穆良 on 15/10/11.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "MGStatusToolBar.h"
#import "MGStatus.h"

@interface MGStatusToolBar ()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

/** 转发按钮 */
@property (nonatomic, weak) UIButton *reweetBtn;
/** 评论按钮 */
@property (nonatomic, weak) UIButton *commentBtn;
/** 点赞按钮 */
@property (nonatomic, weak) UIButton *attituBtn;
@end

@implementation MGStatusToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return  _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //1.设置图片
        self.image = [UIImage resizeimageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizeimageWithName:@"timeline_card_bottom_background_highlighted"];
        
        //2.添加按钮
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        self.attituBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        //3.添加分割线
        [self setupDivider];
        [self setupDivider];
    
    }
    return self;
}

- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始化按钮
 *
 *  @param title   按钮的文字
 *  @param image   按钮的小图标
 *  @param bgImage 按钮的背景
 */
- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    //设置图片和文字之间的间距
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    //设置按钮高亮不调整图片
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizeimageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //1.设置按钮的frame
    NSInteger btnCount = self.btns.count; //按钮的个数
    CGFloat dividerW = 2;
    NSInteger dividerCount = self.dividers.count;
    
    CGFloat btnW = (self.frame.size.width - dividerW * dividerCount)  / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i=0; i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        
        //设置frame
        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    //2.设置分割线的frame
    CGFloat dividerH = self.frame.size.height;
    CGFloat dividerY = 0;
    for (int j=0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        
        //设置frame
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

- (void)setStatus:(MGStatus *)status
{
    _status = status;

//    status.reposts_count = 40342; //4万
//    status.comments_count = 10242; //1万
//    status.attitudes_count = 172896; //17.3万
    
    //设置按钮数据
    [self setupBtn:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    [self setupBtn:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    [self setupBtn:self.attituBtn originalTitle:@"赞" count:status.attitudes_count];
}

/**
 *  设置按钮的显示标题
 *
 *  @param btn           那个按钮点击了
 *  @param originalTilte 按钮额原始标题
 *  @param count         显示的个数
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTilte count:(int)count
{
/*
 0 -> @"转发"
 <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
 >= 10000
 * 整万(10100, 20326, 30000 ....) : 1万, 2万
 * 其他(14364) : 1.4万
 */
    if (count) { //个数不为0
        NSString *title = nil;
        if (count < 10000) { //小于1万
            title = [NSString stringWithFormat:@"%d", count];
            
        } else {

            // 42342 / 10000.0  = 4.2342
            double countDouble = count / 10000.0;
            // 10742 / 1000 * 0.1 = 10.742 * 0.1 = 1.0742
            //保留一位小数 会四舍五入
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            //title == 4.2万 4.0万 1.0万 1.1万
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:originalTilte forState:UIControlStateNormal];
    }
}
@end
