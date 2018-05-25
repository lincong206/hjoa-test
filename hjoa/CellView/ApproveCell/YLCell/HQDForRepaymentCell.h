//
//  HQDForRepaymentCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFHQDModel.h"

@interface HQDForRepaymentCell : UITableViewCell

- (void)referRepayWithModel:(BFHQDModel *)model;

@property (strong, nonatomic) NSArray *titleArr;

@end
