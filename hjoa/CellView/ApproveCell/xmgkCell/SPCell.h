//
//  SPCell.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPModel.h"
@protocol passSPCellHeight <NSObject>

- (void)passHeightFromSPCell:(CGFloat)height;

@end

@interface SPCell : UITableViewCell

- (void)creatSPApproveUIWithModel:(SPModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passSPCellHeight> passHeightDelegate;

@end
