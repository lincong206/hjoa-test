//
//  LWFKModel.h
//  hjoa
//
//  Created by 华剑 on 2017/7/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface LWFKModel : JSONModel


@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *ploCreatetime;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *ploProjectprice;
@property (strong, nonatomic) NSString *ploSetterprice;
@property (strong, nonatomic) NSString *ploConstruct;
@property (strong, nonatomic) NSString *ploLabourpaytype;
@property (strong, nonatomic) NSString *ploOpenbank;
@property (strong, nonatomic) NSString *ploBankaccount;
@property (strong, nonatomic) NSString *ploTotalwillexpend;
@property (strong, nonatomic) NSString *ploTotalpasspay;
@property (strong, nonatomic) NSString *ploTotalfinishexpend;
@property (strong, nonatomic) NSString *ploTotalunsanctioned;
@property (strong, nonatomic) NSString *ploTotalunpaid;
@property (strong, nonatomic) NSString *ploTotalsanctioned;
@property (strong, nonatomic) NSString *ploCurrentpasspay;
@property (strong, nonatomic) NSString *ploTax;
@property (strong, nonatomic) NSString *ploCurrecttotal;
@property (strong, nonatomic) NSString *ploRemark;


@end
