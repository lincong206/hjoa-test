//
//  MonthRecordDataListViewController.h
//  hjoa
//
//  Created by 华剑 on 2017/11/4.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthRecordDataListViewController : UIViewController

@property (strong, nonatomic) NSArray *listData;    // 数据源
@property (strong, nonatomic) NSString *type;       // 点击的类型
@property (strong, nonatomic) NSString *time;       // 时间

@end
