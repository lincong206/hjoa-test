//
//  NewsViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *chatActivity;

@property (assign, nonatomic) BOOL isLogin;

@end

@implementation NewsViewController

- (UIActivityIndicatorView *)chatActivity
{
    if (!_chatActivity) {
        _chatActivity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _chatActivity.center = self.view.center;
    }
    return _chatActivity;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_chatActivity startAnimating];
    if (self.isLogin) {
        // 已经登录
        
    }else {
        // 进行登录操作
        
    }
    
}
/*
// 注册环信账号密码，进行登录  登录成功 isLogin=yes
一旦登录成功且不退出登录的话，下次不需要登录状态
// 获取聊天记录

// 添加新的好友

// 退出登录时  需要监听 我 页面中的退出按钮是否响应
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

















}



@end
