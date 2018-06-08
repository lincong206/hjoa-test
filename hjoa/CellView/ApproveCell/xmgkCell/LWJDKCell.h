//
//  LWJDKCell.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWJDKModel.h"
@protocol passLWJDKCellHeight <NSObject>

- (void)passHeightFromLWJDKCell:(CGFloat)height;

@end

@interface LWJDKCell : UITableViewCell


- (void)creatLWJDKApproveUIWithModel:(LWJDKModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passLWJDKCellHeight> passHeightDelegate;

@end
