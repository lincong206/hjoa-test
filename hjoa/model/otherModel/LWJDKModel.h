//
//  LWJDKModel.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface LWJDKModel : JSONModel

@property (strong, nonatomic) NSString *rlpIdnum;
@property (strong, nonatomic) NSString *rlpApplicationtime;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *piAdress;
@property (strong, nonatomic) NSString *rlcTreatycontent;
@property (strong, nonatomic) NSString *rlcContractnum;
@property (strong, nonatomic) NSString *rlcSecond;
@property (strong, nonatomic) NSString *rlcManpower;
@property (strong, nonatomic) NSString *rlpDepositbank;
@property (strong, nonatomic) NSString *rlpBankaccount;
@property (strong, nonatomic) NSString *rlpStarttime;
@property (strong, nonatomic) NSString *rlpEndtime;
@property (strong, nonatomic) NSString *rlpApplicationamount;
@property (strong, nonatomic) NSString *rlpAccruingamounts;
@property (strong, nonatomic) NSString *uiId;
@property (strong, nonatomic) NSString *rlpVisualschedule;
@property (strong, nonatomic) NSString *rlpJobcontent;

@end
