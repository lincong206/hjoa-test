//
//  WPDHMCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPDHModel.h"

@protocol passWPDHMCellHeight <NSObject>

- (void)passHeightFromWPDHMCell:(CGFloat)height;

@end
@interface WPDHMCell : UITableViewCell

- (void)creatWPDHApproveUIWithModel:(WPDHModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passWPDHMCellHeight> passHeightDelegate;


@end
