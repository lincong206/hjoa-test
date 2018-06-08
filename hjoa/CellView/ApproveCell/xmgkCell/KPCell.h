//
//  KPCell.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPModel.h"
@protocol passKPCellHeight <NSObject>

- (void)passHeightFromKPCell:(CGFloat)height;

@end

@interface KPCell : UITableViewCell


- (void)creatKPApproveUIWithModel:(KPModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passKPCellHeight> passHeightDelegate;

@end
