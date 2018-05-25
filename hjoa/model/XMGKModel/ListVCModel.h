//
//  ListVCModel.h
//  hjoa
//
//  Created by 华剑 on 2018/2/1.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ListVCModel : JSONModel

// 材料合同
@property (strong, nonatomic) NSString *mctName;
@property (strong, nonatomic) NSString *mctContractmoney;
@property (strong, nonatomic) NSString *astStatus;
@property (strong, nonatomic) NSString *uiName;
// 劳务合同
@property (strong, nonatomic) NSString *rlcTreatycontent;
@property (strong, nonatomic) NSString *rlcManpower;

@end
