//
//  SubmitView.m
//  hjoa
//
//  Created by 华剑 on 2017/7/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "SubmitView.h"
#import "Header.h"

@implementation SubmitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIButton *)but
{
    if (!_but) {
        _but = [UIButton buttonWithType:UIButtonTypeCustom];
        _but.frame = CGRectMake(20, 10, kscreenWidth-40, 40);
        _but.backgroundColor = [UIColor colorWithRed:14/255.0 green:100/255.0 blue:250/255.0 alpha:1.0];
        [_but.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_but.layer setBorderWidth:1.0]; //边框宽度
        [_but.layer setBorderColor:[UIColor whiteColor].CGColor];//边框颜色
        _but.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_but setTitle:@"提  交" forState:UIControlStateNormal];
        _but.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_but];
    }
    return _but;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
}


@end
