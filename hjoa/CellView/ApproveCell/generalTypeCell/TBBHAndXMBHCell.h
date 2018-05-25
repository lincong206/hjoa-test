//
//  TBBHAndXMBHCell.h
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBBHAndXMBHModel.h"

@protocol passTBBHAndXMBHCellHeight <NSObject>

- (void)passHeightFromTBBHAndXMBHCell:(CGFloat )height;

@end

@interface TBBHAndXMBHCell : UITableViewCell

- (void)creatTBBHAndXMBApproveUIWithModel:(TBBHAndXMBHModel *)model;

// 确定cell高度 返还给TableView
@property (weak, nonatomic) id<passTBBHAndXMBHCellHeight> passHeightDelegate;

@property (strong, nonatomic) NSString *nameCell;

@end
