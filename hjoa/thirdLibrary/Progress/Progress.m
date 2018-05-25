//
//  Progress.m
//  text
//
//  Created by 华剑 on 2018/1/12.
//  Copyright © 2018年 HJJS. All rights reserved.
//

#import "Progress.h"

@interface Progress ()
{
    UIImageView *_trackView;
    UIImageView *_progressView;
}
@end
@implementation Progress

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height/2.0;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        // 背景图像
        _trackView = [[UIImageView alloc] initWithFrame:CGRectMake (0, 0, frame.size.width, frame.size.height)];
        _trackView.backgroundColor = [UIColor lightGrayColor];
        //当前view的主要作用是将出界了的_progressView剪切掉，所以需将clipsToBounds设置为YES
        _trackView.clipsToBounds = YES;
        _trackView.layer.cornerRadius = _trackView.frame.size.height/2.0;
        _trackView.layer.shouldRasterize = YES;
        _trackView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self addSubview:_trackView];
        // 填充图像
        _progressView = [[UIImageView alloc] initWithFrame:CGRectMake (0, 0, 0, frame.size.height)];
        _progressView.backgroundColor = [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0];
        [_trackView addSubview:_progressView];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progressView.frame = CGRectMake (0, 0, self.frame.size.width * progress, self.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
