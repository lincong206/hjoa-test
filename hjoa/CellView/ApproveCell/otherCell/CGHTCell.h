//
//  CGHTCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGHTModel.h"

@protocol passCGHTCellHeight <NSObject>

- (void)passHeightFromCGHTCell:(CGFloat)height;

@end

@interface CGHTCell : UITableViewCell

- (void)creatCGHTApproveUIWithModel:(CGHTModel *)model;

@property (weak, nonatomic) id<passCGHTCellHeight> passHeightDelegate;

@end
