//
//  ScheduleModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ScheduleModel : JSONModel

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSArray *arr;

//@property (strong, nonatomic) NSArray *iconArr;
@end
