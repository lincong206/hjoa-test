//
//  RecordListModel.h
//  hjoa
//
//  Created by 华剑 on 2017/11/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface RecordListModel : JSONModel

@property (strong, nonatomic) NSString *uiId;       // 用户id
@property (strong, nonatomic) NSString *sbCardTime; // 上班打卡时间
@property (strong, nonatomic) NSString *crSort;     // 迟到次数/月度平均工作时长

@property (assign, nonatomic) NSInteger count;      // 第几个
@end
