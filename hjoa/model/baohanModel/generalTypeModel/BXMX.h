//
//  BXMX.h
//  hjoa
//
//  Created by 华剑 on 2017/6/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface BXMX : JSONModel

@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *gedMoney;
@property (strong, nonatomic) NSString *gedUse;
@property (strong, nonatomic) NSString *gedRemark;

@property (strong, nonatomic) NSString *pcFmoney;
@property (strong, nonatomic) NSString *pcFcapitaluses;
@property (strong, nonatomic) NSString *pcFnote;

// 项目借款
@property (strong, nonatomic) NSString *pbedMoney;
@property (strong, nonatomic) NSString *pbedUse;
@property (strong, nonatomic) NSString *pbedRemark;
@end
