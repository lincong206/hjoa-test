//
//  XMTableViewCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMModel.h"

@protocol passHeightFromXMCell <NSObject>

- (void)passHeightFromXMCell:(CGFloat )height;

@end

@interface XMTableViewCell : UITableViewCell

- (void)creatXMApproveUIWithModel:(XMModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passHeightFromXMCell> passHeightDelegate;

@end
