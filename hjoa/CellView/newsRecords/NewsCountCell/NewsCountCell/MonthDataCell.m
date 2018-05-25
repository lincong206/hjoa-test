//
//  MonthDataCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "MonthDataCell.h"

@interface MonthDataCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *number;

@end

@implementation MonthDataCell

- (void)refreshDataFromMothCellWith:(QueryNameModel *)model
{
    self.name.text = model.groupName;
    self.number.text = [NSString stringWithFormat:@"%ld人",(unsigned long)model.groupData.count];
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
