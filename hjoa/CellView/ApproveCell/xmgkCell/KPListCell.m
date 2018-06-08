//
//  KPListCell.m
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "KPListCell.h"
#import "KPListModel.h"

@interface KPListCell ()
{
    UIFont *_fnt;
}

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) KPListModel *model;

@end

@implementation KPListCell

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

- (void)refreKPListUIWithData:(NSMutableArray *)data
{
    self.data = data;
    
    _fnt = [UIFont systemFontOfSize:12];
    NSArray *titleArr = @[@"发票类型",@"发票号码",@"发票代码",@"含税金额(元)",@"税率(%)",@"不含税金额(元)",@"税额(元)"];
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
        self.name.text = [self.data[j] idType];
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
        self.name.text = [self.data[j] idNumber];
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
        self.name.text = [self.data[j] idCode];
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
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] idIncludeprice]];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }

    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *4, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] idRate]];
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
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] idExincludeprice]];
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
        self.name.text = [NSString stringWithFormat:@"%@",[self.data[j] idTax]];
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
