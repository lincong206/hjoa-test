//
//  XMBXModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/28.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface XMBXModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *uiPsname;
@property (strong, nonatomic) NSString *pcCode;
@property (strong, nonatomic) NSString *pcCreatedata;
@property (strong, nonatomic) NSString *piIdNum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *pcPaymentmethod;
@property (strong, nonatomic) NSString *pcAmountmoney;
@property (strong, nonatomic) NSString *pcAmountmoneycapital;
@property (strong, nonatomic) NSString *pcDepositbalance;
@property (strong, nonatomic) NSString *pcPayee;
@property (strong, nonatomic) NSString *pcBankaccount;
@property (strong, nonatomic) NSString *pcBankfullname;
@property (strong, nonatomic) NSString *pcNote;

@end
