//
//  RSLHCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSLHModel.h"

@protocol passRSLHCellHeight <NSObject>

- (void)passHeightFromRSLHCell:(CGFloat)height;

@end
@interface RSLHCell : UITableViewCell

- (void)creatRSLHApproveUIWithModel:(RSLHModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passRSLHCellHeight> passHeightDelegate;


@end
