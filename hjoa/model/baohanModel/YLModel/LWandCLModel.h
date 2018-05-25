//
//  LWandCLModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface LWandCLModel : JSONModel

@property (strong, nonatomic) NSString *lmiContractid;
@property (strong, nonatomic) NSString *lmiContractname;
@property (strong, nonatomic) NSString *lmiCompany;
@property (strong, nonatomic) NSString *lmiTeamsname;
@property (strong, nonatomic) NSString *lmiContractprice;
@property (strong, nonatomic) NSString *lmiCurrentappro;
@property (strong, nonatomic) NSString *lmiCurrentspread;
@property (strong, nonatomic) NSString *lmiTotalappro;
@property (strong, nonatomic) NSString *lmiTotalspread;
@property (strong, nonatomic) NSString *lmiRemark;

@end
