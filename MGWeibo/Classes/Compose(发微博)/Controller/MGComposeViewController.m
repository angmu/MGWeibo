//
//  MGComposeViewController.m
//  MGWeibo
//
//  Created by 穆良 on 15/11/8.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "MGComposeViewController.h"
#import "MGPlaceholderTextView.h"
#import "MGAccount.h"
#import "MGAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "MGComposeToolbar.h"
#import "MGPhotosView.h"

#import "MGHttpTool.h"
#import "AFNetworking.h"

@interface MGComposeViewController () <UITextViewDelegate, MGComposeToolbarDelegaet, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) MGPlaceholderTextView *textView;
@property (nonatomic, weak) MGComposeToolbar *toolbar;
//@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) MGPhotosView *photosView;

@end

@implementation MGComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏属性
    [self setupNavBar];
    
    //添加textView
    [self setupTextView];
    
    //添加toolbar
    [self setupToolbar];
    
//    //添加imageView
//    [self setupImageView];
    //添加photosView
    [self setupPhotosView];
}

/**
 *  添加toolbar
 */
- (void)setupToolbar
{
    
    MGComposeToolbar *toolbar = [[MGComposeToolbar alloc] init];
    _toolbar = toolbar;
    [self.view addSubview:toolbar];
    
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.size.width;
    CGFloat toolbarY = self.view.size.height - toolbarH;
    toolbar.frame = CGRectMake(0, toolbarY, toolbarW, toolbarH);
    toolbar.delagate = self;
}

/**
 *  添加imageView
 */
//- (void)setupImageView
//{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    _imageView = imageView;
//    [self.textView addSubview:imageView];
//    
//    imageView.frame = CGRectMake(5, 100, 60, 60);
//}

- (void)setupPhotosView
{
    MGPhotosView *photosView = [[MGPhotosView alloc] init];
    _photosView = photosView;
    
    CGFloat photosViewY = 80;
    CGFloat photosViewW = self.textView.width;
    CGFloat photosViewH = self.textView.height - photosViewY;
    photosView.frame = CGRectMake(0, photosViewY, photosViewW, photosViewH);
//    photosView.backgroundColor = [UIColor redColor];
    
    [self.textView addSubview:photosView];
}

/**
 *  添加textView
 */
- (void)setupTextView
{
    //1、添加textView
    MGPlaceholderTextView *textView = [[MGPlaceholderTextView alloc] init];
    
    textView.frame = self.view.bounds;
    textView.width = 200;
    textView.placeholder = @"分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...";
    textView.delegate = self;
//    textView.font = [UIFont systemFontOfSize:20];
    
    [self.view addSubview:textView];
    _textView = textView;
    
    // 2、监听textView文字改变的通知,发送按钮可点击,直接用文字改变的代理方法也行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3、监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(MGComposeToolbar *)toolbar didClickedButton:(MGComposeToolbarButtonType)buttonType
{
    
    switch (buttonType) {
        case MGComposeToolbarButtonTypeCamera: //相机
            [self openCamera];
            break;
        case MGComposeToolbarButtonTypePicture: //相册
            [self openPhotoLibrary];
//            MGLog(@"相册-----");
            break;
        case MGComposeToolbarButtonTypeMention:
            break;
            
        case MGComposeToolbarButtonTypeTrend:
            break;
        case MGComposeToolbarButtonTypeEmotion:
            break;
            
        default:
            break;
    }
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


#pragma mark - 图片选择控制器的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //不需要判断 图片是从哪里来的
    
    //1、销毁 图片选中控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
//    _imageView.image = image;
    [self.photosView addImage:image];
}

/**
 *  键盘即将显示时调用
 */
- (void)keyboardWillShow:(NSNotification *)notice
{
    //1、取出键盘的frame
    CGRect keyboardF = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //2、取出键盘弹出的时间
    CGFloat duration = [notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //3、往上走键盘的高度
    [UIView animateWithDuration:duration animations:^{
        
        _toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}
/**
 *  键盘即将显示时调用
 */
- (void)keyboardWillHide:(NSNotification *)notice
{
    //1、取出键盘弹出的时间
    CGFloat duration = [notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //2、往下走键盘的高度
    [UIView animateWithDuration:duration animations:^{
        
        _toolbar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 滚动隐藏键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.title = @"发微博";
    
    //设置背景
    self.view.backgroundColor = [UIColor blackColor];
    
    //类加载完毕 设置导航栏内容
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    //文字还是显示不了 亮灰色 ？？小bug不是程序的错
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self.textView becomeFirstResponder];
//}

/**
 *  监听文字的改变
 */
- (void)textDidChange
{
//    NSLog(@"------%@", self.textView.text);
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}
/**
 *  取消
 */
- (void)cancel
{
//    self.textView.font = [UIFont systemFontOfSize:14];
//    self.textView.placeholder = @"2234343534";
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发微博
- (void)send
{
    MGLog(@"%s", __func__);
    
    //self.imageView.image
    if (self.photosView.totalImages.count) { //有图片
        
        [self sendWithImage];
    } else { //没有图片
        [self sendWithoutImage];
    }
    
    //关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送有图片的微博
 */
- (void)sendWithImage
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MGAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //2.封装文件参数
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *images = self.photosView.totalImages;
    
    for (UIImage *image in images) {
        
        MGFormData *formData = [[MGFormData alloc] init];
        formData.data = UIImageJPEGRepresentation(image, 0.5);
        formData.name = @"pic";
        formData.filename = @"";
        formData.mimeType = @"image/jpeg";
        [formDataArray addObject:formData];
    }
    
    //3.发送网络请求
    [MGHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id json) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    
//    // 1.创建请求管理类
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    // 说明服务器返回的JSON数据
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    // 2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"access_token"] = [MGAccountTool account].access_token;
//    params[@"status"] = self.textView.text;
////    params[@"pic"] = UIImageJPEGRepresentation(self.imageView.image, 0.5);
//    
//    // 3.发送请求
//    [mgr POST: parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        //在发送请求之前 会自动调用这个block
//        
//        //必须在这里说明要上传 那些文件
////        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 0.5);
////        //name 服务器接收数据的字段名, fileName上传到服务器上文件名,写个空即可, mimeType文件类型
////        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
//        
//        NSArray *images = self.photosView.totalImages;
//        int count = 0;
//        for (UIImage *image in images) {
//            count++;
//            NSString *fileName = [NSString stringWithFormat:@"%02d.jpg", count];
//            NSData *data = UIImageJPEGRepresentation(image, 0.5);
//            //name 服务器接收数据的字段名, fileName上传到服务器上文件名,写个空即可, mimeType文件类型
//            [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/jpeg"];
//        }
//        
//        
//    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [MBProgressHUD showError:@"发送失败"];
//    }];
}

/**
 *  发送没有图片的微博
 */
- (void)sendWithoutImage
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MGAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //2.发送请求
    [MGHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"发送失败"];
    }];
}

@end
