//
//  CalenderRecordsCell.h
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCalenderModel.h"

@interface CalenderRecordsCell : UITableViewCell

- (void)showRecordDataWithModel:(MonthCalenderModel *)model;

@property (strong, nonatomic) UIButton *AMMissBut;
@property (strong, nonatomic) NSString *uiId;
@property (assign, nonatomic) BOOL isWeek;

@end
