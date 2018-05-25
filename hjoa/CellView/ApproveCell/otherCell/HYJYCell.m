//
//  HYJYCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "HYJYCell.h"
#import "Header.h"

@interface HYJYCell () <UIWebViewDelegate>

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;

@property (strong, nonatomic) UIWebView *web;

@end

@implementation HYJYCell

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _activityView.backgroundColor = [UIColor whiteColor];
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.center = self.web.center;
        _activity.backgroundColor = [UIColor clearColor];
        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        if ([_activity isAnimating]) {   //获取状态 ，0 NO 表示正在旋转，1 YES 表示没有旋转。
            _activityView.hidden = YES;
        }else {
            _activityView.hidden = NO;
        }
        [_activityView addSubview:_activity];
        [self.web addSubview:_activityView];
    }
    return _activity;
}

- (void)creatHYJYApproveUIWithModel:(HYJYModel *)model
{
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight - 200)];
    [self.passHeightDelegate passHeightFromHYJYCell:kscreenHeight - 200];
    self.web.backgroundColor = [UIColor whiteColor];
    self.web.delegate = self;
    self.web.userInteractionEnabled = true;
    [self.web sizeToFit];
    [self.contentView addSubview:self.web];
    [self.activity startAnimating];
    [self.web loadHTMLString:model.msContrant baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activity stopAnimating];
    _activityView.hidden = YES;
}

@end
