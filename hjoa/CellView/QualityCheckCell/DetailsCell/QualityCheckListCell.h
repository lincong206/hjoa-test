//
//  QualityCheckListCell.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCListModel.h"

@interface QualityCheckListCell : UITableViewCell

- (void)refreshListCellWithModel:(QCListModel *)model;

@end
