//
//  SPListCell.m
//  hjoa
//
//  Created by 华剑 on 2018/6/6.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "SPListCell.h"
#import "SPListModel.h"

@interface SPListCell ()
{
    UIFont *_fnt;
}

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) SPListModel *model;

@end
@implementation SPListCell

- (UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.bounces = NO;
        _scroll.pagingEnabled = NO;
    }
    return _scroll;
}

- (void)refreSPListUIWithData:(NSMutableArray *)data
{
    self.data = data;
    
    _fnt = [UIFont systemFontOfSize:12];
    NSArray *titleArr = @[@"流水号",@"开票日期",@"发票抬头",@"纳税人识别号",@"发票录入人",@"发票类型",@"发票号码",@"不含税金额（元)",@"发票代码",@"税额(元)",@"税率",@"含税金额(元)",@"状态"];
    self.scroll.frame = self.contentView.bounds;
    self.scroll.contentSize = CGSizeMake((titleArr.count * 110) + 10, self.contentView.bounds.size.height);
    
    // 标题
    for (int i = 0; i < titleArr.count; i ++) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) * i, 5, 100, 20)];
        title.backgroundColor = [UIColor whiteColor];
        title.text = titleArr[i];
        title.font = _fnt;
        title.textAlignment = NSTextAlignmentCenter;
        if (title.text == nil || [title.text isEqualToString:@"(null)"] || [title.text isEqual:[NSNull alloc]] || [title.text isEqualToString:@""] || [title.text isEqualToString:@" "] || [title.text isEqualToString:@"<null>"]) {
            title.text = @"--";
        }
        [self.scroll addSubview:title];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *0, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self.data[j] ideOther];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *1, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [[self.data[j] ideTime] componentsSeparatedByString:@" "].firstObject;
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *2, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self.data[j] ideOtheres];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *3, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self.data[j] ideShibienum];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *5, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self.data[j] ideOthers];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *6, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self.data[j] ideType];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *6, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self.data[j] ideNumber];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *7, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] ideExincludeprice]];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *8, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self.data[j] ideCode];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *9, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] ideTax]];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *10, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] ideRate]];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *11, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] ideIncludeprice]];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *12, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        if ([self.data[j] ideStatus].integerValue == 0) {
            self.name.text = @"未登记";
        }else {
            self.name.text = @"已登记";
        }
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    [self.contentView addSubview:self.scroll];
}

@end
