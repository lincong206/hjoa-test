//
//  NotActiveCell.m
//  hjoa
//
//  Created by 华剑 on 2018/1/24.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "NotActiveCell.h"

@interface NotActiveCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *data;

@end

@implementation NotActiveCell

- (void)refreshDataFromApplyModel:(ApplyModel *)model
{
    self.name.text = model.name;
    self.data.text = model.icon;
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
