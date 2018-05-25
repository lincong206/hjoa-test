//
//  HTBGCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTBGModel.h"

@protocol passHTBGCellHeight <NSObject>

- (void)passHeightFromHTBGCell:(CGFloat)height;

@end

@interface HTBGCell : UITableViewCell

- (void)creatHTBGApproveUIWithModel:(HTBGModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passHTBGCellHeight> passHeightDelegate;


@end
