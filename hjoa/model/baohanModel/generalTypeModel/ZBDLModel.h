//
//  ZBDLModel.h
//  hjoa
//
//  Created by 华剑 on 2017/10/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ZBDLModel : JSONModel

@property (strong, nonatomic) NSString *bpaIdnum;
@property (strong, nonatomic) NSString *bpaCreatedate;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *bpaExpectedreturnbidtime;
@property (strong, nonatomic) NSString *piBuildcompany;
@property (strong, nonatomic) NSString *piRegion;
@property (strong, nonatomic) NSString *bpaPayerfullname;
@property (strong, nonatomic) NSString *bpaPaymentmethod;
@property (strong, nonatomic) NSString *bpaPayeefullname;
@property (strong, nonatomic) NSString *bpaOfferpowerofattorney;
@property (strong, nonatomic) NSString *bpaOpenbankname;
@property (strong, nonatomic) NSString *bpaPromptatthelongest;
@property (strong, nonatomic) NSString *bpaOpenbankaccount;
@property (strong, nonatomic) NSString *bpaPayeeissuereceipt;
@property (strong, nonatomic) NSString *bpaOpenbankaddress;
@property (strong, nonatomic) NSString *bpaIspayment;
@property (strong, nonatomic) NSString *bpaBidmoney;
@property (strong, nonatomic) NSString *bpaBidmoneyupper;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *uiManagermobile;
@property (strong, nonatomic) NSString *bpaRemark;

@end
