//
//  BXMXCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXMX.h"

@protocol passBXMXHeight <NSObject>

- (void)passHeightFromBXMX:(CGFloat)height;

@end
@interface BXMXCell : UITableViewCell

- (void)referUIWithModel:(BXMX *)model;

@property (weak, nonatomic) id<passBXMXHeight> passHeightDelegate;

@end
