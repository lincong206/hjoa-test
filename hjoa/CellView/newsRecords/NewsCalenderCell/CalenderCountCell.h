//
//  CalenderCountCell.h
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCalenderModel.h"

@interface CalenderCountCell : UITableViewCell

- (void)refreshRecordCountDataWithModel:(MonthCalenderModel *)model;

@end
