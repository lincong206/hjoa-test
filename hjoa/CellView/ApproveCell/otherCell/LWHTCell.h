//
//  LWHTCell.h
//  hjoa
//
//  Created by 华剑 on 2018/6/7.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHTModel.h"

@protocol passLWHTHeight <NSObject>
- (void)passHeightFromLWHT:(CGFloat)height;

@end
@interface LWHTCell : UITableViewCell
- (void)creatLWHTApproveUIWithModel:(LWHTModel *)model;

@property (weak, nonatomic) id<passLWHTHeight> passHeightDelegate;


@end
