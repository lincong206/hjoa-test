//
//  SGCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGModel.h"

@protocol passSGCellHeight <NSObject>

- (void)passHeightFromSGCell:(CGFloat)height;

@end

@interface SGCell : UITableViewCell

- (void)creatSGApproveUIWithModel:(SGModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passSGCellHeight> passHeightDelegate;


@end
