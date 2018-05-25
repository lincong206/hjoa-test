//
//  XMTBPSModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface XMTBPSModel : JSONModel

@property (strong, nonatomic) NSDictionary *bsProjectinfo;

@property (strong, nonatomic) NSString *beCapitalsource;
@property (strong, nonatomic) NSString *beTotaltime;
@property (strong, nonatomic) NSString *beClosingtime;
@property (strong, nonatomic) NSString *beEvaluationtype;
@property (strong, nonatomic) NSString *beBiddingtype;
@property (strong, nonatomic) NSString *beContractingtype;
@property (strong, nonatomic) NSString *beIsparticipation;
@property (strong, nonatomic) NSString *beBidnum;
@property (strong, nonatomic) NSString *beWinbidnum;
@property (strong, nonatomic) NSString *beComprehensivestrength;
@property (strong, nonatomic) NSString *beBidprobability;
@property (strong, nonatomic) NSString *beJudge;
@property (strong, nonatomic) NSString *bePaytype;
@property (strong, nonatomic) NSString *beBidbond;
@property (strong, nonatomic) NSString *bePerformancebond;
@property (strong, nonatomic) NSString *beWarrantyperiod;
@property (strong, nonatomic) NSString *beOthers;

@end
