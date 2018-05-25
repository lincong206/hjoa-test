//
//  XMTBPSCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMTBPSModel.h"

@protocol passXMTBPSHeight <NSObject>

- (void)passHeightFromXMTBPS:(CGFloat)height;

@end

@interface XMTBPSCell : UITableViewCell

- (void)creatXMTBPSApproveUIWithModel:(XMTBPSModel *)model;

@property (weak, nonatomic) id<passXMTBPSHeight> passHeightDelegate;

@end
