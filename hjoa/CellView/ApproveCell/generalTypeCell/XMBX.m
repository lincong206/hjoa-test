//
//  XMBX.m
//  hjoa
//
//  Created by 华剑 on 2017/6/28.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "XMBX.h"

@interface XMBX ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *usedLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end

@implementation XMBX

- (void)referUIWithModel:(BXMX *)model
{
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",model.pcFmoney];
    self.usedLabel.text = model.pcFcapitaluses;
    self.noteLabel.text = model.pcFnote;
}

- (void)referJKBXUIWithModel:(BXMX *)model
{
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",model.pbedMoney];
    self.usedLabel.text = model.pbedUse;
    self.noteLabel.text = model.pbedRemark;
}

@end
