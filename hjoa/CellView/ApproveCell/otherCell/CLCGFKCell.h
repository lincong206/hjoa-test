//
//  CLCGFKCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCGFKModel.h"

@protocol passCLCGFKCellHeight <NSObject>

- (void)passHeightFromCLCGFKCell:(CGFloat)height;

@end

@interface CLCGFKCell : UITableViewCell

- (void)creatCLCGFKApproveUIWithModel:(CLCGFKModel *)model;

@property (weak, nonatomic) id<passCLCGFKCellHeight> passHeightDelegate;

@end
