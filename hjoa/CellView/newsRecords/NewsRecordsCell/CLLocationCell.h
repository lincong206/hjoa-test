//
//  CLLocationCell.h
//  hjoa
//
//  Created by 华剑 on 2017/9/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLLocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *myCLLocation; // 地址
@property (weak, nonatomic) IBOutlet UILabel *status;   // 状态

@end
