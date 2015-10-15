//
//  MGStatusCell.h
//  MGWeibo
//
//  Created by 穆良 on 15/8/24.
//  Copyright (c) 2015年 穆良. All rights reserved.
//展示微博的cell

#import <UIKit/UIKit.h>
@class MGStatusFrame;

@interface MGStatusCell : UITableViewCell
@property (nonatomic, strong) MGStatusFrame *statusFrame;
/** 快速创建一个cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
