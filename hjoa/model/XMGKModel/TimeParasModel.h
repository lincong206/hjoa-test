//
//  TimeParasModel.h
//  hjoa
//
//  Created by 华剑 on 2018/1/29.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface TimeParasModel : JSONModel

@property (strong, nonatomic) NSString *startDay;
@property (strong, nonatomic) NSString *endDay;
@property (strong, nonatomic) NSString *currenStatus;
@property (strong, nonatomic) NSString *completionRate;

@end
