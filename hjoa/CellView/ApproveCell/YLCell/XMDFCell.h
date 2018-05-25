//
//  XMDFCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/1.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMDFModel.h"

@protocol passXMDFCellHeight <NSObject>

- (void)passHeightFromXMDFCell:(CGFloat)height;

@end
@interface XMDFCell : UITableViewCell

- (void)creatXMDFApproveUIWithModel:(XMDFModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passXMDFCellHeight> passHeightDelegate;

@end
