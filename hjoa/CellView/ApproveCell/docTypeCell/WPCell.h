//
//  WPCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPModel.h"

@protocol passWPCellHeight <NSObject>

- (void)passHeightFromWPCell:(CGFloat)height;

@end
@interface WPCell : UITableViewCell

- (void)creatWPApproveUIWithModel:(WPModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passWPCellHeight> passHeightDelegate;


@end
