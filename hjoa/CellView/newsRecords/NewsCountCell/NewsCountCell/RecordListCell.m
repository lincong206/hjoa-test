//
//  RecordListCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RecordListCell.h"

@interface RecordListCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation RecordListCell

- (void)refreshCellWithModel:(ListVCModel *)model
{
    if ([self.type isEqualToString:@"材料合同支出"]) {
        self.title.text = model.mctName;
        self.name.text = model.uiName;
        self.money.text = model.mctContractmoney;
        if (model.astStatus.integerValue == 0) {
            self.status.text = @"待审批";
        }else if (model.astStatus.integerValue == 1) {
            self.status.text = @"通过";
        }else {
            self.status.text = @"不通过";
        }
    }else if ([self.type isEqualToString:@"劳务合同支出"]) {
        self.title.text = model.rlcTreatycontent;
        self.name.text = model.uiName;
        self.money.text = model.rlcManpower;
        if (model.astStatus.integerValue == 0) {
            self.status.text = @"待审批";
        }else if (model.astStatus.integerValue == 1) {
            self.status.text = @"通过";
        }else {
            self.status.text = @"不通过";
        }
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
