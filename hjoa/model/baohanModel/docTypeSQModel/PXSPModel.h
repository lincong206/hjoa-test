//
//  PXSPModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface PXSPModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dtaDept;
@property (strong, nonatomic) NSString *dtaTraintype;
@property (strong, nonatomic) NSString *dtaTraincost;
@property (strong, nonatomic) NSString *dtaPayway;
@property (strong, nonatomic) NSString *dtaTrainnum;
@property (strong, nonatomic) NSString *dtaAddress;
@property (strong, nonatomic) NSString *dtaTime;
@property (strong, nonatomic) NSString *dtaTrainworktype;
@property (strong, nonatomic) NSString *dtaReason;
@property (strong, nonatomic) NSString *dtaOrganization;
@property (strong, nonatomic) NSString *dtaType;
@property (strong, nonatomic) NSString *dtaPaytype;
@property (strong, nonatomic) NSString *dtaIsagreement;
@property (strong, nonatomic) NSString *dtaRemark;

@end
