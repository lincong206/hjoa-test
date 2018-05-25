//
//  LKDJModel.h
//  hjoa
//
//  Created by 华剑 on 2017/7/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface LKDJModel : JSONModel

@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *bpcRealcontractid;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *bpcName;
@property (strong, nonatomic) NSString *piBuildcompany;
@property (strong, nonatomic) NSString *bpcSupplyfee;
@property (strong, nonatomic) NSString *bpcProjectprice;
@property (strong, nonatomic) NSString *piBuildcompanycontacts;
@property (strong, nonatomic) NSString *uiBelongname;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *uiManagermobile;
@property (strong, nonatomic) NSString *prPayeeorganization;
@property (strong, nonatomic) NSString *bpcPayway;
@property (strong, nonatomic) NSString *prProjectcosttype;
@property (strong, nonatomic) NSString *prBatch;
@property (strong, nonatomic) NSString *prCurrentpaymoney;
@property (strong, nonatomic) NSString *prCurrentpaydate;
@property (strong, nonatomic) NSString *prDeduction;
@property (strong, nonatomic) NSString *prLasttotalpayee;
@property (strong, nonatomic) NSString *prTotalpayee;
@property (strong, nonatomic) NSString *prTotalwillexpend;
@property (strong, nonatomic) NSString *prTotalfinishexpend;
@property (strong, nonatomic) NSString *prTotallend;
@property (strong, nonatomic) NSString *prTotaladvance;
@property (strong, nonatomic) NSString *prWithhold;
@property (strong, nonatomic) NSString *prProgress;
@property (strong, nonatomic) NSString *prSettlement;
@property (strong, nonatomic) NSString *prRecoverdata;

@property (strong, nonatomic) NSString *prBusinessratio;
@property (strong, nonatomic) NSString *prBusinessmoney;
@property (strong, nonatomic) NSString *prBusinesstotalmoney;
@property (strong, nonatomic) NSString *prBusinessremark;

@property (strong, nonatomic) NSString *prPremium;
@property (strong, nonatomic) NSString *prPremiumtotal;
@property (strong, nonatomic) NSString *prPremiumremark;

@property (strong, nonatomic) NSString *prSealmoney;
@property (strong, nonatomic) NSString *prSealtotalmoney;
@property (strong, nonatomic) NSString *prSealremark;

@property (strong, nonatomic) NSString *prDeductpledge;
@property (strong, nonatomic) NSString *prDeductpledgetotal;
@property (strong, nonatomic) NSString *prDeductpledgeremark;

@property (strong, nonatomic) NSString *prDeductoverall;
@property (strong, nonatomic) NSString *prDeductoveralltotal;
@property (strong, nonatomic) NSString *prDeductoverallremark;

@property (strong, nonatomic) NSString *prExpressmoney;
@property (strong, nonatomic) NSString *prExpresstotalmoney;
@property (strong, nonatomic) NSString *prExpressremark;

@property (strong, nonatomic) NSString *prTaxesratio;
@property (strong, nonatomic) NSString *prTaxesmoney;
@property (strong, nonatomic) NSString *prTaxestotalmoney;
@property (strong, nonatomic) NSString *prTaxesremark;

@property (strong, nonatomic) NSString *prPrintingtaxes;
@property (strong, nonatomic) NSString *prPrintingtaxestotal;
@property (strong, nonatomic) NSString *prPrintingtaxesremark;

@property (strong, nonatomic) NSString *prReturnmoney;
@property (strong, nonatomic) NSString *prReturnmoneytotal;
@property (strong, nonatomic) NSString *prReturnmoneyremark;

@property (strong, nonatomic) NSString *prOuttrackdeposit;
@property (strong, nonatomic) NSString *prOuttrackdeposittotal;
@property (strong, nonatomic) NSString *prOuttrackremark;

@property (strong, nonatomic) NSString *prRent;
@property (strong, nonatomic) NSString *prRenttotal;
@property (strong, nonatomic) NSString *prRentremark;

@property (strong, nonatomic) NSString *prLaon;
@property (strong, nonatomic) NSString *prLaontotal;
@property (strong, nonatomic) NSString *prLaonremark;

@property (strong, nonatomic) NSString *prMoneyoccupy;
@property (strong, nonatomic) NSString *prMoneyoccupytotal;
@property (strong, nonatomic) NSString *prMoneyoccupyremark;

@property (strong, nonatomic) NSString *prBidmoney;
@property (strong, nonatomic) NSString *prBidtotalmoney;
@property (strong, nonatomic) NSString *prBidremark;

@property (strong, nonatomic) NSString *prOthercost;
@property (strong, nonatomic) NSString *prOthertotalcost;
@property (strong, nonatomic) NSString *prOthercostremark;

@property (strong, nonatomic) NSString *prDeductssaf;
@property (strong, nonatomic) NSString *prDeducttotalssaf;
@property (strong, nonatomic) NSString *prDeductssafremark;

@property (strong, nonatomic) NSString *prExittaxes;
@property (strong, nonatomic) NSString *prExittaxestotal;
@property (strong, nonatomic) NSString *prExittaxesremark;

@property (strong, nonatomic) NSString *prDeductlgmargin;
@property (strong, nonatomic) NSString *prDeductlgmargintotal;
@property (strong, nonatomic) NSString *prDeductlgmarginremark;

@property (strong, nonatomic) NSString *prLgpoundage;
@property (strong, nonatomic) NSString *prLgpoundagetotal;
@property (strong, nonatomic) NSString *prLgpoundagetremark;

@property (strong, nonatomic) NSString *prDeductoverspend;
@property (strong, nonatomic) NSString *prDeductoverspendtotal;
@property (strong, nonatomic) NSString *prDeductoverspendremark;

@property (strong, nonatomic) NSString *prSalary;
@property (strong, nonatomic) NSString *prSalarytotal;
@property (strong, nonatomic) NSString *prSalaryremark;

@property (strong, nonatomic) NSString *prBidmargin;
@property (strong, nonatomic) NSString *prBidmargintotal;
@property (strong, nonatomic) NSString *prBidmarginremark;

@property (strong, nonatomic) NSString *prDeducttotal;
@property (strong, nonatomic) NSString *prDeducttotaltotal;

@property (strong, nonatomic) NSString *prCanpaymoney;
@property (strong, nonatomic) NSString *prRemark;

@property (strong, nonatomic) NSString *prPayeeratio;
@property (strong, nonatomic) NSString *prSitecondition;

@end
