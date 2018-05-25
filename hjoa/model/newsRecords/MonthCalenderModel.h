//
//  MonthCalenderModel.h
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface MonthCalenderModel : JSONModel

@property (strong, nonatomic) NSString *nowDate;
@property (strong, nonatomic) NSString *workTime;

@property (strong, nonatomic) NSDictionary *caSetCardInformation;
@property (strong, nonatomic) NSString *sbBkrecord;
@property (strong, nonatomic) NSString *xbBkrecord;
@property (strong, nonatomic) NSDictionary *DKRecord;

@end
