//
//  MgMeViewController.m
//  MgWeibo
//
//  Created by 穆良 on 15/6/27.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGMineViewController.h"

#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"
#import "IWSystemSettingViewController.h"

@interface MGMineViewController ()

@end

@implementation MGMineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    LxDBAnyVar([self class]);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

/**
 *  设置
 */
- (void)setting
{
    IWSystemSettingViewController *sys = [[IWSystemSettingViewController alloc] init];
    [self.navigationController pushViewController:sys animated:YES];
}

- (void)setupGroup0
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *newFriend = [IWSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.badgeValue = @"4";
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *album = [IWSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.subtitle = @"(109)";
    IWSettingArrowItem *collect = [IWSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.subtitle = @"(0)";
    IWSettingArrowItem *like = [IWSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.badgeValue = @"1";
    like.subtitle = @"(35)";
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *pay = [IWSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    IWSettingArrowItem *vip = [IWSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}

- (void)setupGroup3
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *card = [IWSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    IWSettingArrowItem *draft = [IWSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}

@end
