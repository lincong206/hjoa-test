//
//  YBBXCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBBXModel.h"
#import "BXMX.h"

@protocol passYBBXCellHeight <NSObject>

- (void)passHeightFromYBBXCell:(CGFloat)height;

@end
@interface YBBXCell : UITableViewCell

- (void)creatYBBXApproveUIWithModel:(YBBXModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passYBBXCellHeight> passHeightDelegate;

@end
