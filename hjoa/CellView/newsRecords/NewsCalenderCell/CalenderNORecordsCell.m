//
//  CalenderNORecordsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CalenderNORecordsCell.h"
@interface CalenderNORecordsCell ()

@property (strong, nonatomic) UIImageView *back;
@property (strong, nonatomic) UILabel *label;

@end

@implementation CalenderNORecordsCell

- (UIImageView *)back
{
    if (!_back) {
        _back = [[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.bounds.size.width-108)/2, 30, 108, 108)];
        _back.backgroundColor = [UIColor clearColor];
        _back.image = [UIImage imageNamed:@"tea"];
    }
    return _back;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.bounds.size.width-300)/2, 150, 300, 20)];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"当天没有打卡记录";
        _label.tintColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView addSubview:self.back];
    [self.contentView addSubview:self.label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
