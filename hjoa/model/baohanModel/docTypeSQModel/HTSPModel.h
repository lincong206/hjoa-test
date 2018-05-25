//
//  HTSPModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface HTSPModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dcaCreatetime;
@property (strong, nonatomic) NSString *dcaContractname;
@property (strong, nonatomic) NSString *dcaContracttype;
@property (strong, nonatomic) NSString *dcaMoney;
@property (strong, nonatomic) NSString *dcaUsefullife;
@property (strong, nonatomic) NSString *dcaPaytype;
@property (strong, nonatomic) NSString *dcaOppositename;
@property (strong, nonatomic) NSString *dcaOppositephone;

@end
