//
//  LWandCLCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWandCLModel.h"

@protocol passLwClCellHeight <NSObject>

- (void)passLwClCellHeight:(CGFloat )height;

@end

@interface LWandCLCell : UITableViewCell

- (void)referLWClWithModel:(LWandCLModel *)model;

@property (weak, nonatomic) id<passLwClCellHeight> passHeightDelegate;

@property (strong, nonatomic) NSArray *titleArr;   // 横向标题

@end
