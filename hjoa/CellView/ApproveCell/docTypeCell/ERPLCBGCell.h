//
//  ERPLCBGCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERPLCBGModel.h"

@protocol passERPLCBGCellHeight <NSObject>

- (void)passHeightFromERPLCBGCell:(CGFloat)height;

@end
@interface ERPLCBGCell : UITableViewCell

- (void)creatERPLCBGApproveUIWithModel:(ERPLCBGModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passERPLCBGCellHeight> passHeightDelegate;


@end
