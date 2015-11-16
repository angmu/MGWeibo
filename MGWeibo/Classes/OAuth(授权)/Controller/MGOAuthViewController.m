//
//  MGOAuthViewController.m
//  MGWeibo
//
//  Created by 穆良 on 15/7/31.
//  Copyright (c) 2015年 穆良. All rights reserved.
//

#import "MGOAuthViewController.h"
//#import "AFNetworking.h"
#import "MGAccount.h"
#import "MGWeiboTool.h"
#import "MGAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "MGHttpTool.h"

@interface MGOAuthViewController () <UIWebViewDelegate>

@end

@implementation MGOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面(新浪提供的登录页面)
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", MGAppKey,  MGRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *reequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:reequest];
}


#pragma mark - webView代理方法
/**
 *  webView开始发送请求时调用
 */
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"哥正在帮你加载..."];
}

/**
 *  webView结束发送请求时调用
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/*
 *  webView请求失败时调用
 */
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前，都会先调用这个方法,询问代理可不可以加载这个页面的请求
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    MGLog(@"%@", request.URL);
    // 1.请求的URL路径
    //https://api.weibo.com/oauth2/default.html?code=dec6952c6c56c300f5e58aa9c3fa95bb
    NSString *urlStr = request.URL.absoluteString;
    // 2.查找code=在urlStr中得范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含code=
//    if (range.location != NSNotFound)
    if (range.length) {
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        NSInteger loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 5.发送POST请求给新浪，通过code换取一个accessToken访问标记
        [self accessTokenWithCode:code];
        
        //肯定是回调页面
        return NO;
    }
    return YES;
}

//用自己封装的网络请求
- (void)accessTokenWithCode:(NSString *)code
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = MGAppKey;
    params[@"client_secret"] = MGAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = MGRedirectURI;
    
    [MGHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        
        //1.先将字典转成模型
        MGAccount *account = [MGAccount accountWithDict:json];
        
        //2.存储accessToken信息,下次不需要登录
        [MGAccountTool saveAccount:account];
        
        //3.去新特新\首页
        [MGWeiboTool chooseRootController];
        
        //4.隐藏提醒框
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        
        //4.隐藏提醒框
        [MBProgressHUD hideHUD];
    }];
}

/*

- (void)accessTokenWithCode:(NSString *)code
{
    // ASI: HTTP终结者,停止更新，潜在bug
    // AFNetworking\AFN
    // 1.创建请求管理类
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 说明服务器返回的JSON数据
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = MGAppKey;
    params[@"client_secret"] = MGAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = MGRedirectURI;

    
    
    //    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain​", nil];
    // 3.发送请求
    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    //    NSString *encoded = [link stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //    MGLog(@"link=%@, encoded=%@ ,解码=%@", urlStr, encoded,[encoded stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    // 2.00xRuvQC5OMJyDe819844d9d0Soj1E
    [mgr POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        // 4.先将字典转成模型
        MGAccount *account = [MGAccount accountWithDict:responseObject];
        
        // 5.存储accessToken信息,下次不需要登录
        [MGAccountTool saveAccount:account];
        
        // 6.去新特新\首页
        [MGWeiboTool chooseRootController];
        
        // 7.隐藏提醒框
        [MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        MGLog(@"请求失败:%@", error);
        // 7.隐藏提醒框
        [MBProgressHUD hideHUD];
        
    }];
}
 */
@end
