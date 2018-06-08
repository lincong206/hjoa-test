//
//  KPModel.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface KPModel : JSONModel
@property (strong, nonatomic) NSString *trIdnum;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *trCreattime;
@property (strong, nonatomic) NSString *trProjectname;
@property (strong, nonatomic) NSString *trProjectidnum;
@property (strong, nonatomic) NSString *trPrpojectleader;
@property (strong, nonatomic) NSString *trProjectleaderphone;
@property (strong, nonatomic) NSString *trContractnum;
@property (strong, nonatomic) NSString *trContractmoney;
@property (strong, nonatomic) NSString *trUnitname;
@property (strong, nonatomic) NSString *trCumulative;
@property (strong, nonatomic) NSString *trType;
@property (strong, nonatomic) NSString *trTrmoney;
@property (strong, nonatomic) NSString *trLed;
@property (strong, nonatomic) NSString *trLedphone;
@property (strong, nonatomic) NSString *trApplemoney;
@property (strong, nonatomic) NSString *trLabourmoney;
@property (strong, nonatomic) NSString *trLinvoiceconet;
@property (strong, nonatomic) NSString *trRegistrationnum;
@property (strong, nonatomic) NSString *trRegphone;
@property (strong, nonatomic) NSString *trRegbankname;
@property (strong, nonatomic) NSString *trRegbanknum;
@property (strong, nonatomic) NSString *trRegbank;
@property (strong, nonatomic) NSString *trRegadress;

@property (strong, nonatomic) NSString *oiDrawer;
@property (strong, nonatomic) NSString *oiCreatetime;
@property (strong, nonatomic) NSString *oiInvoicetitle;
@property (strong, nonatomic) NSString *oiTaxpayerid;
@property (strong, nonatomic) NSString *oiTaxinclusive;
@property (strong, nonatomic) NSString *oiNottaxinclusive;
@property (strong, nonatomic) NSString *oiTax;
@property (strong, nonatomic) NSString *oiRemark;

@end
