//
//  QCPersonCell.h
//  hjoa
//
//  Created by 华剑 on 2018/3/8.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addressModel.h"

@interface QCPersonCell : UITableViewCell

- (void)refreshUI:(addressModel *)model;

@end
