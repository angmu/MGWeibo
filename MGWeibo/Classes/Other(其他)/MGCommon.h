//0.账号相关信息
#define MGAppKey @"3637170628"
#define MGAppSecret @"b4990ef2e737298552a1c8388fca78c3"
#define MGRedirectURI @"https://api.weibo.com/oauth2/default.html"

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define MGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define MGLog(...) NSLog(__VA_ARGS__)
#else
#define MGLog(...)
#endif

//4.根据尺寸判断 是否为4inch
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568)