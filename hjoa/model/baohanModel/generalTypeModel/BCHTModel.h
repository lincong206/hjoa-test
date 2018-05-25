//
//  BCHTModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface BCHTModel : JSONModel

@property (strong, nonatomic) NSDictionary *bsProjectinfo;

@property (strong, nonatomic) NSString *pcsRealcontractid;
@property (strong, nonatomic) NSString *pcsName;
@property (strong, nonatomic) NSString *pcsCopies;
@property (strong, nonatomic) NSString *pcsProjectprice;
@property (strong, nonatomic) NSString *pcsClearcontractor;
@property (strong, nonatomic) NSString *pcsOwnerpromaterial;
@property (strong, nonatomic) NSString *pcsProjectbigprice;
@property (strong, nonatomic) NSString *pcsSigneddate;
@property (strong, nonatomic) NSString *pcsStartdate;
@property (strong, nonatomic) NSString *pcsWorkeddate;
@property (strong, nonatomic) NSString *pcsWorkingtime;
@property (strong, nonatomic) NSString *pcsRetentiondate;

@property (strong, nonatomic) NSString *pcsAdvancepay;
@property (strong, nonatomic) NSString *pcsAdvancepaym;
@property (strong, nonatomic) NSString *pcsProgresspay;
@property (strong, nonatomic) NSString *pcsProgresspaym;
@property (strong, nonatomic) NSString *pcsSettlepay;
@property (strong, nonatomic) NSString *pcsSettlepaym;
@property (strong, nonatomic) NSString *pcsWorkedpay;
@property (strong, nonatomic) NSString *pcsWorkedpaym;
@property (strong, nonatomic) NSString *pcsRetentionpay;
@property (strong, nonatomic) NSString *pcsRetentionpaym;
@property (strong, nonatomic) NSString *pcsPayway;
@property (strong, nonatomic) NSString *pcsProjectitemsstate;
@property (strong, nonatomic) NSString *pcsIssingleitems;
@property (strong, nonatomic) NSString *pcsInsuranceway;
@property (strong, nonatomic) NSString *pcsContractaccount;
@property (strong, nonatomic) NSString *pcsContractingscope;
@property (strong, nonatomic) NSString *pcsWorkedacceptterm;
@property (strong, nonatomic) NSString *pcsRetentionterm;
@property (strong, nonatomic) NSString *pcsOperatename;
@property (strong, nonatomic) NSString *pcsOperatephone;
@property (strong, nonatomic) NSString *pcsOperatemove;
@property (strong, nonatomic) NSString *pcsArchivedate;
@property (strong, nonatomic) NSString *pcsArchiveid;
@property (strong, nonatomic) NSString *pcsArchivename;
@property (strong, nonatomic) NSString *pcsThenote;

//@property (strong, nonatomic) NSString *pcpPaydate;
//@property (strong, nonatomic) NSString *pcpPayfee;
//@property (strong, nonatomic) NSString *pcpPaycondition;
//@property (strong, nonatomic) NSString *pcpNote;

@property (strong, nonatomic) NSArray *bsProjectContractPays;

@end
