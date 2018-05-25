//
//  TBCHCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCHModel.h"

@protocol passTBCHCellHeight <NSObject>

- (void)passHeightFromTBCHCell:(CGFloat)height;

@end

@interface TBCHCell : UITableViewCell

- (void)creatTBCHApproveUIWithModel:(TBCHModel *)model;

@property (weak, nonatomic) id<passTBCHCellHeight> passHeightDelegate;

@end
