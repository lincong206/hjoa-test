//
//  XMZJSQModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/28.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface XMZJSQModel : JSONModel

@property (strong, nonatomic) NSString *createData;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *piIdNum;
@property (strong, nonatomic) NSString *prIdCode;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSString *bankAccount;
@property (strong, nonatomic) NSString *bankFullName;
@property (strong, nonatomic) NSString *payee;
@property (strong, nonatomic) NSString *borrower;
@property (strong, nonatomic) NSString *depositBalance;
@property (strong, nonatomic) NSString *paymentMethod;
@property (strong, nonatomic) NSString *amountMoneyCapital;
@property (strong, nonatomic) NSString *amountmoney;
@property (strong, nonatomic) NSString *capitaluses;

@end
