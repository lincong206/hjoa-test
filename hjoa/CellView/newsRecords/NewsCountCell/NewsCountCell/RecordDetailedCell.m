//
//  RecordDetailedCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RecordDetailedCell.h"

@interface RecordDetailedCell ()

@property (weak, nonatomic) IBOutlet UILabel *pjtName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *day;

@end

@implementation RecordDetailedCell

- (void)loadDataWithModel:(ZHTEModel *)model
{
    if ([self.name isEqualToString:@"完工进度"]) {
        self.pjtName.text = model.bsSchedule[@"piIdnum"];
        self.address.text = model.bsSchedule[@"paProjectleader"];
        self.money.text = [NSString stringWithFormat:@"%@%@",model.scAccumulated,@"%"];
        self.day.text = [model.scVerifytime componentsSeparatedByString:@" "].firstObject;
    }else if ([self.name isEqualToString:@"总合同额"]) {
        self.pjtName.text = model.contractName;
        self.pjtName.lineBreakMode = NSLineBreakByTruncatingMiddle;
        self.address.text = model.projectAddress;
        self.money.text = [NSString stringWithFormat:@"%.2f万",model.contractPrice.floatValue/10000];
        self.day.text = model.contractDate;
    }else if ([self.name isEqualToString:@"收款进度"]) {
        self.pjtName.text = model.piBuildcompany;
        self.address.text = model.uiManagername;
        if (model.sprCurrentpaymoney.floatValue > 10000) {
            self.money.text = [NSString stringWithFormat:@"%.2f万",model.sprCurrentpaymoney.floatValue/10000];
        }else {
            self.money.text = [NSString stringWithFormat:@"%@元",model.sprCurrentpaymoney];
        }
        self.day.text = [model.sprCurrentpaydate componentsSeparatedByString:@" "].firstObject;
    }else if ([self.name isEqualToString:@"开票"]) {
        self.pjtName.text = model.oiInvoicetitle;
        self.address.text = @"开票";
        if (model.oiTaxinclusive.floatValue > 10000) {
            self.money.text = [NSString stringWithFormat:@"%.2f万",model.oiTaxinclusive.floatValue/10000];
        }else {
            self.money.text = [NSString stringWithFormat:@"%@元",model.oiTaxinclusive];
        }
        self.day.text = model.oiCreatetime;
    }else if ([self.name isEqualToString:@"支出合同"]) {
        self.pjtName.text = model.type;
        self.address.text = @"类型";
        self.day.text = [NSString stringWithFormat:@"%@",model.contractNum];
        if (model.priceTotal.floatValue > 10000) {
            self.money.text = [NSString stringWithFormat:@"%.2f万",model.priceTotal.floatValue/10000];
        }else {
            self.money.text = [NSString stringWithFormat:@"%@元",model.priceTotal];
        }
    }else if ([self.name isEqualToString:@"付款"]) {
        self.pjtName.text = @"";
        self.address.text = @"";
        self.money.text = @"";
        self.day.text = @"";
    }else if ([self.name isEqualToString:@"收票"]) {
        self.pjtName.text = @"";
        self.address.text = @"";
        self.money.text = @"";
        self.day.text = @"";
    }
    
}

@end
