//
//  ZYLKCell.h
//  hjoa
//
//  Created by 华剑 on 2018/1/26.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYLKModel.h"

@protocol passZYLKCellHeight <NSObject>

- (void)passHeightFromZYLKCell:(CGFloat)height;

@end
@interface ZYLKCell : UITableViewCell

- (void)creatZYLKApproveUIWithModel:(ZYLKModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passZYLKCellHeight> passHeightDelegate;

@end
