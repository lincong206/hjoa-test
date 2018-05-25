//
//  XMFZRCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMFZRModel.h"
@protocol passXMFZRCellHeight <NSObject>

- (void)passHeightFromXMFZRCell:(CGFloat)height;

@end

@interface XMFZRCell : UITableViewCell

- (void)creatXMFZRApproveUIWithModel:(XMFZRModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passXMFZRCellHeight> passHeightDelegate;

@end
