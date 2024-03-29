//
//  MPCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPModel.h"

@protocol passMPCellHeight <NSObject>

- (void)passHeightFromMPCell:(CGFloat)height;

@end
@interface MPCell : UITableViewCell

- (void)creatMPApproveUIWithModel:(MPModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passMPCellHeight> passHeightDelegate;


@end
