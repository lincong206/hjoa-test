//
//  ClickNewsViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/8/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "ClickNewsViewController.h"

@interface ClickNewsViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *web;

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;

@end

@implementation ClickNewsViewController

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.backgroundColor = [UIColor clearColor];
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.center = self.view.center;
        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        if ([_activity isAnimating]) {   //获取状态 ，0 NO 表示正在旋转，1 YES 表示没有旋转。
            _activityView.hidden = YES;
        }else {
            _activityView.hidden = NO;
        }
        [_activityView addSubview:_activity];
        [self.view addSubview:_activityView];
    }
    return _activity;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"企业要闻";
    
    [self.activity startAnimating];
    self.activityView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.web.backgroundColor = [UIColor clearColor];
    self.web.opaque = NO;
    self.web.delegate = self;
    [self.view addSubview:self.web];
    [self.web loadHTMLString:self.htmlStr baseURL:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activity startAnimating];
    self.activityView.hidden = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activity startAnimating];
    self.activityView.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error) {
        [self showAlertControllerMessage:@"加载失败，请稍后再试" andTitle:@"提示" andIsPre:NO];
    }
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsPre:(BOOL)isP;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isP) {
            // 回到上个页面
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
