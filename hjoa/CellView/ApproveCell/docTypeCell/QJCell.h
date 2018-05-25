//
//  QJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJModel.h"

@protocol passQJCellHeight <NSObject>

- (void)passHeightFromQJCell:(CGFloat)height;

@end
@interface QJCell : UITableViewCell

- (void)creatQJApproveUIWithModel:(QJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passQJCellHeight> passHeightDelegate;



@end
