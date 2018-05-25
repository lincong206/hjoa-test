//
//  TTBBZJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBBZJModel.h"
@protocol passTTBBZJCellHeight <NSObject>

- (void)passHeightFromTTBBZJCell:(CGFloat)height;

@end

@interface TTBBZJCell : UITableViewCell

- (void)creatTTBBZJApproveUIWithModel:(TTBBZJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passTTBBZJCellHeight> passHeightDelegate;

@end
