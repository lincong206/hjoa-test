//
//  XMBXCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/28.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBXModel.h"

@protocol passXMBXCellHeight <NSObject>

- (void)passHeightFromXMBXCell:(CGFloat)height;

@end

@interface XMBXCell : UITableViewCell

- (void)creatXMBXApproveUIWithModel:(XMBXModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passXMBXCellHeight> passHeightDelegate;

@end
