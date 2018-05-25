//
//  XMDFModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/1.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface XMDFModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *pbaCreatetime;
@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *bpcRealcontractid;
@property (strong, nonatomic) NSString *bpcName;
@property (strong, nonatomic) NSString *papReason;
@property (strong, nonatomic) NSString *papMoney;
@property (strong, nonatomic) NSString *papMoneyupper;
@property (strong, nonatomic) NSString *papPayer;
@property (strong, nonatomic) NSString *papPayee;
@property (strong, nonatomic) NSString *papOpenbank;
@property (strong, nonatomic) NSString *papOpenaccount;

@end
