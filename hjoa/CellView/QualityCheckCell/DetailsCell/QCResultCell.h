//
//  QCResultCell.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passQCResultCellHeight <NSObject>

- (void)passHeightFromQCResultCell:(CGFloat)height;

@end

@interface QCResultCell : UITableViewCell

- (void)loadQCResultFromDataSource:(NSString *)birInspectionresult;

@property (weak, nonatomic) id<passQCResultCellHeight> passHeightDelegate;

@end
