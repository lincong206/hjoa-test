//
//  WTSCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTSModel.h"
@protocol passWTSCellHeight <NSObject>

- (void)passHeightFromWTSCell:(CGFloat)height;

@end

@interface WTSCell : UITableViewCell

- (void)creatWTSApproveUIWithModel:(WTSModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passWTSCellHeight> passHeightDelegate;

@end
