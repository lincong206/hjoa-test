//
//  JSXCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSXModel.h"
@protocol passJSXCellHeight <NSObject>

- (void)passHeightFromJSXCell:(CGFloat)height;

@end
@interface JSXCell : UITableViewCell

- (void)creatJSXApproveUIWithModel:(JSXModel *)model;


// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passJSXCellHeight> passHeightDelegate;

@end
