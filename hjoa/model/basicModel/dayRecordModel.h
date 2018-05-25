//
//  dayRecordModel.h
//  hjoa
//
//  Created by 华剑 on 2017/3/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface dayRecordModel : JSONModel

@property (strong, nonatomic) NSString *waAttendancetype;           // 0 为内勤  1 为外勤
@property (strong, nonatomic) NSString *waAttendancetime;           // 打卡时间
@property (strong, nonatomic) NSString *waEvectionarea;             // 外勤打卡地址

@end
