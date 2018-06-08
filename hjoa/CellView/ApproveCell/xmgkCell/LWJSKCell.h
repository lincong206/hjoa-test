//
//  LWJSKCell.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWJSKModel.h"
@protocol passLWJSKCellHeight <NSObject>

- (void)passHeightFromLWJSKCell:(CGFloat)height;

@end

@interface LWJSKCell : UITableViewCell


- (void)creatLWJSKApproveUIWithModel:(LWJSKModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passLWJSKCellHeight> passHeightDelegate;

@end
