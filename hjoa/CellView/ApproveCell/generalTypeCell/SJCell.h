//
//  SJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGModel.h"

@protocol passSJCellHeight <NSObject>

- (void)passHeightFromSJCell:(CGFloat)height;

@end

@interface SJCell : UITableViewCell

- (void)creatSJApproveUIWithModel:(SGModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passSJCellHeight> passHeightDelegate;

@end
