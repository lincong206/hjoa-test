//
//  MonthChioceCell.h
//  hjoa
//
//  Created by 华剑 on 2017/11/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthChioceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordsCount;
@property (weak, nonatomic) IBOutlet UIButton *leftBut;
@property (weak, nonatomic) IBOutlet UIButton *rigthBut;

@end
