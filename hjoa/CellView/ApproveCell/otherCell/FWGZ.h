//
//  FWGZ.h
//  hjoa
//
//  Created by 华剑 on 2017/8/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWGZModel.h"

@protocol passFWGZHeight <NSObject>

- (void)passHeightFromFWGZ:(CGFloat)height;

@end

@interface FWGZ : UITableViewCell

- (void)refreFWGZUIWithModel:(FWGZModel *)model;

@property (weak, nonatomic) id<passFWGZHeight> passHeightDelegate;

@end
