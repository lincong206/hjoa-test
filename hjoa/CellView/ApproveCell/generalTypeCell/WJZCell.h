//
//  WJZCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/28.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJZModel.h"

@protocol passWJZCellHeight <NSObject>

- (void)passHeightFromWJZCell:(CGFloat)height;

@end

@interface WJZCell : UITableViewCell

- (void)creatWJZApproveUIWithModel:(WJZModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passWJZCellHeight> passHeightDelegate;

@end
