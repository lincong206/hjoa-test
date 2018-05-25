//
//  ContentCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinssNewsModel.h"

@interface ContentCell : UITableViewCell

- (void)refreContentCellDataWithModel:(BusinssNewsModel *)model;

@end
