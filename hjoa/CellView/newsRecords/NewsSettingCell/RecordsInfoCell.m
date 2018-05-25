//
//  RecordsInfoCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RecordsInfoCell.h"

@interface RecordsInfoCell ()
{
    NSMutableArray *_week;
}
@property (weak, nonatomic) IBOutlet UILabel *recordList;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *recordPoint;

@end

@implementation RecordsInfoCell

- (void)refreshRecordPointData:(NewsRecordSettingModel *)model
{
    self.recordList.text = [NSString stringWithFormat:@"考勤组:%@",model.sciPiname];
    self.recordPoint.text = [NSString stringWithFormat:@"考勤点:%@",model.sciAddress];
    self.time.text = [NSString stringWithFormat:@"固定班制:%@",[self CheckOnWorkTimeWithModel:model]];//固定班制:
}
//重组考勤时间
- (NSString *)CheckOnWorkTimeWithModel:(NewsRecordSettingModel *)model;
{
    _week = [NSMutableArray array];
    NSArray *day = [model.sciWorkday componentsSeparatedByString:@","];
    for (NSString *week in day) {
        if (week.integerValue == 1) {
            [_week addObject:@"天"];
        }else if (week.integerValue == 2) {
            [_week addObject:@"一"];
        }else if (week.integerValue == 3) {
            [_week addObject:@"二"];
        }else if (week.integerValue == 4) {
            [_week addObject:@"三"];
        }else if (week.integerValue == 5) {
            [_week addObject:@"四"];
        }else if (week.integerValue == 6) {
            [_week addObject:@"五"];
        }else if (week.integerValue == 7) {
            [_week addObject:@"六"];
        }
    }
    NSString *week = [NSString stringWithFormat:@"周%@  %@",[_week componentsJoinedByString:@"、"],[NSString stringWithFormat:@"%@:%@-%@:%@",model.sciWorkhour,model.sciWorkminute,model.sciOffhour,model.sciOffminute]];
    return week;
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
