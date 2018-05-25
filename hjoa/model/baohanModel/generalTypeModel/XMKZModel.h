//
//  XMKZModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface XMKZModel : JSONModel

@property (strong, nonatomic) NSString *stIdtype;
@property (strong, nonatomic) NSString *stIdnum;
@property (strong, nonatomic) NSString *stCreattime;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *uiPhone;

@property (strong, nonatomic) NSString *stProjectname;
@property (strong, nonatomic) NSString *stProjectidnum;
@property (strong, nonatomic) NSString *stProjectadress;
@property (strong, nonatomic) NSString *stConstruction;
@property (strong, nonatomic) NSString *stContractidnum;

@property (strong, nonatomic) NSString *stContractprice;
@property (strong, nonatomic) NSString *stProjectleader;
@property (strong, nonatomic) NSString *stProjectleaderphone;
@property (strong, nonatomic) NSString *stContracttime;
@property (strong, nonatomic) NSString *stSupervisor;

@property (strong, nonatomic) NSString *stStarttime;
@property (strong, nonatomic) NSString *stEndtime;
@property (strong, nonatomic) NSString *stStamptype;
@property (strong, nonatomic) NSString *stStampcarepople;
@property (strong, nonatomic) NSString *stStampphone;

@property (strong, nonatomic) NSString *stStampapple;
@property (strong, nonatomic) NSString *stStampusestartime;
@property (strong, nonatomic) NSString *stStampuseendtime;
@property (strong, nonatomic) NSString *stStampuseother;
@property (strong, nonatomic) NSString *stCash;
@property (strong, nonatomic) NSString *stCashmoney;
@property (strong, nonatomic) NSString *stStampseals;
@property (strong, nonatomic) NSString *stStampmoney;

@property (strong, nonatomic) NSString *stStampcontect;
@property (strong, nonatomic) NSString *stSpecimen;
@property (strong, nonatomic) NSString *stRemark;

@end
