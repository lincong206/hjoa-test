//
//  QCStatusButCell.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCDetailsModel.h"

@protocol passButStatus <NSObject>

- (void)passButStatus:(NSString *)status andButTag:(NSInteger)tag;

@end

@interface QCStatusButCell : UITableViewCell

@property (strong, nonatomic) NSArray *butName;

- (void)loadQCStatusFromState:(NSString *)state andUserEnabled:(BOOL)abled;

@property (weak, nonatomic) id<passButStatus> passStatusDelegate;

@end
