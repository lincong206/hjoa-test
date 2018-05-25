//
//  CalendarCell.m
//  hjoa
//
//  Created by 华剑 on 2017/3/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (void)setMonthModel:(MonthModel *)monthModel{
    _monthModel = monthModel;
    self.dayLabel.text = [NSString stringWithFormat:@"%02ld",(long)monthModel.dayValue];
    
    switch (monthModel.attendType.integerValue) {
        case 0:     // 按时
            self.dayLabel.backgroundColor = [UIColor colorWithRed:132/255.0 green:228/255.0 blue:157/255.0 alpha:0.7];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        case 1:     // 迟到
            self.dayLabel.backgroundColor = [UIColor colorWithRed:245/255.0 green:156/255.0 blue:157/255.0 alpha:0.7];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        case 2:     // 早退
            self.dayLabel.backgroundColor = [UIColor colorWithRed:245/255.0 green:156/255.0 blue:157/255.0 alpha:0.7];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        case 3:     // 迟到并早退
            self.dayLabel.backgroundColor = [UIColor colorWithRed:245/255.0 green:156/255.0 blue:157/255.0 alpha:0.7];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        case 4:     // 出差
            self.dayLabel.backgroundColor = [UIColor colorWithRed:148/255.0 green:179/255.0 blue:242/255.0 alpha:0.7];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        case 5:     // 旷工或放假或请假
            self.dayLabel.backgroundColor = [UIColor colorWithRed:245/255.0 green:156/255.0 blue:157/255.0 alpha:0.7];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        case 6:     // 周末
            self.dayLabel.backgroundColor = [UIColor colorWithRed:249/255.0 green:214/255.0 blue:113/255.0 alpha:0.7];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        case 7:     // 为记录日期
            self.dayLabel.backgroundColor = [UIColor whiteColor];
            self.dayLabel.textColor = [UIColor blackColor];
            break;
        case 8:     // 为当天
            self.dayLabel.backgroundColor = [UIColor redColor];
            self.dayLabel.textColor = [UIColor whiteColor];
            break;
        default:
            self.dayLabel.backgroundColor = [UIColor whiteColor];
            self.dayLabel.textColor = [UIColor blackColor];
            break;
    }
}

@end
