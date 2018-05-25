//
//  SWWJAndGCLWJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWWJAndGCLWJModel.h"

@protocol passSWWJAndGCLWJCellHeight <NSObject>

- (void)passHeightFromSWWJAndGCLWJCell:(CGFloat)height;

@end

@interface SWWJAndGCLWJCell : UITableViewCell

- (void)creatSWWJAndGCLWJApproveUIWithModel:(SWWJAndGCLWJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passSWWJAndGCLWJCellHeight> passHeightDelegate;

@property (strong, nonatomic) NSString *nameCell;

@end
