//
//  MGTextView.h
//  MGWeibo
//
//  Created by 穆良 on 15/11/8.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  placeholder的字体颜色 默认是亮灰色
 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
