//
//  MGTextView.m
//  MGWeibo
//
//  Created by 穆良 on 15/11/8.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "MGTextView.h"

@interface MGTextView ()

@property (nonatomic, weak) UILabel *placeholderLb;

@end

@implementation MGTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //添加
        UILabel *placeholderLb = [[UILabel alloc] init];
        _placeholderLb = placeholderLb;
//        [self addSubview:placeholderLb];
        [self insertSubview:_placeholderLb atIndex:0];
        
        placeholderLb.textColor = [UIColor lightGrayColor];
        placeholderLb.hidden = YES;
        placeholderLb.numberOfLines = 0;
        placeholderLb.font = self.font;
        
        //监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    
    return self;
}
- (void)textDidChange
{
    //自己的文字不等于0时 隐藏placeholderLb
    self.placeholderLb.hidden = (self.text.length != 0);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _placeholderLb.text = placeholder;
    
    if (placeholder.length) {
        self.placeholderLb.hidden = NO;
        
        //计算frame
        
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 * placeholderY;
        CGSize placeholderSize = [placeholder sizeWithFont:_placeholderLb.font constrainedToSize:CGSizeMake(maxW, maxH)];
        
        _placeholderLb.frame = (CGRect){{placeholderX, placeholderY}, placeholderSize};
//        _placeholderLb.frame = self.bounds;
//        [_placeholderLb sizeToFit];
        
        
        
    } else {
        self.placeholderLb.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLb.textColor = placeholderColor;
}
/**
 *  placeholderLb的字体就是 textView的字体 以防字体改变
 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    _placeholderLb.font = font;
    _placeholderLb.text = self.placeholder;
}

@end
