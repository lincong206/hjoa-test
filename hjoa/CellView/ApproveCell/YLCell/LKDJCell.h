//
//  LKDJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/7/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKDJModel.h"

@protocol passLKDJCellHeight <NSObject>

- (void)passHeightFromLKDJCell:(CGFloat)height;

@end

@interface LKDJCell : UITableViewCell

- (void)creatLKDJApproveUIWithModel:(LKDJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passLKDJCellHeight> passHeightDelegate;

@end
