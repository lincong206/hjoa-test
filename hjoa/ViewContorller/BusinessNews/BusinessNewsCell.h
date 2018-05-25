//
//  BusinessNewsCell.h
//  hjoa
//
//  Created by 华剑 on 2017/8/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClickNewsViewController.h"

@protocol passViewForPush <NSObject>

- (void)passViewForPush:(ClickNewsViewController *)view;

@end

@interface BusinessNewsCell : UITableViewCell

- (void)passData:(NSMutableArray *)arr;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) id<passViewForPush> passDelegate;

@end
