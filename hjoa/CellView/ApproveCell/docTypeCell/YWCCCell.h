//
//  YWCCCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWCCModel.h"

@protocol passYWCCCellHeight <NSObject>

- (void)passHeightFromYWCCCell:(CGFloat)height;

@end
@interface YWCCCell : UITableViewCell

- (void)creatYWCCApproveUIWithModel:(YWCCModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passYWCCCellHeight> passHeightDelegate;


@end
