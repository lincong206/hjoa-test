//
//  RSXQCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSXQModel.h"

@protocol passRSXQCellHeight <NSObject>

- (void)passHeightFromRSXQCell:(CGFloat)height;

@end
@interface RSXQCell : UITableViewCell

- (void)creatRSXQApproveUIWithModel:(RSXQModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passRSXQCellHeight> passHeightDelegate;


@end
