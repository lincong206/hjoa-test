//
//  TBBHAndXMBHModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/12.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface TBBHAndXMBHModel : JSONModel

@property (strong, nonatomic) NSString *gaIdnum;

@property (strong, nonatomic) NSString *gaUiname;

@property (strong, nonatomic) NSString *gaPiname;
@property (strong, nonatomic) NSString *gaPiidnum;
@property (strong, nonatomic) NSString *gaPiadress;
@property (strong, nonatomic) NSString *gaPmname;
@property (strong, nonatomic) NSString *gaPmphone;
@property (strong, nonatomic) NSString *gaPibuild;
@property (strong, nonatomic) NSString *gaMoney;
@property (strong, nonatomic) NSString *gaBeneficiary;
@property (strong, nonatomic) NSString *gaValidtime;
@property (strong, nonatomic) NSString *gaType;

@property (strong, nonatomic) NSString *gaRequire;
@property (strong, nonatomic) NSString *gaTransaction;
@property (strong, nonatomic) NSString *gaDepositpercent;
@property (strong, nonatomic) NSString *gaDepositcash;
@property (strong, nonatomic) NSString *gaFactoragepercent;

@property (strong, nonatomic) NSString *gaPeriods;
@property (strong, nonatomic) NSString *gaFactoragecash;
@property (strong, nonatomic) NSString *gaCommitdata;
@property (strong, nonatomic) NSString *gaAssignbank;
@property (strong, nonatomic) NSString *gaOpeningbankname;
@property (strong, nonatomic) NSString *gaTransferbankname;
@property (strong, nonatomic) NSString *gaTransferbank;
@property (strong, nonatomic) NSString *gaTransferbanknum;
@property (strong, nonatomic) NSString *gaTransfermoney;
@property (strong, nonatomic) NSString *gaTransfertime;

/*
@property (strong, nonatomic) NSString *gaId;
@property (strong, nonatomic) NSString *gaIdtype;
@property (strong, nonatomic) NSString *gaCreatetime;
@property (strong, nonatomic) NSString *gaUiid;
@property (strong, nonatomic) NSString *gaPiid;
@property (strong, nonatomic) NSString *gaOther;
@property (strong, nonatomic) NSString *piBuildcompany;
@property (strong, nonatomic) NSString *piBuildcompanycontacts;
@property (strong, nonatomic) NSString *piBuildcompanymoblienlie;
@property (strong, nonatomic) NSString *page;
@property (strong, nonatomic) NSString *rows;
@property (strong, nonatomic) NSString *astStatus;
@property (strong, nonatomic) NSString *apApprovalstatus;
*/
@end
