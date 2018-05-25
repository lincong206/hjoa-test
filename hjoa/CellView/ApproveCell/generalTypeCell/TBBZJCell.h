//
//  TBBZJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBBZJModel.h"
@protocol passTBBZJCellHeight <NSObject>

- (void)passHeightFromTBBZJCell:(CGFloat)height;

@end

@interface TBBZJCell : UITableViewCell

- (void)creatTBBZJApproveUIWithModel:(TBBZJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passTBBZJCellHeight> passHeightDelegate;

@end
