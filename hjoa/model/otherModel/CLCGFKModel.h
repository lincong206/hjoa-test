//
//  CLCGFKModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface CLCGFKModel : JSONModel

@property (strong, nonatomic) NSString *mctContractnum;
@property (strong, nonatomic) NSString *mctName;
@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *mctContractsupplier;
@property (strong, nonatomic) NSString *mctContractmoney;
@property (strong, nonatomic) NSString *mpOpenbank;
//@property (strong, nonatomic) NSDictionary *mcMaterialcontract;
@property (strong, nonatomic) NSString *mpOpenbanknum;
@property (strong, nonatomic) NSString *mpNowmpmoney;
@property (strong, nonatomic) NSString *mpPaymoney;
@property (strong, nonatomic) NSString *mpPrepaidmoney;
@property (strong, nonatomic) NSString *uiName;

@end
