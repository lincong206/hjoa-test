//
//  ZGGCCell.h
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "replyModel.h"
@protocol passZGGCCellHeight <NSObject>

- (void)passHeightFromZGGCCell:(CGFloat)height;

@end
@interface ZGGCCell : UITableViewCell

// 整改
- (void)refreshZGCellWithModel:(replyModel *)model;
// 复检
- (void)refreshFJCellWithModel:(replyModel *)model;

@property (strong, nonatomic) id<passZGGCCellHeight> passHeightDelegate;

@end
