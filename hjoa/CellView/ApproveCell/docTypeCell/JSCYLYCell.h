//
//  JSCYLYCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSCYLYModel.h"

@protocol passJSCYLYCellHeight <NSObject>

- (void)passHeightFromJSCYLYCell:(CGFloat)height;

@end
@interface JSCYLYCell : UITableViewCell

- (void)creatJSCYLYApproveUIWithModel:(JSCYLYModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passJSCYLYCellHeight> passHeightDelegate;


@end
