//
//  XMProjectCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "XMProjectCell.h"

@interface XMProjectCell ()
@property (weak, nonatomic) IBOutlet UILabel *hpDevelopmentorganization;
@property (weak, nonatomic) IBOutlet UILabel *hpProjectname;
@property (weak, nonatomic) IBOutlet UILabel *hpProjectcost;
@property (weak, nonatomic) IBOutlet UILabel *hpProjectoutline;

@end

@implementation XMProjectCell


- (void)referUIWithModel:(xmProjectModel *)model
{
    self.hpDevelopmentorganization.text = model.hpDevelopmentorganization;
    self.hpProjectname.text = model.hpProjectname;
    self.hpProjectcost.text = model.hpProjectcost;
    self.hpProjectoutline.text = model.hpProjectoutline;
}

@end
