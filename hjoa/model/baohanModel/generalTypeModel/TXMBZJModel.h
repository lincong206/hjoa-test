//
//  TXMBZJModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/12.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface TXMBZJModel : JSONModel

@property (strong, nonatomic) NSString *pdrIdnum;
@property (strong, nonatomic) NSString *pdrCreatedate;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *pdrBuildcompany;
@property (strong, nonatomic) NSString *piRegion;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *pdrOperator;
@property (strong, nonatomic) NSString *pdrBidmoney;
@property (strong, nonatomic) NSString *pdrCollectmoney;
@property (strong, nonatomic) NSString *pdrRefunded;
@property (strong, nonatomic) NSString *pdrOfferpowerofattorney;
@property (strong, nonatomic) NSString *pdrPayeefullname;
@property (strong, nonatomic) NSString *pdrPaymethod;
@property (strong, nonatomic) NSString *pdrOpenbankname;
@property (strong, nonatomic) NSString *pdrOpenbankaccount;
@property (strong, nonatomic) NSString *pdrCurrentbackmoney;
@property (strong, nonatomic) NSString *pdrFinishdeductionmoney;
@property (strong, nonatomic) NSString *pdrDeduction;
@property (strong, nonatomic) NSString *pdrDeductionupper;
@property (strong, nonatomic) NSString *pdrSendbackmoney;
@property (strong, nonatomic) NSString *pdrSendbackmoneyupper;
@property (strong, nonatomic) NSString *pdrRemark;

@end
