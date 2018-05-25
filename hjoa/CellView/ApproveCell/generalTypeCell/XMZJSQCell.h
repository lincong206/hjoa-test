//
//  XMZJSQCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/28.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMZJSQModel.h"

@protocol passXMZJSQCellHeight <NSObject>

- (void)passHeightFromXMZJSQCell:(CGFloat)height;

@end

@interface XMZJSQCell : UITableViewCell

- (void)creatXMZJSQApproveUIWithModel:(XMZJSQModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passXMZJSQCellHeight> passHeightDelegate;

@end
