//
//  JDCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDModel.h"

@protocol passJDCellHeight <NSObject>

- (void)passHeightFromJDCell:(CGFloat)height;

@end
@interface JDCell : UITableViewCell

- (void)creatJDApproveUIWithModel:(JDModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passJDCellHeight> passHeightDelegate;


@end
