//
//  YCGZCell.h
//  hjoa
//
//  Created by 华剑 on 2018/3/22.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCGZModel.h"
@protocol passYCGZCellHeight <NSObject>

- (void)passHeightFromYCGZCell:(CGFloat)height;

@end

@interface YCGZCell : UITableViewCell


- (void)creatYCGZApproveUIWithModel:(YCGZModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passYCGZCellHeight> passHeightDelegate;

@end
