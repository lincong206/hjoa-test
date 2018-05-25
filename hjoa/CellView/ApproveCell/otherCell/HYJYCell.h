//
//  HYJYCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYJYModel.h"

@protocol passHYJYCellHeight <NSObject>

- (void)passHeightFromHYJYCell:(CGFloat)height;

@end

@interface HYJYCell : UITableViewCell

- (void)creatHYJYApproveUIWithModel:(HYJYModel *)model;

@property (weak, nonatomic) id<passHYJYCellHeight> passHeightDelegate;

@end
