//
//  ApproveButView.m
//  hjoa
//
//  Created by 华剑 on 2017/5/25.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  审批按钮

#import "ApproveButView.h"
#import "Header.h"
#import "AFNetworking.h"

@interface ApproveButView ()

@property (strong, nonatomic) UIButton *but;
@property (strong, nonatomic) UILabel *verticalLabel;
@end

@implementation ApproveButView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code

    NSArray *name = @[@"通过",@"不通过",@"重新起草",@"延审"];
    for (NSInteger i = 0; i < name.count; i ++) {
        _but = [UIButton buttonWithType:UIButtonTypeCustom];
        _but.tag = i+50;
        _but.frame = CGRectMake(10 + (i*(kscreenWidth/4)), 10, kscreenWidth/5, kscreenWidth/10);
        _but.backgroundColor = [UIColor whiteColor];
//        [_but.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
//        [_but.layer setBorderWidth:1.0]; //边框宽度
//        [_but.layer setBorderColor:[UIColor grayColor].CGColor];//边框颜色
        // 可以在这里对button进行一些统一的设置
        _but.titleLabel.textAlignment = NSTextAlignmentCenter;
        _but.titleLabel.numberOfLines = 0;
        [_but setTitleColor:[UIColor colorWithRed:55/255.0 green:176/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_but setTitleColor:[UIColor colorWithRed:55/255.0 green:176/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_but setTitle:[NSString stringWithFormat:@"%@",name[i]] forState:UIControlStateNormal];
        [_but setTitle:[NSString stringWithFormat:@"%@",name[i]] forState:UIControlStateSelected];
        _but.titleLabel.font = [UIFont systemFontOfSize:17];
//        [self setButtonContentCenter:_but];
        [_but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_but];
    }
    for (int i = 0; i < name.count - 1; i ++) {
        self.verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + (i*(kscreenWidth/4) + 10) + kscreenWidth/5,25,1,15)];
        self.verticalLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:self.verticalLabel];
    }
}

#pragma mark ----审批按钮点击上传参数----
- (void)clickBut:(UIButton *)sender
{
    [self.passButStatuDelegate passButStatus:sender.titleLabel.text];
}



@end
