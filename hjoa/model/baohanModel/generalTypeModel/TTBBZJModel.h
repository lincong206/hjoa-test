//
//  TTBBZModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/12.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface TTBBZJModel : JSONModel

@property (strong, nonatomic) NSString *bdrIdnum;
@property (strong, nonatomic) NSString *bdrCreatedate;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *bdrBuildcompany;
@property (strong, nonatomic) NSString *piRegion;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *bdrOperator;
@property (strong, nonatomic) NSString *bdrBidmoney;
@property (strong, nonatomic) NSString *bdrCollectmoney;
@property (strong, nonatomic) NSString *bdrRefunded;
@property (strong, nonatomic) NSString *bdrOfferpowerofattorney;
@property (strong, nonatomic) NSString *bdrPayeefullname;
@property (strong, nonatomic) NSString *bdrPaymethod;
@property (strong, nonatomic) NSString *bdrOpenbankname;
@property (strong, nonatomic) NSString *bdrOpenbankaccount;
@property (strong, nonatomic) NSString *bdrDeduction;
@property (strong, nonatomic) NSString *bdrDeductionupper;
@property (strong, nonatomic) NSString *bdrSendbackmoney;
@property (strong, nonatomic) NSString *bdrSendbackmoneyupper;
@property (strong, nonatomic) NSString *bdrRemark;

@end
