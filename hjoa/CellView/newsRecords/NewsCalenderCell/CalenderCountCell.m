//
//  CalenderCountCell.m
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CalenderCountCell.h"

@interface CalenderCountCell ()

@property (weak, nonatomic) IBOutlet UILabel *CountLabel;

@end

@implementation CalenderCountCell

- (void)refreshRecordCountDataWithModel:(MonthCalenderModel *)model
{
    if ((model.DKRecord[@"crSbcardtime"] == nil || [model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) && (model.DKRecord[@"crXbcardtime"] == nil || [model.DKRecord[@"crXbcardtime"] isKindOfClass:[NSNull class]])) {
        self.CountLabel.text = [NSString stringWithFormat:@"今日打卡0次，工时共计0分钟"];
    }else if ((![model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) && (![model.DKRecord[@"crXbcardtime"] isKindOfClass:[NSNull class]])) {
        NSString *sbTime = [model.DKRecord[@"crSbcardtime"] componentsSeparatedByString:@"."].firstObject;
        NSString *xbTime = [model.DKRecord[@"crXbcardtime"] componentsSeparatedByString:@"."].firstObject;
        self.CountLabel.text = [NSString stringWithFormat:@"今日打卡2次，工时共计%@分钟",[self WorkOutTheTimeFromStart:sbTime andEnd:xbTime]];
    }else {
        self.CountLabel.text = [NSString stringWithFormat:@"今日打卡1次，工时共计0分钟"];
    }
}

// 计算上班时间
- (NSString *)WorkOutTheTimeFromStart:(NSString *)start andEnd:(NSString *)end
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *sbDate = [formatter dateFromString:start];
    NSDate *xbDate = [formatter dateFromString:end];
    NSInteger time = (long)[xbDate timeIntervalSince1970] - (long)[sbDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",time/60];
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
