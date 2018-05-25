//
//  MonthDataCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryNameModel.h"

@interface MonthDataCell : UITableViewCell

- (void)refreshDataFromMothCellWith:(QueryNameModel *)model;

@end
