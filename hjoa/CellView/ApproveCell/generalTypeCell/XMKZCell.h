//
//  XMKZCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMKZModel.h"
@protocol passXMKZCellHeight <NSObject>

- (void)passHeightFromXMKZCell:(CGFloat)height;

@end

@interface XMKZCell : UITableViewCell

- (void)creatXMKZApproveUIWithModel:(XMKZModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passXMKZCellHeight> passHeightDelegate;

@end
