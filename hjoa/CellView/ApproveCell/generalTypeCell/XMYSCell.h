//
//  XMYSCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMYSModel.h"

@protocol passXMYSCellHeight <NSObject>

- (void)passHeightFromXMYSCell:(CGFloat)height;

@end

@interface XMYSCell : UITableViewCell

- (void)creatXMYSApproveUIWithModel:(XMYSModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passXMYSCellHeight> passHeightDelegate;


@end
