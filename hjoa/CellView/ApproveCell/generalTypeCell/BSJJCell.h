//
//  BSJJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSJJModel.h"

@protocol passBSJJCellHeight <NSObject>

- (void)passHeightFromBSJJCell:(CGFloat)height;

@end

@interface BSJJCell : UITableViewCell

- (void)creatBSJJApproveUIWithModel:(BSJJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passBSJJCellHeight> passHeightDelegate;

@end
