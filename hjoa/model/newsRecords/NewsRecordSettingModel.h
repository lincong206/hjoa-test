//
//  NewsRecordSettingModel.h
//  hjoa
//
//  Created by 华剑 on 2017/11/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface NewsRecordSettingModel : JSONModel

@property (strong, nonatomic) NSString *sciAddress;     // 考勤点地址
@property (strong, nonatomic) NSString *sciPiname;      // 考勤组名
@property (strong, nonatomic) NSString *sciOffhour;     // 下班小时
@property (strong, nonatomic) NSString *sciOffminute;   // 下班分钟
@property (strong, nonatomic) NSString *sciWorkhour;    // 上班小时
@property (strong, nonatomic) NSString *sciWorkminute;  // 上班分钟
@property (strong, nonatomic) NSString *sciWorkday;     // 工作日

@property (strong, nonatomic) NSString *sciId;          // 考勤点

@end
