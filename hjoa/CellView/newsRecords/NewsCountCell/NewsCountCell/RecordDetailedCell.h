//
//  RecordDetailedCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHTEModel.h"

@interface RecordDetailedCell : UITableViewCell

- (void)loadDataWithModel:(ZHTEModel *)model;

@property (strong, nonatomic) NSString *name;

@end
