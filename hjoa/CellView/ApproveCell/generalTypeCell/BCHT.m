//
//  BCHT.m
//  hjoa
//
//  Created by 华剑 on 2017/8/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "BCHT.h"
#import "Header.h"

@interface BCHT ()

{
    CGSize _size;
    UIFont *_fnt;
    CGFloat _noteHeight;
    CGFloat _nameHeight;
}

@property (strong, nonatomic) UIScrollView *scroll;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *noteLabel;

@end

@implementation BCHT

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

- (void)refreBCHTUIWithModel:(BCHTModel *)model
{
    _fnt = [UIFont systemFontOfSize:12];
    for (int i = 0; i < self.titleArr.count; i ++) {
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + (100+5)*i, 5, 100, 20)];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = self.titleArr[i];
        self.titleLabel.font = _fnt;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.scroll addSubview:self.titleLabel];
    }
        
        // 内容
        for (int j = 0; j < model.bsProjectContractPays.count; j ++) {
            self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + (100 + 5)*0, 5 + (20+5)*(j+1), 100, 20)];
            self.noteLabel.backgroundColor = [UIColor whiteColor];
            self.noteLabel.textAlignment = NSTextAlignmentCenter;
            self.noteLabel.font = _fnt;
            self.noteLabel.text = model.bsProjectContractPays.firstObject[@"pcpPaydate"];
            [self.scroll addSubview:self.noteLabel];
        }
        
        for (int j = 0; j < model.bsProjectContractPays.count; j ++) {
            self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + (100 + 5)*1, 5 + (20+5)*(j+1), 100, 20)];
            self.noteLabel.backgroundColor = [UIColor whiteColor];
            self.noteLabel.textAlignment = NSTextAlignmentCenter;
            self.noteLabel.font = _fnt;
            self.noteLabel.text = [NSString stringWithFormat:@"%@",model.bsProjectContractPays.firstObject[@"pcpPayfee"]];
            [self.scroll addSubview:self.noteLabel];
        }
        
        for (int j = 0; j < model.bsProjectContractPays.count; j ++) {
            self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + (100 + 5)*2, 5 + (20+5)*(j+1), 100, 20)];
            self.noteLabel.backgroundColor = [UIColor whiteColor];
            self.noteLabel.textAlignment = NSTextAlignmentCenter;
            self.noteLabel.font = _fnt;
            self.noteLabel.text = model.bsProjectContractPays.firstObject[@"pcpPaycondition"];
            [self.scroll addSubview:self.noteLabel];
        }
        
        for (int j = 0; j < model.bsProjectContractPays.count; j ++) {
            self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + (100 + 5)*3, 5 + (20+5)*(j+1), 100, 20)];
            self.noteLabel.backgroundColor = [UIColor whiteColor];
            self.noteLabel.textAlignment = NSTextAlignmentCenter;
            self.noteLabel.font = _fnt;
            self.noteLabel.text = model.bsProjectContractPays.firstObject[@"pcpNote"];
            [self.scroll addSubview:self.noteLabel];
        }
    [self.contentView addSubview:self.scroll];
    self.scroll.frame = CGRectMake(0, 0, kscreenWidth, (model.bsProjectContractPays.count + 1)*25 + 5);
    self.scroll.contentSize = CGSizeMake(5 + (100+5)*self.titleArr.count + 5, (model.bsProjectContractPays.count + 1)*25 + 5);
    [self.passHeightDelegate passHeightFromBCHT:(model.bsProjectContractPays.count + 1)*25 + 5];
}



@end
