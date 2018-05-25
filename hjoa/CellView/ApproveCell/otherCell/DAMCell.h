//
//  DAMCell.h
//  hjoa
//
//  Created by 华剑 on 2017/12/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAMModel.h"
@protocol passDAMHeight <NSObject>

- (void)passHeightFromDAM:(CGFloat)height;

@end
@interface DAMCell : UITableViewCell
- (void)creatDAMApproveUIWithModel:(DAMModel *)model;

@property (weak, nonatomic) id<passDAMHeight> passHeightDelegate;

@end
