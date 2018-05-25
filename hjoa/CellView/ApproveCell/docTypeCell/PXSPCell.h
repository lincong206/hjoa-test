//
//  PXSPCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXSPModel.h"

@protocol passPXSPCellHeight <NSObject>

- (void)passHeightFromPXSPCell:(CGFloat)height;

@end
@interface PXSPCell : UITableViewCell

- (void)creatPXSPApproveUIWithModel:(PXSPModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passPXSPCellHeight> passHeightDelegate;


@end
