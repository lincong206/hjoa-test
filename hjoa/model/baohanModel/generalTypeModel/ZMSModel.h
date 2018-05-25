//
//  ZMSModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ZMSModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *bpcLicensee;
@property (strong, nonatomic) NSString *bpcCertigier;
@property (strong, nonatomic) NSString *bpcCertigierposition;
@property (strong, nonatomic) NSString *bpcPhone;
@property (strong, nonatomic) NSString *bpcPermissions;
@property (strong, nonatomic) NSString *bpcLssuedate;
@property (strong, nonatomic) NSString *bpcValidity;
@property (strong, nonatomic) NSString *bpcAgentsex;
@property (strong, nonatomic) NSString *bpcAgentage;
@property (strong, nonatomic) NSString *bpcAgentposition;
@property (strong, nonatomic) NSString *bpcWorkno;
@property (strong, nonatomic) NSString *bpcAuthorizedunit;
@property (strong, nonatomic) NSString *bpcLegalperson;
@property (strong, nonatomic) NSString *bpcNote;
@property (strong, nonatomic) NSString *bpcLicensedcontent;

@end
