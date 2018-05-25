//
//  DataRecordsCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/2.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCountModel.h"

@protocol passClickButFromDataRecordCell <NSObject>

- (void)passModel:(DataCountModel *)model withTitle:(NSString *)title;

@end

@interface DataRecordsCell : UITableViewCell

- (void)refreshDataRecordCellWithData:(NSMutableArray *)data;

@property (weak, nonatomic) id<passClickButFromDataRecordCell> passModelDelegate;

@property (strong, nonatomic) NSString *xmName;

@property (strong, nonatomic) UIButton *recordDetailed; // 打卡明细按钮

@end
