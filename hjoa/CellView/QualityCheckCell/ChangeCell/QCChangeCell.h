//
//  QCChangeCell.h
//  hjoa
//
//  Created by 华剑 on 2018/4/17.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCListModel.h"

@interface QCChangeCell : UITableViewCell

- (void)refreshChangeCellWithModel:(QCListModel *)model;

@end
