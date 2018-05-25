//
//  CFSPModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface CFSPModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dpaDept;
@property (strong, nonatomic) NSString *dpaCreatetime;
@property (strong, nonatomic) NSString *dpaProjectname;
@property (strong, nonatomic) NSString *dpaPartner;
@property (strong, nonatomic) NSString *dpaPartnerphone;
@property (strong, nonatomic) NSString *dpaType;
@property (strong, nonatomic) NSString *dpaOthertype;
@property (strong, nonatomic) NSString *dpaPunishgist;
@property (strong, nonatomic) NSString *dpaDisposeresult;
@property (strong, nonatomic) NSString *dpaContent;

@end
