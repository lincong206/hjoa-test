//
//  CalenderPMRecordCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/14.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCalenderModel.h"

@interface CalenderPMRecordCell : UITableViewCell

- (void)showPMRecordDataWithModel:(MonthCalenderModel *)model;

@property (strong, nonatomic) UIButton *PMMissBut;

@property (strong, nonatomic) NSString *PM;
@property (strong, nonatomic) NSString *uiId;
@property (assign, nonatomic) BOOL isWeek;

@end
