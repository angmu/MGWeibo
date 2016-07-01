//0.账号相关信息
#define MGAppKey @"3637170628"
#define MGAppSecret @"b4990ef2e737298552a1c8388fca78c3"
#define MGRedirectURI @"https://api.weibo.com/oauth2/default.html"


// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define MGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define MGGlobalBg MGColor(232, 233, 232)
// 3.自定义Log
#ifdef DEBUG
#define MGLog(...) NSLog(__VA_ARGS__)
#else
#define MGLog(...)
#endif

//4.根据尺寸判断 是否为4inch
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568)

/** 昵称的字体 */
#define MGStatusNameFont [UIFont systemFontOfSize:14]
/** 被转发微博的昵称的字体 */
#define MGRetweetStatusNameFont MGStatusNameFont
/** 时间的字体 */
#define MGStatusTimeFont [UIFont systemFontOfSize:13]
/** 来源的字体 */
#define MGStatusSourceFont MGStatusTimeFont
/** 正文的字体 */
#define MGStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博的正文的字体 */
#define MGRetweetStatusContentFont MGStatusContentFont

/** cell的边框宽度 */
#define MGStatusCellBorder 7
/** 表格的边框宽度 */
#define MGStatusTableBorder 4

/** cell之间的间距 */
#define MGStatusCellMargin 5

/** 表格边框的宽度 */
//extern const CGFloat IWTableBorderW;
/** cell之间的间距 */
//extern const CGFloat IWCellMargin;


// 导航栏标题颜色
#define IWNavigationBarTitleColor IWColor(65, 65, 65)
// 导航栏标题字体
#define IWNavigationBarTitleFont [UIFont boldSystemFontOfSize:19]

// 导航栏按钮文字颜色
#define IWBarButtonTitleColor (iOS7 ? IWColor(239, 113, 0) : IWColor(119, 119, 119))
#define IWBarButtonTitleDisabledColor IWColor(208, 208, 208)

// 导航栏按钮文字字体
#define IWBarButtonTitleFont (iOS7 ? [UIFont systemFontOfSize:15] : [UIFont boldSystemFontOfSize:12])

// 6.常用的尺寸
/** 表格边框的宽度 */
extern const CGFloat IWTableBorderW;
/** cell之间的间距 */
extern const CGFloat IWCellMargin;

// 7.数据存储
#define IWUserDefaults [NSUserDefaults standardUserDefaults]
