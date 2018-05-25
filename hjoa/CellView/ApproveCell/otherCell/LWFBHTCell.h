//
//  LWFBHTCell.h
//  hjoa
//
//  Created by 华剑 on 2018/5/21.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWFBHTModel.h"

@protocol passLWFBHTHeight <NSObject>
- (void)passHeightFromLWFBHT:(CGFloat)height;

@end
@interface LWFBHTCell : UITableViewCell
- (void)creatLWFBHTApproveUIWithModel:(LWFBHTModel *)model;

@property (weak, nonatomic) id<passLWFBHTHeight> passHeightDelegate;

@end
