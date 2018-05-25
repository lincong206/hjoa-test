//
//  JCBGCell.h
//  hjoa
//
//  Created by 华剑 on 2017/12/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCBGModel.h"
@protocol passJCBGHeight <NSObject>

- (void)passHeightFromJCBG:(CGFloat)height;

@end
@interface JCBGCell : UITableViewCell

- (void)creatJCBGApproveUIWithModel:(JCBGModel *)model;

@property (weak, nonatomic) id<passJCBGHeight> passHeightDelegate;

@end
