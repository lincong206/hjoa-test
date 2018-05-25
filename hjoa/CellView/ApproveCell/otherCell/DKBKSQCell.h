//
//  DKBKSQCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKBKSQModel.h"
@protocol passDKBKSQHeight <NSObject>

- (void)passHeightFromDKBKSQ:(CGFloat)height;

@end
@interface DKBKSQCell : UITableViewCell

- (void)creatDKBKSQApproveUIWithModel:(DKBKSQModel *)model;

@property (weak, nonatomic) id<passDKBKSQHeight> passHeightDelegate;

@end
