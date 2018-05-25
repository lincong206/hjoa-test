//
//  YBJKSQModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface YBJKSQModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *upName;
@property (strong, nonatomic) NSString *gbCreatetime;
@property (strong, nonatomic) NSString *gbBorrowbalance;
@property (strong, nonatomic) NSString *gbUse;
@property (strong, nonatomic) NSString *gbPaytype;
@property (strong, nonatomic) NSString *gbMoney;
@property (strong, nonatomic) NSString *gbMoneyupper;
@property (strong, nonatomic) NSString *gbPayeeunit;
@property (strong, nonatomic) NSString *gbOpenbank;
@property (strong, nonatomic) NSString *gbBankaccount;
@property (strong, nonatomic) NSString *gbReason;

@end
