//
//  DocDownCell.h
//  hjoa
//
//  Created by 华剑 on 2017/12/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocTypeModel.h"

@interface DocDownCell : UITableViewCell

- (void)refreshDownDocWithModel:(DocTypeModel *)model;

@property (strong, nonatomic) NSString *type;

@end
