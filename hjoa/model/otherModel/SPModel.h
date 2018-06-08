//
//  SPModel.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface SPModel : JSONModel

@property (strong, nonatomic) NSString *oiOtheres;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *oiOthers;

// 劳务合同
@property (strong, nonatomic) NSString *rlcTreatycontent;
@property (strong, nonatomic) NSString *rlcContractnum;
@property (strong, nonatomic) NSString *rlcManpower;

// 材料合同
@property (strong, nonatomic) NSString *mctName;
@property (strong, nonatomic) NSString *mctContractnum;
@property (strong, nonatomic) NSString *mctContractsupplier;
@property (strong, nonatomic) NSString *mctContractmoney;

@end
