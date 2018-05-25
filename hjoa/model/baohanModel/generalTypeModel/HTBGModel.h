//
//  HTBGModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface HTBGModel : JSONModel

@property (strong, nonatomic) NSDictionary *bsProjectinfo;

@property (strong, nonatomic) NSString *pcaRealcontractid;
@property (strong, nonatomic) NSString *pcaName;
@property (strong, nonatomic) NSString *pcaCopies;
@property (strong, nonatomic) NSString *pcaProjectprice;
@property (strong, nonatomic) NSString *pcaClearcontractor;
@property (strong, nonatomic) NSString *pcaOwnerpromaterial;
@property (strong, nonatomic) NSString *pcaProjectbigprice;
@property (strong, nonatomic) NSString *pcaSigneddate;
@property (strong, nonatomic) NSString *pcaStartdate;
@property (strong, nonatomic) NSString *pcaWorkeddate;
@property (strong, nonatomic) NSString *pcaWorkingtime;
@property (strong, nonatomic) NSString *pcaRetentiondate;

@property (strong, nonatomic) NSString *pcaAdvancepay;
@property (strong, nonatomic) NSString *pcaAdvancepaym;
@property (strong, nonatomic) NSString *pcaProgresspay;
@property (strong, nonatomic) NSString *pcaProgresspaym;
@property (strong, nonatomic) NSString *pcaSettlepay;
@property (strong, nonatomic) NSString *pcaSettlepaym;
@property (strong, nonatomic) NSString *pcaWorkedpay;
@property (strong, nonatomic) NSString *pcaWorkedpaym;
@property (strong, nonatomic) NSString *pcaRetentionpay;
@property (strong, nonatomic) NSString *pcaRetentionpaym;
@property (strong, nonatomic) NSString *pcaPayway;
@property (strong, nonatomic) NSString *pcaProjectitemsstate;
@property (strong, nonatomic) NSString *pcaIssingleitems;
@property (strong, nonatomic) NSString *pcaInsuranceway;
@property (strong, nonatomic) NSString *pcaContractaccount;
@property (strong, nonatomic) NSString *pcaContractingscope;
@property (strong, nonatomic) NSString *pcaWorkedacceptterm;
@property (strong, nonatomic) NSString *pcaRetentionterm;
@property (strong, nonatomic) NSString *pcaOperatename;
@property (strong, nonatomic) NSString *pcaOperatephone;
@property (strong, nonatomic) NSString *pcaOperatemove;
@property (strong, nonatomic) NSString *pcaArchivedate;
@property (strong, nonatomic) NSString *pcaArchiveid;
@property (strong, nonatomic) NSString *pcaArchivename;
@property (strong, nonatomic) NSString *pcaThenote;

@end
