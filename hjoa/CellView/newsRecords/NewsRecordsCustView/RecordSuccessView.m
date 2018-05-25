//
//  RecordSuccessView.m
//  hjoa
//
//  Created by 华剑 on 2017/9/22.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  打卡成功View

#import "RecordSuccessView.h"

#define viewWidth self.bounds.size.width
#define viewHeight self.bounds.size.height

@interface RecordSuccessView ()

@property (strong, nonatomic) UILabel *timeLabel;       // 时间显示
@property (strong, nonatomic) UILabel *successLabel;    // 状态显示
@property (strong, nonatomic) UILabel *workerLabel;     // 上下班显示
@property (strong, nonatomic) UILabel *xian;            // 分割线

@end

@implementation RecordSuccessView

- (UIButton *)confirmBut
{
    if (!_confirmBut) {
        _confirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBut.frame = CGRectMake(0, viewHeight-30, viewWidth, 30);
        [_confirmBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBut setTitle:@"我知道了" forState:UIControlStateNormal];
        _confirmBut.backgroundColor = [UIColor clearColor];
    }
    return _confirmBut;
}

- (UILabel *)xian
{
    if (!_xian) {
        _xian = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight-31, viewWidth, 1)];
        _xian.backgroundColor = [UIColor whiteColor];
    }
    return _xian;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, viewWidth, 50)];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:17];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UILabel *)successLabel
{
    if (!_successLabel) {
        _successLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, viewWidth, 50)];
        _successLabel.backgroundColor = [UIColor clearColor];
        _successLabel.textAlignment = NSTextAlignmentCenter;
        _successLabel.textColor = [UIColor whiteColor];
        _successLabel.font = [UIFont systemFontOfSize:20];
    }
    return _successLabel;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 状态
    self.successLabel.text = @"打卡成功";
    [self addSubview:self.successLabel];
    
    // 分割线
    [self addSubview:self.xian];
    // 按钮
    [self addSubview:self.confirmBut];
}

- (void)refreshSuccessTime:(NSString *)time
{
    // 时间
    NSArray *timeArr = [[time componentsSeparatedByString:@" "].lastObject componentsSeparatedByString:@":"];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@:%@",self.am,timeArr.firstObject,timeArr[1]];
    [self addSubview:self.timeLabel];
}


@end
