//
//  SBGJJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBGJJModel.h"

@protocol passSBGJJCellHeight <NSObject>

- (void)passHeightFromSBGJJCell:(CGFloat)height;

@end
@interface SBGJJCell : UITableViewCell

- (void)creatSBGJJApproveUIWithModel:(SBGJJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passSBGJJCellHeight> passHeightDelegate;


@end
