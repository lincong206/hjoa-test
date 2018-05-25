//
//  MonthModel.h
//  hjoa
//
//  Created by 华剑 on 2017/3/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthModel : NSObject

@property (assign, nonatomic) NSInteger dayValue;
@property (strong, nonatomic) NSDate *dateValue;
@property (assign, nonatomic) BOOL isSelectedDay;
@property (strong, nonatomic) NSString *attendType;      // 考勤识别代码
@property (assign, nonatomic) BOOL isPass;              // 是否为过去时间
@property (assign, nonatomic) BOOL isWeek;              // 是否为周末

@end
