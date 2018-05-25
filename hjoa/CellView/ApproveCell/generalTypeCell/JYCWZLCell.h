//
//  JYCWZLCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYCWZLModel.h"

@protocol passJYCWZLCellHeight <NSObject>

- (void)passHeightFromJYCWZLCell:(CGFloat)height;

@end

@interface JYCWZLCell : UITableViewCell

- (void)creatJYCWZLApproveUIWithModel:(JYCWZLModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passJYCWZLCellHeight> passHeightDelegate;

@end
