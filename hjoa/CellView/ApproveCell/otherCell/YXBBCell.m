//
//  YXBBCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "YXBBCell.h"
#import "Header.h"
#import <WebKit/WebKit.h>

@interface YXBBCell () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *web;

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;

@end

@implementation YXBBCell

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight*0.7)];
        _activityView.backgroundColor = [UIColor clearColor];
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.center = _activityView.center;
        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        if ([_activity isAnimating]) {   //获取状态 ，0 NO 表示正在旋转，1 YES 表示没有旋转。
            _activityView.hidden = YES;
        }else {
            _activityView.hidden = NO;
        }
        [_activityView addSubview:_activity];
        [self addSubview:_activityView];
    }
    return _activity;
}

- (void)loadWeb:(NSString *)rfrId
{
    self.web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight*0.7)];
    self.web.backgroundColor = [UIColor whiteColor];//da/reportFromsRecord/reportFromsRecordInfo.jsp?rfrId=
    NSString *url = [NSString stringWithFormat:@"%@/da/reportFromsRecord/reportFromsRecordInfo.jsp?rfrId=%@&status=app",intranetURL,rfrId];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    self.web.navigationDelegate = self;
    [self.contentView addSubview:self.web];
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self.activity startAnimating];
    self.activityView.hidden = NO;
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.activity stopAnimating];
    self.activityView.hidden = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
