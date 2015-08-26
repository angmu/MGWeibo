//
//  MGUser.h
//  MGWeibo
//
//  Created by 穆良 on 15/8/24.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGUser : NSObject
/** 用户的ID */
@property (nonatomic, copy) NSString *idstr;
/** 用户的名称 */
@property (nonatomic, copy) NSString *name;
/** 用户的图像 */
@property (nonatomic, copy) NSString *profile_image_url;

/** 是否为vip */
@property (nonatomic, assign, getter=isVip) BOOL *vip;

@end
