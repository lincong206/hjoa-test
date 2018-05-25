//
//  YZHSCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZHSModel.h"

@protocol passYZHSCellHeight <NSObject>

- (void)passHeightFromYZHSCell:(CGFloat)height;

@end
@interface YZHSCell : UITableViewCell

- (void)creatYZHSApproveUIWithModel:(YZHSModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passYZHSCellHeight> passHeightDelegate;


@end
