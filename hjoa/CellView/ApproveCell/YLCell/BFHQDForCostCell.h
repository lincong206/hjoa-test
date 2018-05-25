//
//  BFHQDForCostCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFHQDModel.h"

@protocol passCostCellHeight <NSObject>

- (void)passCostCellHeight:(CGFloat)height;

@end

@interface BFHQDForCostCell : UITableViewCell

- (void)referCostUIWithModel:(BFHQDModel *)model;

@property (weak, nonatomic) id<passCostCellHeight> passheightDelegate;

@end
