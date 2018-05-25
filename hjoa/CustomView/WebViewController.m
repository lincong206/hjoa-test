//
//  WebViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/6/2.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "WebViewController.h"
#import "CLAmplifyView.h"

@interface WebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *web;

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = YES;
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *endName = [self.path componentsSeparatedByString:@"."].lastObject;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([endName isEqualToString:@"zip"] || [endName isEqualToString:@"rar"]) {
        //压缩
        
    } else if ([endName isEqualToString:@"mp3"]) {
        //音乐
    
    } else if ([endName isEqualToString:@"mp4"] || [endName isEqualToString:@"mov"] || [endName isEqualToString:@"rmvb"] || [endName isEqualToString:@"mpg"] || [endName isEqualToString:@"wmv"]) {
        //视频
        
    } else {  //未知类型文件
        
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = webView.scrollView.contentSize; //设置内容板块的尺寸
    CGSize viewSize = self.view.bounds.size;//自适应边界值
    float sfactor = viewSize.width / contentSize.width;//调整因子计算
    webView.scrollView.minimumZoomScale = sfactor;//最大调整参数设置为调整因子
    webView.scrollView.maximumZoomScale = sfactor;//最小调整参数设置为调整因子
    webView.scrollView.zoomScale = sfactor;  //设置本身无缩放，自适应
#if 0
    //    2、都有效果
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
#endif
}

@end
