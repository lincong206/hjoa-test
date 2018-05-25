//
//  CalenderPersonCell.h
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCalenderModel.h"

@protocol passDateFromPersonCell <NSObject>

- (void)passPersonCellTime:(NSString *)time;

@end

@interface CalenderPersonCell : UITableViewCell

- (void)loadCalenderPersonCell:(MonthCalenderModel *)model;

@property (strong, nonatomic) NSString *selectDay;
@property (strong, nonatomic) NSString *uiId;

@property (weak, nonatomic) id<passDateFromPersonCell> passTimeDelegate;

@end
