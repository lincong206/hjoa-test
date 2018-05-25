//
//  LKDJ.h
//  hjoa
//
//  Created by 华剑 on 2017/8/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKDJModel.h"

@protocol passLKCellHeight <NSObject>

- (void)passLKCellHeight:(CGFloat )height;

@end

@interface LKDJ : UITableViewCell

- (void)referLKDJUIWithModel:(LKDJModel *)model;

@property (weak, nonatomic) id<passLKCellHeight> passDelegate;

@property (strong, nonatomic) NSArray *titleArr;   // 横向标题

@end
