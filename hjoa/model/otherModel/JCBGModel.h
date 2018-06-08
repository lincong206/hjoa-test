//
//  JCBGModel.h
//  hjoa
//
//  Created by 华剑 on 2017/12/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface JCBGModel : JSONModel

@property (strong, nonatomic) NSString *birIdnum;
@property (strong, nonatomic) NSString *birEntryperson;
@property (strong, nonatomic) NSString *birTime;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *bpcSupplyfee;
@property (strong, nonatomic) NSString *piAddresspca;
@property (strong, nonatomic) NSString *piAdress;
@property (strong, nonatomic) NSString *bpcRealcontractid;
@property (strong, nonatomic) NSString *bpcStartdate;
@property (strong, nonatomic) NSString *bpcWorkeddate;
@property (strong, nonatomic) NSString *birContent;
@property (strong, nonatomic) NSString *birExamined;
@property (strong, nonatomic) NSString *birInspectionresult;
@property (strong, nonatomic) NSString *birResultstate;

@end
