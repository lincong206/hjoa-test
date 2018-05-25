//
//  YZWCCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZWCModel.h"

@protocol passYZWCCellHeight <NSObject>

- (void)passHeightFromYZWCCell:(CGFloat)height;

@end
@interface YZWCCell : UITableViewCell

- (void)creatYZWCApproveUIWithModel:(YZWCModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passYZWCCellHeight> passHeightDelegate;


@end
