//
//  monthRecordModel.h
//  hjoa
//
//  Created by 华剑 on 2017/3/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface monthRecordModel : JSONModel

@property (strong, nonatomic) NSString *day;             // 当月的第几天

@property (strong, nonatomic) NSString *attendType;      // 考勤识别代码

@end
