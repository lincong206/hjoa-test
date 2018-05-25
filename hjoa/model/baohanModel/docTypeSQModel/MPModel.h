//
//  MPModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface MPModel : JSONModel

@property (strong, nonatomic) NSString *dbcaIdnum;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dbcaDept;
@property (strong, nonatomic) NSString *dbcaPropeser;
@property (strong, nonatomic) NSString *dbcaDeptjob;
@property (strong, nonatomic) NSString *dbcaPhone;
@property (strong, nonatomic) NSString *dbcaModilephone;
@property (strong, nonatomic) NSString *dbcaEmail;
@property (strong, nonatomic) NSString *dbcaPrintnum;
@property (strong, nonatomic) NSString *dbcaApplydate;
@property (strong, nonatomic) NSString *dbcaAccomplishdate;
@property (strong, nonatomic) NSString *dbcaCardtype;
@property (strong, nonatomic) NSString *dbcaChargecase;
@property (strong, nonatomic) NSString *dbcaRemark;

@end
