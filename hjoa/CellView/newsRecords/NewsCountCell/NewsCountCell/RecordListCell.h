//
//  RecordListCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListVCModel.h"

@interface RecordListCell : UITableViewCell

- (void)refreshCellWithModel:(ListVCModel *)model;
@property (strong, nonatomic) NSString *type;

@end
