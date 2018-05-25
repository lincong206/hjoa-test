//
//  ZMSCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMSModel.h"

@protocol passZMSCellHeight <NSObject>

- (void)passHeightFromZMSCell:(CGFloat)height;

@end

@interface ZMSCell : UITableViewCell

- (void)creatZMSApproveUIWithModel:(ZMSModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passZMSCellHeight> passHeightDelegate;

@end
