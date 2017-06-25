//
//  MGMacro.h
//  MGWeibo
//
//  Created by 穆良 on 2017/6/17.
//  Copyright © 2017年 穆良. All rights reserved.
//

#ifndef MGMacro_h
#define MGMacro_h




//0.账号相关信息
#define MGAppKey @"3637170628"
#define MGAppSecret @"b4990ef2e737298552a1c8388fca78c3"
#define MGRedirectURI @"https://api.weibo.com/oauth2/default.html"


// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


// 2.获得RGB颜色
#define MGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define MGGlobalBg MGColor(226, 226, 226)

/************ 随机颜色 ************/
#define UIRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]
// rgb颜色转换(十六进制)
#define UIColorWithHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorWithRGB(R,G,B)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define UIColorWithRGBA(R,G,B,A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 导航栏标题颜色
#define IWNavigationBarTitleColor IWColor(65, 65, 65)
// 导航栏标题字体
#define IWNavigationBarTitleFont [UIFont boldSystemFontOfSize:19]

// 导航栏按钮文字颜色
#define IWBarButtonTitleColor (iOS7 ? IWColor(239, 113, 0) : IWColor(119, 119, 119))
#define IWBarButtonTitleDisabledColor IWColor(208, 208, 208)

// 导航栏按钮文字字体
#define IWBarButtonTitleFont (iOS7 ? [UIFont systemFontOfSize:15] : [UIFont boldSystemFontOfSize:12])


// 3.自定义Log
#ifdef DEBUG
#define MGLog(...) NSLog(__VA_ARGS__)
#else
#define MGLog(...)
#endif

//4.根据尺寸判断 是否为4inch
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568)


// 7.数据存储
#define IWUserDefaults [NSUserDefaults standardUserDefaults]

// 主窗口
//#define KEYWindow [UIApplication sharedApplication].keyWindow


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define StatusBar_HEIGHT 20
#define NavigationBar_HEIGHT 44
#define NavigationBarIcon 20
#define TabBar_HEIGHT 49
#define TabBarIcon 30


#endif /* MGMacro_h */
