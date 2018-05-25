//
//  BCHT.h
//  hjoa
//
//  Created by 华剑 on 2017/8/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCHTModel.h"

@protocol passBCHTHeight <NSObject>

- (void)passHeightFromBCHT:(CGFloat)height;

@end

@interface BCHT : UITableViewCell

- (void)refreBCHTUIWithModel:(BCHTModel *)model;

@property (strong, nonatomic) NSArray *titleArr;   // 横向标题

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passBCHTHeight> passHeightDelegate;

@end
