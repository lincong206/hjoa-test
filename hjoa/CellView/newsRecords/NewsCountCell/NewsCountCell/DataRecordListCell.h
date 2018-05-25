//
//  DataRecordListCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/2.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCountModel.h"

@interface DataRecordListCell : UITableViewCell

- (void)refreshProgressDataWithModel:(DataCountModel *)model;

@end
