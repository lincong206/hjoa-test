//
//  RecordStateCell.m
//  hjoa
//
//  Created by 华剑 on 2017/9/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RecordStateCell.h"
#import "Header.h"

@interface RecordStateCell ()

@property (strong, nonatomic) UILabel *content;

@property (strong, nonatomic) UILabel *dayLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation RecordStateCell

- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
        _content.font = [UIFont systemFontOfSize:15];
        _content.backgroundColor = [UIColor clearColor];
    }
    return _content;
}

- (UILabel *)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.contentView.bounds.size.width - 20, 20)];
        _dayLabel.font = [UIFont systemFontOfSize:15];
        _dayLabel.backgroundColor = [UIColor clearColor];
    }
    return _dayLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, self.contentView.bounds.size.width - 20, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    return _timeLabel;
}

- (UIButton *)monthRecords
{
    if (!_monthRecords) {
        _monthRecords = [UIButton buttonWithType:UIButtonTypeCustom];
        _monthRecords.frame = CGRectMake(kscreenWidth - 80, 12, 60, 30);
        _monthRecords.backgroundColor = [UIColor clearColor];
        _monthRecords.titleLabel.font = [UIFont systemFontOfSize:12];
        [_monthRecords setTitle:@"打卡月历" forState:UIControlStateNormal];
        [_monthRecords setTitleColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return _monthRecords;
}

- (void)setModel:(QueryNameModel *)model IndexPath:(NSIndexPath *)indexPath
{
    self.content.text = @"";
    self.dayLabel.text = @"";
    self.timeLabel.text = @"";
    if (model.groupData.count == 0) {
        
    }else {
        if ([model.groupData[indexPath.row] isKindOfClass:[NSString class]]) {
            if ([model.groupName isEqualToString:@"外勤"]) {
                self.dayLabel.text = [model.groupData[indexPath.row] componentsSeparatedByString:@","].firstObject;
                self.timeLabel.text = [model.groupData[indexPath.row] componentsSeparatedByString:@","].lastObject;
                [self.contentView addSubview:self.dayLabel];
                [self.contentView addSubview:self.timeLabel];
            }else {
                self.content.text = [NSString stringWithFormat:@"%@",model.groupData[indexPath.row]];
                [self.contentView addSubview:self.content];
            }
        }else if ([model.groupData[indexPath.row] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = model.groupData[indexPath.row];
            self.dayLabel.text = dic[@"day"];
            if ([model.groupName isEqualToString:@"迟到"]) {
                self.timeLabel.text = [NSString stringWithFormat:@"上班迟到:%@",[self changeTimeStamp:dic[@"ztTime"]]];
            }else if ([model.groupName isEqualToString:@"早退"]) {
                self.timeLabel.text = [NSString stringWithFormat:@"下班早退:%@",[self changeTimeStamp:dic[@"ztTime"]]];
            }else {
                self.timeLabel.text = [self changeTimeStamp:dic[@"ztTime"]];
            }
            [self.contentView addSubview:self.dayLabel];
            [self.contentView addSubview:self.timeLabel];
        }
    }
}

// 计算时间。转为分钟
- (NSString *)changeTimeStamp:(NSString *)stamp
{
    if (stamp.integerValue/60000 >=60) {
        return [NSString stringWithFormat:@"%ld小时%ld分钟",stamp.integerValue/3600000,(stamp.integerValue%3600000)/60000];
    }else {
        return [NSString stringWithFormat:@"%ld分钟",stamp.integerValue/60000];
    }
}

// 显示月考勤数据
- (void)showMonthRecords
{
    [self.contentView addSubview:self.monthRecords];
    
    self.content.text = @"考勤月度汇总";
    self.content.alpha = 0.5;
    self.content.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.content];
}



@end
