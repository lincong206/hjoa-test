//
//  BaseButtonView.m
//  hjoa
//
//  Created by 华剑 on 2017/9/22.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  底部功能View

#import "BaseButtonView.h"

#define viewWidth self.bounds.size.width
#define viewHeight self.bounds.size.height

@interface BaseButtonView ()

{
    NSArray *_iconArr;
    NSArray *_nameArr;
}

@property (strong, nonatomic) UILabel *xian;

@end

@implementation BaseButtonView

- (UILabel *)xian
{
    if (!_xian) {
        _xian = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 1)];
        _xian.backgroundColor = [UIColor lightGrayColor];
    }
    return _xian;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self addSubview:self.xian];
    
//    _nameArr = @[@"打卡",@"申请",@"统计",@"设置"];
//    _iconArr = @[@"records1_press",@"apply1_press",@"count1_press",@"setting1_press"];
    
    for (int i = 0; i < self.nameArr.count; i ++) {
        self.but = [UIButton buttonWithType:UIButtonTypeCustom];
        self.but.frame = CGRectMake(0+(viewWidth/self.nameArr.count)*i, 0, viewWidth/self.nameArr.count, 50);
        self.but.backgroundColor = [UIColor whiteColor];
        [self.but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.but setTitleColor:[UIColor colorWithRed:57/255.0 green:146/255.0 blue:245/255.0 alpha:1.0] forState:UIControlStateSelected];
        [self.but setTitle:self.nameArr[i] forState:UIControlStateNormal];
        self.but.titleLabel.font = [UIFont systemFontOfSize:15];//12
//        [self.but setImage:[UIImage imageNamed:[_iconArr[i] componentsSeparatedByString:@"_"].firstObject] forState:UIControlStateNormal];
//        [self.but setImage:[UIImage imageNamed:_iconArr[i]] forState:UIControlStateSelected];
        self.but.tag = 200+i;
        [self.but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchDown];

//        self.but.imageEdgeInsets = UIEdgeInsetsMake(0,(self.but.frame.size.width-30)/2, 20, (self.but.frame.size.width-30)/2);

//        if (_iconArr.count == 4) {//大屏幕手机16 小屏幕25
//            if (viewWidth == 375.0) {
//                self.but.titleEdgeInsets = UIEdgeInsetsMake(25,-((self.but.frame.size.width+25)),0,0);
//            }else {
//                self.but.titleEdgeInsets = UIEdgeInsetsMake(25,-((self.but.frame.size.width+16)),0,0);
//            }
//        }else {
//            self.but.titleEdgeInsets = UIEdgeInsetsMake(25,-((self.but.frame.size.width-20)),0,0);
//        }
        [self addSubview:self.but];
        
        if (self.count > 0) {
            if (self.count == self.but.tag) {
                self.but.selected = YES;
            }else {
                self.but.selected = NO;
            }
        }
    }
}

- (void)clickBut:(UIButton *)but
{
    [self.passButDelegate passBaseViewBut:but];
    for (NSInteger i = 0; i < _iconArr.count; i ++) {
        if (but.tag == 200 + i) {
            but.selected = YES;
            continue;
        }
        UIButton *button = (UIButton *)[self viewWithTag:i + 200];
        button.selected = NO;
    }
}


@end
