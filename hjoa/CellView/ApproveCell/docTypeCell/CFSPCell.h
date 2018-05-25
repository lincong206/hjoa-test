//
//  CFSPCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFSPModel.h"

@protocol passCFSPCellHeight <NSObject>

- (void)passHeightFromCFSPCell:(CGFloat)height;

@end
@interface CFSPCell : UITableViewCell

- (void)creatCFSPApproveUIWithModel:(CFSPModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passCFSPCellHeight> passHeightDelegate;


@end
