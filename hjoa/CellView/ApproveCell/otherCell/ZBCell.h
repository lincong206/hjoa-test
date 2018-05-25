//
//  ZBCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/14.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBModel.h"

@protocol passZBCellHeight <NSObject>

- (void)passHeightFromZBCell:(CGFloat)height;

@end

@interface ZBCell : UITableViewCell

- (void)creatZBApproveUIWithModel:(ZBModel *)model;

@property (weak, nonatomic) id<passZBCellHeight> passHeightDelegate;

@end
