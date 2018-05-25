//
//  HTSPCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSPModel.h"

@protocol passHTSPCellHeight <NSObject>

- (void)passHeightFromHTSPCell:(CGFloat)height;

@end
@interface HTSPCell : UITableViewCell

- (void)creatHTSPApproveUIWithModel:(HTSPModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passHTSPCellHeight> passHeightDelegate;


@end
