//
//  GCYWCCCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCYWCCModel.h"

@protocol passGCYWCCCellHeight <NSObject>

- (void)passHeightFromGCYWCCCell:(CGFloat)height;

@end
@interface GCYWCCCell : UITableViewCell

- (void)creatGCYWCCApproveUIWithModel:(GCYWCCModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passGCYWCCCellHeight> passHeightDelegate;


@end
