//
//  WPDHModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface WPDHModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *uiPsname;
@property (strong, nonatomic) NSString *dearCreatetime;
@property (strong, nonatomic) NSString *dearName;
@property (strong, nonatomic) NSString *dearPhone;
@property (strong, nonatomic) NSString *dearCoopername;
@property (strong, nonatomic) NSString *dearCoophone;
@property (strong, nonatomic) NSString *dearProname;
@property (strong, nonatomic) NSString *dearProaddress;
@property (strong, nonatomic) NSString *dearBegintime;
@property (strong, nonatomic) NSString *dearEndtime;
@property (strong, nonatomic) NSString *dearSendsalary;
@property (strong, nonatomic) NSString *dearOriginalsalary;
@property (strong, nonatomic) NSString *dearSituation;

@end
