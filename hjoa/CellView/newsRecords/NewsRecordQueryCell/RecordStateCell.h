//
//  RecordStateCell.h
//  hjoa
//
//  Created by 华剑 on 2017/9/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryNameModel.h"

@interface RecordStateCell : UITableViewCell

- (void)setModel:(QueryNameModel *)model IndexPath:(NSIndexPath *)indexPath;

- (void)showMonthRecords;

@property (strong, nonatomic) UIButton *monthRecords;

@end
