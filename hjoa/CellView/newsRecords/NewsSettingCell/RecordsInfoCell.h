//
//  RecordsInfoCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsRecordSettingModel.h"

@interface RecordsInfoCell : UITableViewCell

- (void)refreshRecordPointData:(NewsRecordSettingModel *)model;

@end
