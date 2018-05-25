//
//  CalendarCell.h
//  hjoa
//
//  Created by 华剑 on 2017/3/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthModel.h"
#import "monthRecordModel.h"

@interface CalendarCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) MonthModel *monthModel;

@end
