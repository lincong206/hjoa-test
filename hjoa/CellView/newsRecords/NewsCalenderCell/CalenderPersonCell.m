//
//  CalenderPersonCell.m
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CalenderPersonCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "DataBaseManager.h"
#import "addressModel.h"

#import "QFDatePickerView.h"

@interface CalenderPersonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation CalenderPersonCell

- (void)loadCalenderPersonCell:(MonthCalenderModel *)model
{
    NSMutableArray *data = [[DataBaseManager shareDataBase] searchAllData];
    for (addressModel *model in data) {
        if ([model.uiId integerValue] == self.uiId.integerValue) {
            self.name.text = model.uiName;
            NSString *headerUrl = [NSString stringWithFormat:@"%@%@",headImageURL,model.uiHeadimage];
            [self.headImage sd_setImageWithURL:[NSURL URLWithString:headerUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                    self.headImage.image = [UIImage imageNamed:@"man"];
                }
            }];
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    self.date.text = [NSString stringWithFormat:@"%@ %@",self.selectDay,[self weekdayStringFromDate:[dateFormatter dateFromString:self.selectDay]]];
    self.date.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [self.date addGestureRecognizer:tap];
}

- (void)clickTap
{
    QFDatePickerView *qfDatePickView = [[QFDatePickerView alloc] initDatePackerWithResponse:^(NSString *str) {
        [self.passTimeDelegate passPersonCellTime:str];
    }];
    [qfDatePickView show];
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    if (inputDate) {
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
        return [weekdays objectAtIndex:theComponents.weekday];
    }else {
        return nil;
    }
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
