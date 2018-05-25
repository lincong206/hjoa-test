//
//  JKBXCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/1.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKBXModel.h"

@protocol passJKBXCellHeight <NSObject>

- (void)passHeightFromJKBXCell:(CGFloat)height;

@end
@interface JKBXCell : UITableViewCell

- (void)creatJKBXApproveUIWithModel:(JKBXModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passJKBXCellHeight> passHeightDelegate;

@end
