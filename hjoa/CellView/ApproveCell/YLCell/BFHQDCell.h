//
//  BFHQDCell.h
//  hjoa
//
//  Created by 华剑 on 2017/7/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFHQDModel.h"

@protocol passBFHQDCellHeight <NSObject>

- (void)passHeightFromBFHQDCell:(CGFloat)height;

@end
@interface BFHQDCell : UITableViewCell

- (void)creatBFHQDApproveUIWithModel:(BFHQDModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passBFHQDCellHeight> passHeightDelegate;

@end
