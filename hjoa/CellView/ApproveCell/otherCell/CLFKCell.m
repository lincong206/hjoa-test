//
//  CLFKCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CLFKCell.h"

@interface CLFKCell ()

{
    UIFont *_fnt;
}

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *brand;   //  品牌
@property (strong, nonatomic) UILabel *model;   //  型号
@property (strong, nonatomic) UILabel *specification;   // 规格
@property (strong, nonatomic) UILabel *unit;    //  单位
@property (strong, nonatomic) UILabel *num;     //  个数
@property (strong, nonatomic) UILabel *price;   //  价格
@property (strong, nonatomic) UILabel *money;   //  总价
@property (strong, nonatomic) UILabel *remark;  //  备注

@end

@implementation CLFKCell

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

- (void)refreCLFKUIWithData:(NSMutableArray *)data
{
    self.data = data;
    
    _fnt = [UIFont systemFontOfSize:12];
    NSArray *titleArr = @[@"材料名称",@"品牌",@"型号",@"规格",@"单位",@"数量",@"单价(元)",@"合同金额(元)",@"备注"];
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
    
    //
    for (int j = 0; j < self.data.count; j ++) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *0, 35 + (25 * j), 100, 20)];
        self.name.backgroundColor = [UIColor whiteColor];
        self.name.text = [self loadNameLabelWithColumn:j];
        self.name.font = _fnt;
        self.name.textAlignment = NSTextAlignmentCenter;
        if (self.name.text == nil || [self.name.text isEqualToString:@"(null)"] || [self.name.text isEqual:[NSNull alloc]] || [self.name.text isEqualToString:@""] || [self.name.text isEqualToString:@" "] || [self.name.text isEqualToString:@"<null>"]) {
            self.name.text = @"--";
        }
        [self.scroll addSubview:self.name];
    }
    
    // 品牌
    for (int j = 0; j < self.data.count; j ++) {
        self.brand = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *1, 35 + (25 * j), 100, 20)];
        self.brand.backgroundColor = [UIColor whiteColor];
        self.brand.text = [self loadBrandLabelWithColumn:j];
        self.brand.font = _fnt;
        self.brand.textAlignment = NSTextAlignmentCenter;
        if (self.brand.text == nil || [self.brand.text isEqualToString:@"(null)"] || [self.brand.text isEqual:[NSNull alloc]] || [self.brand.text isEqualToString:@""] || [self.brand.text isEqualToString:@" "] || [self.brand.text isEqualToString:@"<null>"]) {
            self.brand.text = @"--";
        }
        [self.scroll addSubview:self.brand];
    }
    
    // 型号
    for (int j = 0; j < self.data.count; j ++) {
        self.model = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *2, 35 + (25 * j), 100, 20)];
        self.model.backgroundColor = [UIColor whiteColor];
        self.model.text = [self loadModelLabelWithColumn:j];
        self.model.font = _fnt;
        self.model.textAlignment = NSTextAlignmentCenter;
        if (self.model.text == nil || [self.model.text isEqualToString:@"(null)"] || [self.model.text isEqual:[NSNull alloc]] || [self.model.text isEqualToString:@""] || [self.model.text isEqualToString:@" "] || [self.model.text isEqualToString:@"<null>"]) {
            self.model.text = @"--";
        }
        [self.scroll addSubview:self.model];
    }
    
    // 规格
    for (int j = 0; j < self.data.count; j ++) {
        self.specification = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *3, 35 + (25 * j), 100, 20)];
        self.specification.backgroundColor = [UIColor whiteColor];
        self.specification.text = [self loadSpecificationLabelWithColumn:j];
        self.specification.font = _fnt;
        self.specification.textAlignment = NSTextAlignmentCenter;
        if (self.specification.text == nil || [self.specification.text isEqualToString:@"(null)"] || [self.specification.text isEqual:[NSNull alloc]] || [self.specification.text isEqualToString:@""] || [self.specification.text isEqualToString:@" "] || [self.specification.text isEqualToString:@"<null>"]) {
            self.specification.text = @"--";
        }
        [self.scroll addSubview:self.specification];
    }
    
    // 单位
    for (int j = 0; j < self.data.count; j ++) {
        self.unit = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *4, 35 + (25 * j), 100, 20)];
        self.unit.backgroundColor = [UIColor whiteColor];
        self.unit.text = [self loadUnitLabelWithColumn:j];
        self.unit.font = _fnt;
        self.unit.textAlignment = NSTextAlignmentCenter;
        if (self.unit.text == nil || [self.unit.text isEqualToString:@"(null)"] || [self.unit.text isEqual:[NSNull alloc]] || [self.unit.text isEqualToString:@""] || [self.unit.text isEqualToString:@" "] || [self.unit.text isEqualToString:@"<null>"]) {
            self.unit.text = @"--";
        }
        [self.scroll addSubview:self.unit];
    }
    
    // 个数
    for (int j = 0; j < self.data.count; j ++) {
        self.num = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *5, 35 + (25 * j), 100, 20)];
        self.num.backgroundColor = [UIColor whiteColor];
        self.num.text = [self loadNumLabelWithColumn:j];
        self.num.font = _fnt;
        self.num.textAlignment = NSTextAlignmentCenter;
        if (self.num.text == nil || [self.num.text isEqualToString:@"(null)"] || [self.num.text isEqual:[NSNull alloc]] || [self.num.text isEqualToString:@""] || [self.num.text isEqualToString:@" "] || [self.num.text isEqualToString:@"<null>"]) {
            self.num.text = @"--";
        }
        [self.scroll addSubview:self.num];
    }
    
    // 价格
    for (int j = 0; j < self.data.count; j ++) {
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *6, 35 + (25 * j), 100, 20)];
        self.price.backgroundColor = [UIColor whiteColor];
        self.price.text = [self loadPriceLabelWithColumn:j];
        self.price.font = _fnt;
        self.price.textAlignment = NSTextAlignmentCenter;
        if (self.price.text == nil || [self.price.text isEqualToString:@"(null)"] || [self.price.text isEqual:[NSNull alloc]] || [self.price.text isEqualToString:@""] || [self.price.text isEqualToString:@" "] || [self.price.text isEqualToString:@"<null>"]) {
            self.price.text = @"--";
        }
        [self.scroll addSubview:self.price];
    }
    
    // 总价
    for (int j = 0; j < self.data.count; j ++) {
        self.money = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *7, 35 + (25 * j), 100, 20)];
        self.money.backgroundColor = [UIColor whiteColor];
        self.money.text = [self loadMoneyLabelWithColumn:j];
        self.money.font = _fnt;
        self.money.textAlignment = NSTextAlignmentCenter;
        if (self.money.text == nil || [self.money.text isEqualToString:@"(null)"] || [self.money.text isEqual:[NSNull alloc]] || [self.money.text isEqualToString:@""] || [self.money.text isEqualToString:@" "] || [self.money.text isEqualToString:@"<null>"]) {
            self.money.text = @"--";
        }
        [self.scroll addSubview:self.money];
    }
    
    // 备注
    for (int j = 0; j < self.data.count; j ++) {
        self.remark = [[UILabel alloc] initWithFrame:CGRectMake(10 + (100 + 10) *8, 35 + (25 * j), 100, 20)];
        self.remark.backgroundColor = [UIColor whiteColor];
        self.remark.text = [self loadRemarkLabelWithColumn:j];
        self.remark.font = _fnt;
        self.remark.textAlignment = NSTextAlignmentCenter;
        if (self.remark.text == nil || [self.remark.text isEqualToString:@"(null)"] || [self.remark.text isEqual:[NSNull alloc]] || [self.remark.text isEqualToString:@""] || [self.remark.text isEqualToString:@" "] || [self.remark.text isEqualToString:@"<null>"]) {
            self.remark.text = @"--";
        }
        [self.scroll addSubview:self.remark];
    }
    
    [self.contentView addSubview:self.scroll];
}

- (NSString *)loadNameLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return model.mcdName;
}

- (NSString *)loadBrandLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return model.mcdBrand;
}

- (NSString *)loadModelLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return model.mcdModel;
}

- (NSString *)loadSpecificationLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return model.mcdSpecification;
}

- (NSString *)loadUnitLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return model.mcdUnit;
}

- (NSString *)loadNumLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return [NSString stringWithFormat:@"%@",model.mcdNum];
}

- (NSString *)loadPriceLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return [NSString stringWithFormat:@"%@",model.mcdPrice];
}

- (NSString *)loadMoneyLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return [NSString stringWithFormat:@"%@",model.mcdMoney];
}

- (NSString *)loadRemarkLabelWithColumn:(int)j
{
    CLFKModel *model = self.data[j];
    return model.mcdRemark;
}

@end
