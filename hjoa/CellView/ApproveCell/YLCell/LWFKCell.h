//
//  LWFKCell.h
//  hjoa
//
//  Created by 华剑 on 2017/7/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWFKModel.h"

@protocol passLWFKCellHeight <NSObject>

- (void)passHeightFromLWFKCell:(CGFloat)height;

@end

@interface LWFKCell : UITableViewCell

- (void)creatLWFKApproveUIWithModel:(LWFKModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passLWFKCellHeight> passHeightDelegate;

@end
