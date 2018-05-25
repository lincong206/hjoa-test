//
//  ZBDLCell.h
//  hjoa
//
//  Created by 华剑 on 2017/10/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBDLModel.h"
@protocol passZBDLHeight <NSObject>

- (void)passHeightFromZBDL:(CGFloat)height;

@end

@interface ZBDLCell : UITableViewCell

- (void)creatZBDLApproveUIWithModel:(ZBDLModel *)model;

@property (weak, nonatomic) id<passZBDLHeight> passHeightDelegate;

@end
