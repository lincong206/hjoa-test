//
//  XMBZJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBZJModel.h"

@protocol passXMBZJCellHeight <NSObject>

- (void)passHeightFromXMBZJCell:(CGFloat)height;

@end

@interface XMBZJCell : UITableViewCell

- (void)creatXMBZJApproveUIWithModel:(XMBZJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passXMBZJCellHeight> passHeightDelegate;

@end
