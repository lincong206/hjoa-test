//
//  JSJSBCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSJSBModel.h"

@protocol passJSJSBCellHeight <NSObject>

- (void)passHeightFromJSJSBCell:(CGFloat)height;

@end
@interface JSJSBCell : UITableViewCell

- (void)creatJSJSBApproveUIWithModel:(JSJSBModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passJSJSBCellHeight> passHeightDelegate;


@end
