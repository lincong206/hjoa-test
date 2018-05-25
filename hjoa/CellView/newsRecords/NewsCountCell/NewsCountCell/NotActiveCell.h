//
//  NotActiveCell.h
//  hjoa
//
//  Created by 华剑 on 2018/1/24.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyModel.h"

@interface NotActiveCell : UITableViewCell

- (void)refreshDataFromApplyModel:(ApplyModel *)model;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
