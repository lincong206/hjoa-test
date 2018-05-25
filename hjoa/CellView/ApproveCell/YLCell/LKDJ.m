//
//  LKDJ.m
//  hjoa
//
//  Created by 华剑 on 2017/8/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "LKDJ.h"
#import "Header.h"

@interface LKDJ ()

{
    CGSize _size;
    UIFont *_fnt;
    CGFloat _noteHeight;
    CGFloat _nameHeight;
    NSString *_note;
    NSInteger _shang;
}

@property (strong, nonatomic) UILabel *noteLabel;
@property (assign, nonatomic) NSInteger i;
@property (strong, nonatomic) NSMutableArray *titleArrM;
@property (strong, nonatomic) NSMutableArray *dataArr;      // 数据
@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation LKDJ

- (NSMutableArray *)titleArrM
{
    if (!_titleArrM) {
        _titleArrM = [NSMutableArray array];
    }
    return _titleArrM;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

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

// 设置标题
- (void)referLKDJUIWithModel:(LKDJModel *)model
{
    _i = 0;
    [self.titleArrM removeAllObjects];
    [self.dataArr removeAllObjects];
    if (model.prBusinessratio.integerValue == 0 && model.prBusinessmoney.integerValue == 0 && model.prBusinesstotalmoney.integerValue == 0 && [model.prBusinessremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prBusinessratio]];
        [data addObject:[NSString stringWithFormat:@"%.2f",model.prBusinessmoney.floatValue]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prBusinesstotalmoney]];
        [data addObject:model.prBusinessremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"业务费"];
        _i += 1;
    }
    
    if (model.prPremium.integerValue == 0 && model.prPremiumtotal.integerValue == 0 && [model.prPremiumremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prPremium]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prPremiumtotal]];
        [data addObject:model.prPremiumremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"保险费"];
        _i += 1;
    }
    
    if (model.prSealmoney.integerValue == 0 && model.prSealtotalmoney.integerValue == 0 && [model.prSealremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prSealmoney]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prSealtotalmoney]];
        [data addObject:model.prSealremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"刻章费"];
        _i += 1;
    }
    
    if (model.prDeductpledge.integerValue == 0 && model.prDeductpledgetotal.integerValue == 0 && [model.prDeductpledgeremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductpledge]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductpledgetotal]];
        [data addObject:model.prDeductpledgeremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"扣项目章押金"];
        _i += 1;
    }
    
    if (model.prDeductoverall.integerValue == 0 && model.prDeductoveralltotal.integerValue == 0 && [model.prDeductoverallremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductoverall]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductoveralltotal]];
        [data addObject:model.prDeductoverallremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"扣工衣"];
        _i += 1;
    }
    
    if (model.prExpressmoney.integerValue == 0 && model.prExpresstotalmoney.integerValue == 0 && [model.prExpressremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prExpressmoney]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prExpresstotalmoney]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prExpressremark]];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"快递费"];
        _i += 1;
    }
    
    if (model.prTaxesratio.integerValue == 0 && model.prTaxesmoney.integerValue == 0 && model.prTaxestotalmoney.integerValue == 0 && [model.prTaxesremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prTaxesratio]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prTaxesmoney]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prTaxestotalmoney]];
        [data addObject:model.prTaxesremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"税金"];
        _i += 1;
    }
    
    if (model.prPrintingtaxes.integerValue == 0 && model.prPrintingtaxestotal.integerValue == 0 && [model.prPrintingtaxesremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prPrintingtaxes]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prPrintingtaxestotal]];
        [data addObject:model.prPrintingtaxesremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"印花税金"];
        _i += 1;
    }
    
    if (model.prReturnmoney.integerValue == 0 && model.prReturnmoneytotal.integerValue == 0 && [model.prReturnmoneyremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prReturnmoney]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prReturnmoneytotal]];
        [data addObject:model.prReturnmoneyremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"回款滞后费"];
        _i += 1;
    }
    
    if (model.prOuttrackdeposit.integerValue == 0 && model.prOuttrackdeposittotal.integerValue == 0 && [model.prOuttrackremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prOuttrackdeposit]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prOuttrackdeposittotal]];
        [data addObject:model.prOuttrackremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"外经证押金"];
        _i += 1;
    }
    
    if (model.prRent.integerValue == 0 && model.prRenttotal.integerValue == 0 && [model.prRentremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prRent]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prRenttotal]];
        [data addObject:model.prRentremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"租金"];
        _i += 1;
    }
    
    if (model.prLaon.integerValue == 0 && model.prLaontotal.integerValue == 0 && [model.prLaonremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prLaon]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prLaontotal]];
        [data addObject:model.prLaonremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"借款"];
        _i += 1;
    }
    
    if (model.prMoneyoccupy.integerValue == 0 && model.prMoneyoccupytotal.integerValue == 0 && [model.prMoneyoccupyremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prMoneyoccupy]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prMoneyoccupytotal]];
        [data addObject:model.prMoneyoccupyremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"资金占用费"];
        _i += 1;
    }
    
    if (model.prBidmoney.integerValue == 0 && model.prBidtotalmoney.integerValue == 0 && [model.prBidremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prBidmoney]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prBidtotalmoney]];
        [data addObject:model.prBidremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"标书费"];
        _i += 1;
    }
    
    if (model.prOthercost.integerValue == 0 && model.prOthertotalcost.integerValue == 0 && [model.prOthercostremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prOthercost]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prOthertotalcost]];
        [data addObject:model.prOthercostremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"其他费用"];
        _i += 1;
    }
    
    if (model.prDeductssaf.integerValue == 0 && model.prDeducttotalssaf.integerValue == 0 && [model.prDeductssafremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductssaf]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeducttotalssaf]];
        [data addObject:model.prDeductssafremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"扣社保公积金"];
        _i += 1;
    }
    
    if (model.prExittaxes.integerValue == 0 && model.prExittaxestotal.integerValue == 0 && [model.prExittaxesremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prExittaxes]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prExittaxestotal]];
        [data addObject:model.prExittaxesremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"退税金"];
        _i += 1;
    }
    
    if (model.prDeductlgmargin.integerValue == 0 && model.prDeductlgmargintotal.integerValue == 0 && [model.prDeductlgmarginremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductlgmargin]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductlgmargintotal]];
        [data addObject:model.prDeductlgmarginremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"扣保函保证金"];
        _i += 1;
    }
    
    if (model.prLgpoundage.integerValue == 0 && model.prLgpoundagetotal.integerValue == 0 && [model.prLgpoundagetremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prLgpoundage]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prLgpoundagetotal]];
        [data addObject:model.prLgpoundagetremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"保函手续费"];
        _i += 1;
    }
    
    if (model.prDeductoverspend.integerValue == 0 && model.prDeductoverspendtotal.integerValue == 0 && [model.prDeductoverspendremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductoverspend]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prDeductoverspendtotal]];
        [data addObject:model.prDeductoverspendremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"扣年度超支费"];
        _i += 1;
    }
    
    if (model.prSalary.integerValue == 0 && model.prSalarytotal.integerValue == 0 && [model.prSalaryremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prSalary]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prSalarytotal]];
        [data addObject:model.prSalaryremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"工资及费用"];
        _i += 1;
    }
    
    if (model.prBidmargin.integerValue == 0 && model.prBidmargintotal.integerValue == 0 && [model.prBidmarginremark isEqualToString:@""]) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.prBidmargin]];
        [data addObject:[NSString stringWithFormat:@"%@",model.prBidmargintotal]];
        [data addObject:model.prBidmarginremark];
        [self.dataArr addObject:data];
        
        [self.titleArrM addObject:@"代付投标保证金"];
        _i += 1;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _fnt = [UIFont systemFontOfSize:12];
    _nameHeight = 0.0;
    _noteHeight = 0.0;
    // 标题
    for (int i = 0 ; i < self.titleArr.count; i ++) {
        _size = [self.titleArr[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.alpha = 0.5;
        _titleLabel.frame = CGRectMake(5 + (90 * i), 10, 70 + 10, 20);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = _fnt;
        _titleLabel.text = self.titleArr[i];
        [self.scroll addSubview:_titleLabel];
    }
    
    // 列数据
    for (int i = 0; i < self.titleArrM.count; i ++) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = [NSString stringWithFormat:@"%@",self.titleArrM[i]];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = _fnt;
        [self.scroll addSubview:_titleLabel];
        // 行数据
        NSArray *data = self.dataArr[i];
        for (int j = 0; j < data.count; j ++) {
            _noteLabel = [[UILabel alloc] init];
            _noteLabel.backgroundColor = [UIColor clearColor];
            _noteLabel.textAlignment = NSTextAlignmentCenter;
            _noteLabel.text = [NSString stringWithFormat:@"%@",data[j]];
            _noteLabel.numberOfLines = 0;
            _noteLabel.font = _fnt;
            
            _note = [NSString stringWithFormat:@"%@",data[data.count-1]];
            _size = [_note sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
            
            if (_size.width > 70) {
                _shang = _size.width/67;
                _noteHeight = (_shang+1)*_size.height;
            }else {
                _noteHeight = _size.height;
            }
            
            if (data.count == 4) {
                _noteLabel.frame = CGRectMake(95 + (90 * j), 30 + 5 + _nameHeight, 70 + 10, _noteHeight);
            }else {
                _noteLabel.frame = CGRectMake(90*2 + 5 + (90 * j), 30 + 5 +_nameHeight, 70 + 10, _noteHeight);
            }
            [self.scroll addSubview:_noteLabel];
            
            if (self.noteLabel.text == nil || [self.noteLabel.text isEqualToString:@"(null)"] || [self.noteLabel.text isEqual:[NSNull alloc]]) {
                self.noteLabel.textColor = [UIColor grayColor];
                self.noteLabel.text = @"--";
            }
        }
        _titleLabel.frame = CGRectMake(5 , 30 + 5 + _nameHeight, 70 + 10, _noteHeight);
        _nameHeight += _noteHeight + 5;
        
        if (i == 0) {
            _titleLabel.frame = CGRectMake(5 , 30 + 5, 70 + 10, _noteHeight);
        }
        
        if (i == self.titleArrM.count - 1) {
            [self.passDelegate passLKCellHeight:30 + 5 + _nameHeight + 10];
        }
    }
    self.scroll.frame = CGRectMake(0, 0, kscreenWidth, 30 + 5 + _nameHeight + 10);
    self.scroll.contentSize = CGSizeMake(self.titleArr.count * 80 + self.titleArr.count * 10, 30 + 5 + _nameHeight + 10);
    [self.contentView addSubview:self.scroll];
}

@end
