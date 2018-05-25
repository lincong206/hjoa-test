//
//  NewsRecordModel.h
//  hjoa
//
//  Created by 华剑 on 2017/9/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface NewsRecordModel : JSONModel

@property (strong, nonatomic) NSString *nowDate;        // 系统返回的时间
@property (strong, nonatomic) NSDictionary *caSetCardInformation;   // 为打卡信息
@property (strong, nonatomic) NSString *sbBkrecord;   // 上班补卡状态
@property (strong, nonatomic) NSString *xbBkrecord;   // 下班补卡状态
@property (strong, nonatomic) NSDictionary *DKRecord;   // 打卡记录

@property (strong, nonatomic) NSString *timeS;
@property (strong, nonatomic) NSMutableDictionary *timeD;
@property (assign, nonatomic) BOOL isLate;      // 是否迟到

@end
