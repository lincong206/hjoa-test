//
//  QualityCheckCell.m
//  hjoa
//
//  Created by 华剑 on 2018/2/27.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QualityCheckCell.h"

@interface QualityCheckCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation QualityCheckCell

- (void)refreshQualityCheckCellWithModel:(ApplyModel *)model
{
    self.backImage.image = [UIImage imageNamed:model.backImage];
    self.icon.image = [UIImage imageNamed:model.icon];
    self.title.text = model.name;
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
