//
//  NKDJCell.h
//  hjoa
//
//  Created by 华剑 on 2018/6/7.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKDJModel.h"
@protocol passNKDJCellHeight <NSObject>

- (void)passHeightFromNKDJCell:(CGFloat)height;

@end

@interface NKDJCell : UITableViewCell

- (void)creatNKDJApproveUIWithModel:(NKDJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passNKDJCellHeight> passHeightDelegate;


@end
