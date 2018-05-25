//
//  ZKCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/14.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "ZKCell.h"

@interface ZKCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *dept;
@property (weak, nonatomic) IBOutlet UILabel *job;
@property (weak, nonatomic) IBOutlet UILabel *englishName;
@property (weak, nonatomic) IBOutlet UILabel *jurisdiction;


@end

@implementation ZKCell

- (void)refreZKUIWithModel:(ZKModel *)model
{
    self.name.text = model.dicpName;
    self.sex.text = model.dicpSex;
    self.dept.text = model.dicpDept;
    self.job.text = model.dicpJob;
    self.englishName.text = model.dicpEnglishname;
    self.jurisdiction.text = model.dicpJurisdiction;
}

@end
