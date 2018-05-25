//
//  BFHQDForCostCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "BFHQDForCostCell.h"
#import "Header.h"

@interface BFHQDForCostCell ()

@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UILabel *noteLabel;
@property (assign, nonatomic) NSInteger i;
@property (strong, nonatomic) NSMutableArray *titleArr;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (assign, nonatomic) CGFloat height;

@end

@implementation BFHQDForCostCell

- (NSMutableArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)referCostUIWithModel:(BFHQDModel *)model
{
    _i = 0;
    [self.titleArr removeAllObjects];
    [self.dataArr removeAllObjects];
    
    _font = [UIFont systemFontOfSize:14];
    
    if (model.arBusinesstotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arBusinesstotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"业务费"];
    }
    if (model.arPremiumtotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arPremiumtotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"保险费"];
    }
    if (model.arSealtotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arSealtotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"刻章费"];
    }
    if (model.arDeductpledgetotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arDeductpledgetotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"扣项目章押金"];
    }
    if (model.arDeductoverall.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arDeductoverall]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"扣工衣"];
    }
    if (model.arExpresstotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arExpresstotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"快递费"];
    }
    if (model.arTaxestotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arTaxestotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"税金"];
    }
    if (model.arPrintingtaxes.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arPrintingtaxes]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"印花税金"];
    }
    if (model.arReturnmoney.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arReturnmoney]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"回款滞后费"];
    }
    if (model.arOuttracktotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arOuttracktotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"外经证押金"];
    }
    if (model.arRenttotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arRenttotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"租金"];
    }
    if (model.arLaontotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arLaontotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"借款"];
    }
    if (model.arMoneyoccupy.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arMoneyoccupy]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"资金占用费"];
    }
    if (model.arBidtotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arBidtotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"标书费"];
    }
    if (model.arOthercost.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arOthercost]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"其他费用"];
    }
    if (model.arDeductssaf.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arDeductssaf]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"扣社保公积金"];
    }
    if (model.arExittaxestotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arExittaxestotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"退税金"];
    }
    if (model.arDeductlgmargin.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arDeductlgmargin]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"扣保函保证金"];
    }
    if (model.arLgpoundagetotal.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arLgpoundagetotal]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"保函手续费"];
    }
    if (model.arDeductoverspend.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arDeductoverspend]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"扣年度超支费"];
    }
    if (model.arSalary.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arSalary]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"工资及费用"];
    }
    if (model.arBidmargin.integerValue == 0) {
        
    }else {
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:[NSString stringWithFormat:@"%@",model.arBidmargin]];
        [self.dataArr addObject:data];
        
        _i += 1;
        [self.titleArr addObject:@"代付投标保证金"];
    }
    
    if (self.titleArr.count) {
        for (int j = 0; j < self.titleArr.count; j ++) {
            _size = [self.titleArr[j] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_font,NSFontAttributeName, nil]];
            self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + (30 * j) + (10 * j), (kscreenWidth - 30)/2, 30)];
            self.noteLabel.backgroundColor = [UIColor whiteColor];
            self.noteLabel.textAlignment = NSTextAlignmentCenter;
            self.noteLabel.font = _font;
            self.noteLabel.text = self.titleArr[j];
            [self.contentView addSubview:self.noteLabel];
            
            if (j == self.titleArr.count - 1) {
                _height = (CGFloat)(10 + _titleArr.count*(30) + _titleArr.count*(10));
                [self.passheightDelegate passCostCellHeight:_height];
            }
        }
    }else {
        [self.passheightDelegate passCostCellHeight:0];
    }
    
    // 填充内容
    for (int i = 0; i < self.dataArr.count; i ++) {
        NSMutableArray * arr = self.dataArr[i];
        for (int j = 0; j < arr.count; j ++) {
            self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + ((kscreenWidth - 30)/2 * (j+1)) + (10 * (j+1)), 10 + (30*i) + (10*i),  (kscreenWidth - 30)/2, 30)];
            self.noteLabel.backgroundColor = [UIColor whiteColor];
            self.noteLabel.textAlignment = NSTextAlignmentCenter;
            self.noteLabel.text = arr[j];
            self.noteLabel.font = _font;
            [self.contentView addSubview:self.noteLabel];
        }
    }
    if (self.noteLabel.text == nil || [self.noteLabel.text isEqualToString:@"(null)"] || [self.noteLabel.text isEqual:[NSNull alloc]]) {
        self.noteLabel.text = @"";
    }
}

@end
