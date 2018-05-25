//
//  TXMBZJCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXMBZJModel.h"
@protocol passTXMBZJCellHeight <NSObject>

- (void)passHeightFromTXMBZJCell:(CGFloat)height;

@end

@interface TXMBZJCell : UITableViewCell

- (void)creatTXMBZJApproveUIWithModel:(TXMBZJModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passTXMBZJCellHeight> passHeightDelegate;

@end
