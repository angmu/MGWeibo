//
//  MGComposeToolbar.h
//  MGWeibo
//
//  Created by 穆良 on 15/11/14.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGComposeToolbar;

typedef enum {
    MGComposeToolbarButtonTypeCamera,
    MGComposeToolbarButtonTypePicture,
    MGComposeToolbarButtonTypeMention,
    MGComposeToolbarButtonTypeTrend,
    MGComposeToolbarButtonTypeEmotion,
    
} MGComposeToolbarButtonType;

@protocol MGComposeToolbarDelegaet <NSObject>

@optional
- (void)composeToolbar:(MGComposeToolbar *)toolbar didClickedButton:(MGComposeToolbarButtonType)buttonType;

@end
@interface MGComposeToolbar : UIView
@property (nonatomic, weak) id<MGComposeToolbarDelegaet> delagate;
@end
