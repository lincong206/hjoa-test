//
//  ZYLKModel.h
//  hjoa
//
//  Created by 华剑 on 2018/1/26.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ZYLKModel : JSONModel

@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *bpcRealcontractid;
@property (strong, nonatomic) NSString *bpcName;
@property (strong, nonatomic) NSString *piBuildcompany;
@property (strong, nonatomic) NSString *bpcSupplyfee;
@property (strong, nonatomic) NSString *bpcProjectprice;
@property (strong, nonatomic) NSString *supperMoney;
@property (strong, nonatomic) NSString *piBuildcompanycontacts;
@property (strong, nonatomic) NSString *uiBelongname;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *uiManagermobile;
@property (strong, nonatomic) NSString *bpcPayway;

@property (strong, nonatomic) NSString *sprPayeeorganization;
@property (strong, nonatomic) NSString *sprProjectcosttype;
@property (strong, nonatomic) NSString *sprBatch;
@property (strong, nonatomic) NSString *sprCurrentpaymoney;
@property (strong, nonatomic) NSString *sprCurrentpaydate;
@property (strong, nonatomic) NSString *sprLasttotalpayee;
@property (strong, nonatomic) NSString *sprTotalpayee;
@property (strong, nonatomic) NSString *sprProgress;
@property (strong, nonatomic) NSString *sprPayeeratio;
@property (strong, nonatomic) NSString *sprSitecondition;
@property (strong, nonatomic) NSString *sprRemark;

@end
