//
//  FWGZCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/14.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWGZModel.h"

@protocol passFWGZCellHeight <NSObject>

- (void)passHeightFromFWGZCell:(CGFloat)height;

@end

@interface FWGZCell : UITableViewCell

- (void)creatFWGZApproveUIWithModel:(FWGZModel *)model;

@property (weak, nonatomic) id<passFWGZCellHeight> passHeightDelegate;


@end
