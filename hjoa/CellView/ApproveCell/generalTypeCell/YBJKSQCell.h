//
//  YBJKSQCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBJKSQModel.h"
@protocol passYBJKSQCellHeight <NSObject>

- (void)passHeightFromYBJKSQCell:(CGFloat)height;

@end
@interface YBJKSQCell : UITableViewCell

- (void)creatYBJKSQApproveUIWithModel:(YBJKSQModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passYBJKSQCellHeight> passHeightDelegate;

@end
