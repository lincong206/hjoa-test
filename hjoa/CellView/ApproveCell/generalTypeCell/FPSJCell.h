//
//  FPSJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPSJModel.h"
@protocol passFPSJCellHeight <NSObject>

- (void)passHeightFromFPSJCell:(CGFloat)height;

@end


@interface FPSJCell : UITableViewCell


- (void)creatFPSJApproveUIWithModel:(FPSJModel *)model;


// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passFPSJCellHeight> passHeightDelegate;
@end
