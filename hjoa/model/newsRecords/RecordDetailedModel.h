//
//  RecordDetailedModel.h
//  hjoa
//
//  Created by 华剑 on 2017/11/8.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordDetailedModel : NSObject

@property (strong, nonatomic) NSArray *cd; // 迟到
@property (strong, nonatomic) NSArray *zt; // 早退
@property (strong, nonatomic) NSArray *qk; // 缺卡
@property (strong, nonatomic) NSArray *wq; // 外勤
// 打卡明细
@property (strong, nonatomic) NSArray *wdk; // 未打卡
@property (strong, nonatomic) NSArray *qbdk; // 全部打卡
@property (strong, nonatomic) NSArray *zc;  // 正常

@end
