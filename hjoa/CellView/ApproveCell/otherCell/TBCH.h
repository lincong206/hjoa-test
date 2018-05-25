//
//  TBCH.h
//  hjoa
//
//  Created by 华剑 on 2017/8/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCHModel.h"

@protocol passTBCHHeight <NSObject>

- (void)passHeightFromTBCH:(CGFloat)height;

@end

@interface TBCH : UITableViewCell

- (void)refreTBCHUIWithModel:(TBCHModel *)model;

@property (weak, nonatomic) id<passTBCHHeight> passHeightDelegate;

@end
