//
//  SpecialPJTCell.h
//  hjoa
//
//  Created by 华剑 on 2017/7/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialPJTModel.h"

@interface SpecialPJTCell : UITableViewCell

- (void)refreUIWithData:(SpecialPJTModel *)model;

@property (strong, nonatomic) NSString *type;

@end
