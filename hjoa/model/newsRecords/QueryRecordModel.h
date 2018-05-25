//
//  QueryRecordModel.h
//  hjoa
//
//  Created by 华剑 on 2017/9/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface QueryRecordModel : JSONModel

@property (strong, nonatomic) NSArray *cd; // 迟到
@property (strong, nonatomic) NSArray *zt; // 早退
@property (strong, nonatomic) NSArray *qk; // 缺卡
@property (strong, nonatomic) NSArray *wq; // 外勤

@property (strong, nonatomic) NSArray *cq; // 出勤
@property (strong, nonatomic) NSArray *xx; // 休息
@property (strong, nonatomic) NSArray *kg; // 旷工
//@property (strong, nonatomic) NSArray *pjgs;   // 当月平均工时

@end
