//
//  BCHTCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCHTModel.h"

@protocol passBCHTCellHeight <NSObject>

- (void)passHeightFromBCHTCell:(CGFloat)height;

@end

@interface BCHTCell : UITableViewCell

- (void)creatBCHTApproveUIWithModel:(BCHTModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passBCHTCellHeight> passHeightDelegate;

@end
