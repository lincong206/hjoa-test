//
//  CalenderNewsCell.h
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passSelectDayFromCalenderNewCell <NSObject>

- (void)passSelectDay:(NSString *)day andIsWeek:(BOOL)week;

@end

@interface CalenderNewsCell : UITableViewCell

- (void)passDate:(NSString *)date;

@property (weak, nonatomic) id<passSelectDayFromCalenderNewCell> passDayDelegate;

@end
