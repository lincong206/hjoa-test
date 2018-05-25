//
//  JKBXModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/1.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface JKBXModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *upName;
@property (strong, nonatomic) NSString *pbeCreatetime;
@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *bpcRealcontractid;
@property (strong, nonatomic) NSString *bpcName;
@property (strong, nonatomic) NSString *pbePaytype;
@property (strong, nonatomic) NSString *pbeCurrency;
@property (strong, nonatomic) NSString *pbeTotalmoney;
@property (strong, nonatomic) NSString *pbeTotalmoneyupper;
@property (strong, nonatomic) NSString *pbeNotexpenseborrow;
@property (strong, nonatomic) NSString *pbePayeeunit;
@property (strong, nonatomic) NSString *pbeOpenbank;
@property (strong, nonatomic) NSString *pbeOpenaccount;
@property (strong, nonatomic) NSString *pbeRemark;

@property (strong, nonatomic) NSString *pbedUse;
@property (strong, nonatomic) NSString *pbedMoney;
@property (strong, nonatomic) NSString *pbedRemark;

@end
