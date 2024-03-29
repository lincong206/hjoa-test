//
//  JKSQCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/1.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKSQModel.h"

@protocol passJKSQCellHeight <NSObject>

- (void)passHeightFromJKSQCell:(CGFloat)height;

@end
@interface JKSQCell : UITableViewCell

- (void)creatJKSQApproveUIWithModel:(JKSQModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passJKSQCellHeight> passHeightDelegate;

@end
