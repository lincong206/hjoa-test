//
//  RecordPersonCell.h
//  hjoa
//
//  Created by 华剑 on 2017/9/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryNameModel.h"

@protocol passPickDateFromPresonCell <NSObject>

- (void)passPickDate:(NSString *)date;

@end

@interface RecordPersonCell : UITableViewCell

- (void)loadPresonData:(QueryNameModel *)model;

@property (weak, nonatomic) id<passPickDateFromPresonCell> passDateDelegate;

@end
